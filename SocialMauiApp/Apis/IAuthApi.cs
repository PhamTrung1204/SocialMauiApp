using Refit;
using SocialMediaMaui.Shared.Dtos;
using System.IO;
using System.Threading.Tasks;

namespace SocialMauiApp.Apis
{
    public interface IAuthApi
    {
        [Post("/api/auth/register")]
        Task<ApiResult<Guid>> RegisterAsync([Body] RegisterDto dto);

        [Multipart]
        [Post("/api/auth/register/{userId}/add-photo")]
        Task<ApiResult> UploadPhotoAsync(Guid userId, [AliasAs("photo")] StreamPart photo);

        [Post("/api/auth/login")]
        Task<ApiResult<LoginResponseDto>> LoginAsync([Body] LoginDto dto);

        [Get("/api/auth/validate")]
        Task<ApiResult<LoggedInUser>> ValidateTokenAsync([Header("Authorization")] string bearerToken);

        [Post("/api/auth/send-verification-email")]
        Task<ApiResult<string>> SendVerificationEmailAsync([Body] SendVerificationEmailDto dto);

        [Get("/api/auth/verify-email")]
        Task<ApiResult<string>> VerifyEmailAsync(string token);

        [Post("/api/auth/request-password-reset")]
        Task<ApiResult<string>> RequestPasswordResetAsync([Body] PasswordResetRequestDto dto);

        [Get("/api/auth/verify-reset-token")]
        Task<ApiResult<string>> VerifyResetTokenAsync(string token);

        [Post("/api/auth/reset-password")]
        Task<ApiResult<string>> ResetPasswordAsync([Body] ResetPasswordDto dto);
    }
}