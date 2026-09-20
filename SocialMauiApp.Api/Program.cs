using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.HttpOverrides;
using Npgsql;
using System.Threading.RateLimiting;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMauiApp.Api.Endpoints;
using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared;

var builder = WebApplication.CreateBuilder(args);

// Render (and most PaaS) inject PORT and expect the app to bind it.
var assignedPort = Environment.GetEnvironmentVariable("PORT");
if (!string.IsNullOrWhiteSpace(assignedPort)
    && string.IsNullOrWhiteSpace(Environment.GetEnvironmentVariable("ASPNETCORE_URLS")))
{
    builder.WebHost.UseUrls($"http://0.0.0.0:{assignedPort}");
}

builder.Services.AddOpenApi();

builder.Services.AddDbContext<SQLiteContext>((serviceProvider, options) =>
{
    var env = serviceProvider.GetRequiredService<IWebHostEnvironment>();
    var dataDirectory = Path.Combine(env.ContentRootPath, "Data");
    Directory.CreateDirectory(dataDirectory);
    options.UseSqlite($"Filename={Path.Combine(dataDirectory, "socialmauiapp.db")}");
});

var connectionString = builder.Configuration.GetConnectionString("SocialConnection")
    ?? Environment.GetEnvironmentVariable("DATABASE_URL");
if (string.IsNullOrWhiteSpace(connectionString))
{
    throw new InvalidOperationException(
        "Connection string 'SocialConnection' is not configured. Set ConnectionStrings__SocialConnection.");
}
connectionString = NormalisePostgresConnectionString(connectionString);

builder.Services.AddDbContext<DataContext>(options => options.UseNpgsql(connectionString));

builder.Services.AddTransient<AuthService>()
    .AddTransient<PostService>()
    .AddTransient<AdminService>()
    .AddScoped<SyncService>()
    .AddTransient<IPasswordHasher<User>, PasswordHasher<User>>()
    .AddScoped<UserService>()
    .AddScoped<FriendService>()
    .AddScoped<NotificationService>()
    .AddTransient<PhotoUploadService>();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    var issuer = builder.Configuration.GetValue<string>("Jwt:Issuer");
    var secretKey = builder.Configuration.GetValue<string>("Jwt:SecretKey");
    if (string.IsNullOrWhiteSpace(secretKey))
    {
        throw new InvalidOperationException("'Jwt:SecretKey' is not configured. Set Jwt__SecretKey.");
    }

    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidIssuer = issuer,
        ValidateIssuer = true,
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(secretKey)),
        ValidateAudience = false,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.FromSeconds(30)
    };

    // Khóa tài khoản phải có hiệu lực NGAY, không đợi access token hết hạn.
    options.Events = new JwtBearerEvents
    {
        OnTokenValidated = async context =>
        {
            var subject = context.Principal?.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!Guid.TryParse(subject, out var userId))
            {
                context.Fail("Token has no valid subject.");
                return;
            }

            var db = context.HttpContext.RequestServices.GetRequiredService<DataContext>();
            var state = await db.Users
                .Where(u => u.Id == userId)
                .Select(u => new { u.IsLocked })
                .FirstOrDefaultAsync();

            if (state is null)
            {
                context.Fail("Account no longer exists.");
            }
            else if (state.IsLocked)
            {
                context.Fail("Account is locked.");
            }
        }
    };
});

// Chặn dò mật khẩu: giới hạn nhịp gọi các endpoint xác thực.
builder.Services.AddRateLimiter(options =>
{
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
    options.AddFixedWindowLimiter("auth", limiter =>
    {
        limiter.PermitLimit = 10;
        limiter.Window = TimeSpan.FromMinutes(1);
        limiter.QueueLimit = 0;
    });
});

// Video tối đa 60 MB -> nới giới hạn body của Kestrel (mặc định chỉ 30 MB).
const long MaxUploadBytes = 80L * 1024 * 1024;

builder.WebHost.ConfigureKestrel(options =>
{
    options.Limits.MaxRequestHeadersTotalSize = 32768;
    options.Limits.MaxRequestBodySize = MaxUploadBytes;
});

builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = MaxUploadBytes;
});

