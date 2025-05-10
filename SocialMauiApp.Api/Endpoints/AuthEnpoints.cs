using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Api.Endpoints
{
    public static class AuthEnpoints
    {

        public static IEndpointRouteBuilder MapAuthEndpoints(this IEndpointRouteBuilder app)
        {
            var authGroup = app.MapGroup("/api/auth")
                .WithTags("Auth");

            authGroup.MapPost("/register", async (RegisterDto dto, AuthService authService) =>
            Results.Ok(await authService.RegisterAsync(dto)))
                .Produces<ApiResult<Guid>>()
                .WithName("Auth-Register");

            authGroup.MapPost("/register/{userId:guid}/add-photo", async (Guid userId, IFormFile photo, AuthService authService) =>
            Results.Ok(await authService.UploadPhotoAsync(userId, photo)))
                .DisableAntiforgery()
                .Produces<ApiResult>()
                .WithName("Auth-AddPhoto-to-User");

            authGroup.MapPost("/login", async (LoginDto dto, AuthService authService) =>
            Results.Ok(await authService.LoginAsync(dto)))
                .Produces<ApiResult<LoginResponseDto>>()
                .WithName("Auth-Login");
            authGroup.MapGet("/validate", async (HttpContext context, AuthService authService) =>
            {
                // Extract token from Authorization header
                var authHeader = context.Request.Headers["Authorization"].ToString();
                if (string.IsNullOrEmpty(authHeader) || !authHeader.StartsWith("Bearer "))
                    return Results.Unauthorized();

                var token = authHeader.Substring("Bearer ".Length).Trim();

                // Call a new method in AuthService to validate the token
                var result = await authService.ValidateTokenAsync(token);
                return Results.Ok(result);
            })
                .Produces<ApiResult<LoggedInUser>>()
                .WithName("Auth-ValidateToken");
            return app;
        }
    }
}