// Apis/IAuthApi.cs
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

        // Thêm endpoint gửi email xác nhận
        [Post("/api/auth/send-verification-email")]
        Task<ApiResult<string>> SendVerificationEmailAsync([Body] SendVerificationEmailDto dto);

        // Thêm endpoint xác minh email
        [Get("/api/auth/verify-email")]
        Task<ApiResult<string>> VerifyEmailAsync(string token);

        // Thêm endpoint yêu cầu đổi mật khẩu
        [Post("/api/auth/request-password-reset")]
        Task<ApiResult<string>> RequestPasswordResetAsync([Body] PasswordResetRequestDto dto);

        // Thêm endpoint xác minh và đổi mật khẩu
        [Post("/api/auth/reset-password")]
        Task<ApiResult<string>> ResetPasswordAsync([Body] ResetPasswordDto dto);
    }
}