using Refit;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Apis;

public interface IAuthApi
{
    [Post("/api/auth/register")]
    Task<ApiResult<Guid>> RegisterAsync(RegisterDto dto);

    [Multipart]
    [Post("/api/auth/register/{userId}/add-photo")]
    Task<ApiResult> UploadPhotoAsync(Guid userId, StreamPart photo);

    [Post("/api/auth/login")]
    Task<ApiResult<LoginResponseDto>> LoginAsync(LoginDto dto);

    [Get("/api/auth/validate")]
    Task<ApiResult<LoggedInUser>> ValidateTokenAsync([Header("Authorization")] string bearerToken);
}
