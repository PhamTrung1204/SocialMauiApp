using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMauiApp.Api.Endpoints;
using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddOpenApi();
builder.Services.AddSingleton<IWebHostEnvironment>(builder.Environment);
builder.Services.AddDbContext<SQLiteContext>((serviceProvider, options) =>
{
    var env = serviceProvider.GetRequiredService<IWebHostEnvironment>();
    var dataDirectory = Path.Combine(env.ContentRootPath, "Data");
    if (!Directory.Exists(dataDirectory))
    {
        Directory.CreateDirectory(dataDirectory);
        Console.WriteLine($"Created Data directory at {dataDirectory} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
    }

    var dbPath = Path.Combine(dataDirectory, "socialmauiapp.db");
    Console.WriteLine($"SQLite database path: {dbPath} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
    options.UseSqlite($"Filename={dbPath}");
});

var connectionString = builder.Configuration.GetConnectionString("SocialConnection");
builder.Services.AddDbContext<DataContext>(options =>
{
    options.UseSqlServer(connectionString);
});
builder.Services.AddTransient<AuthService>()
    .AddTransient<PostService>()
    .AddTransient<AdminService>()
    .AddScoped<SyncService>()
    .AddTransient<IPasswordHasher<User>, PasswordHasher<User>>()
    .AddScoped<UserService>()
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
    var securityKey = System.Text.Encoding.UTF8.GetBytes(secretKey);
    var symmetricKey = new SymmetricSecurityKey(securityKey);

    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidIssuer = issuer,
        ValidateIssuer = true,
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = symmetricKey,
        ValidateAudience = false
    };
});
builder.WebHost.ConfigureKestrel(options =>
{
    options.Limits.MaxRequestHeadersTotalSize = 32768;
});
builder.Logging.ClearProviders();
builder.Logging.AddConsole();
#if DEBUG
builder.Logging.AddDebug();
#endif

builder.Services.AddAuthorization();
builder.Services.AddSignalR();

var app = builder.Build();
using (var scope = app.Services.CreateScope())
{
    var sqliteContext = scope.ServiceProvider.GetRequiredService<SQLiteContext>();
    sqliteContext.Database.EnsureCreated();
    Console.WriteLine($"SQLite database ensured created at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
}
#if DEBUG
AutoMigrationDb(app.Services);
#endif

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseStaticFiles();
app.UseHttpsRedirection();
app.Use(async (httpContext, next) =>
{
    httpContext.Request.Headers.TryGetValue("Authorization", out var value);
    await next();
});
app.UseAuthentication()
    .UseAuthorization();
app.MapAuthEndpoints()
    .MapSyncEndpoints()
    .MapAdminEndpoints()
    .MapPostsEndpoints()
    .MapUserEndpoints();
app.MapHub<SocialHub>(AppConstants.HubPattern);
app.Run();

static void AutoMigrationDb(IServiceProvider sp)
{
    var scope = sp.CreateScope();
    var context = scope.ServiceProvider.GetRequiredService<DataContext>();
    if (context.Database.GetPendingMigrations().Any())
    {
        context.Database.Migrate();
    }
}