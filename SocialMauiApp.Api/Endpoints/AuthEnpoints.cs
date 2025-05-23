using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Api.Endpoints
{
    public static class AuthEndpoints
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
                var authHeader = context.Request.Headers["Authorization"].ToString();
                if (string.IsNullOrEmpty(authHeader) || !authHeader.StartsWith("Bearer "))
                    return Results.Unauthorized();

                var token = authHeader.Substring("Bearer ".Length).Trim();
                var result = await authService.ValidateTokenAsync(token);
                return Results.Ok(result);
            })
                .Produces<ApiResult<LoggedInUser>>()
                .WithName("Auth-ValidateToken");

            authGroup.MapGet("/verify-email", async (string token, AuthService authService) =>
            {
                var result = await authService.VerifyEmailAsync(token);
                if (result.IsSuccess)
                {
                    // Redirect client to the deep link
                    return Results.Redirect(result.Data); // e.g., "socialmauiapp://RegisterPage?verified=true"
                }
                return Results.BadRequest(new { message = result.Error });
            })
            .Produces<ApiResult<string>>()
            .WithName("Auth-VerifyEmail");

            authGroup.MapPost("/send-verification-email", async (SendVerificationEmailDto dto, AuthService authService) =>
                Results.Ok(await authService.SendVerificationEmailAsync(dto)))
                .Produces<ApiResult<string>>()
                .WithName("Auth-SendVerificationEmail");

            authGroup.MapPost("/request-password-reset", async (PasswordResetRequestDto dto, AuthService authService) =>
                Results.Ok(await authService.RequestPasswordResetAsync(dto)))
                .Produces<ApiResult<string>>()
                .WithName("Auth-RequestPasswordReset");

            authGroup.MapPost("/reset-password", async (ResetPasswordDto dto, AuthService authService) =>
                Results.Ok(await authService.ResetPasswordAsync(dto)))
                .Produces<ApiResult<string>>()
                .WithName("Auth-ResetPassword");

            return app;
        }
    }
}