using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMauiApp.Api.Endpoints;
using SocialMauiApp.Api.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();


var connectionString = builder.Configuration.GetConnectionString("SocialConnection");
builder.Services.AddDbContext<DataContext>(options =>
{
    options.UseSqlServer(connectionString);
});
builder.Services.AddTransient<AuthService>()
    .AddTransient<PostService>()
    .AddTransient<IPasswordHasher<User>, PasswordHasher<User>>()
    .AddTransient<UserService>()
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

builder.Services.AddAuthorization();

var app = builder.Build();
#if DEBUG
AutoMigrationDb(app.Services);
#endif 
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();
app.Use(async (httpContext, next) =>
{
    httpContext.Request.Headers.TryGetValue("Authorization", out var value);
    await next();
});
app.UseAuthentication()
    .UseAuthorization();
app.MapAuthEndpoints()
    .MapPostsEndpoints()
    .MapUserEndpoints();
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