builder.Logging.ClearProviders();
builder.Logging.AddConsole();
#if DEBUG
builder.Logging.AddDebug();
#endif

builder.Services.AddAuthorization();
builder.Services.AddSignalR();

// PaaS hosts (Render/Railway/Fly/App Service) terminate TLS at their proxy and
// forward plain HTTP. Without this the app sees http://, which breaks
// UseHttpsRedirection (redirect loop) and logs the proxy IP as the client.
builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto | ForwardedHeaders.XForwardedHost;
    options.KnownNetworks.Clear();
    options.KnownProxies.Clear();
});

var app = builder.Build();

await InitializeDatabasesAsync(app);

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseForwardedHeaders();
app.UseStaticFiles();

if (app.Configuration.GetValue("Hosting:UseHttpsRedirection", true))
{
    app.UseHttpsRedirection();
}
app.UseRateLimiter();
app.UseAuthentication()
    .UseAuthorization();
app.MapAuthEndpoints()
    .MapSyncEndpoints()
    .MapAdminEndpoints()
    .MapPostsEndpoints()
    .MapUserEndpoints()
    .MapFriendEndpoints();
app.MapHub<SocialHub>(AppConstants.HubPattern);

// Render's health check needs a 2xx from an endpoint that does NOT require auth.
app.MapGet("/health", async (DataContext db) =>
    await db.Database.CanConnectAsync()
        ? Results.Ok(new { status = "healthy" })
        : Results.StatusCode(StatusCodes.Status503ServiceUnavailable))
    .AllowAnonymous()
    .WithName("Health");

app.Run();

static async Task InitializeDatabasesAsync(WebApplication app)
{
    using var scope = app.Services.CreateScope();
    var logger = scope.ServiceProvider.GetRequiredService<ILoggerFactory>().CreateLogger("Startup");

    var sqliteContext = scope.ServiceProvider.GetRequiredService<SQLiteContext>();
    await sqliteContext.Database.EnsureCreatedAsync();
    logger.LogInformation("Local SQLite cache is ready.");

    if (!app.Configuration.GetValue("Database:AutoMigrate", true))
    {
        return;
    }

    var dataContext = scope.ServiceProvider.GetRequiredService<DataContext>();

    // Trong Docker Compose, API có thể khởi động trước khi PostgreSQL nhận kết nối.
    const int maxAttempts = 10;
    for (var attempt = 1; ; attempt++)
    {
        try
        {
            await dataContext.Database.MigrateAsync();
            logger.LogInformation("PostgreSQL migrations applied.");
            return;
        }
        catch (Exception ex) when (attempt < maxAttempts)
        {
            logger.LogWarning("PostgreSQL not ready (attempt {Attempt}/{Max}): {Message}", attempt, maxAttempts, ex.Message);
            await Task.Delay(TimeSpan.FromSeconds(3));
        }
    }
}

// Accepts either Npgsql key=value form or a postgres://user:pass@host:port/db URI
// (what Render, Railway and Heroku expose), so the same image works on all of them.
static string NormalisePostgresConnectionString(string value)
{
    if (!value.StartsWith("postgres://", StringComparison.OrdinalIgnoreCase)
        && !value.StartsWith("postgresql://", StringComparison.OrdinalIgnoreCase))
    {
        return value;
    }

    var uri = new Uri(value);
    var credentials = uri.UserInfo.Split(':', 2);

    var csb = new NpgsqlConnectionStringBuilder
    {
        Host = uri.Host,
        Port = uri.IsDefaultPort ? 5432 : uri.Port,
        Database = uri.AbsolutePath.Trim('/'),
        Username = Uri.UnescapeDataString(credentials[0]),
        Password = credentials.Length > 1 ? Uri.UnescapeDataString(credentials[1]) : string.Empty
    };

    foreach (var pair in uri.Query.TrimStart('?').Split('&', StringSplitOptions.RemoveEmptyEntries))
    {
        var kv = pair.Split('=', 2);
        if (kv.Length == 2 && kv[0].Equals("sslmode", StringComparison.OrdinalIgnoreCase)
            && Enum.TryParse<SslMode>(kv[1], true, out var sslMode))
        {
            csb.SslMode = sslMode;
        }
    }

    return csb.ConnectionString;
}
