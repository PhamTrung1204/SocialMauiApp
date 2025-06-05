using Microsoft.AspNetCore.Http;
using Refit;
using SocialMauiApp.Models;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Apis;

public interface IUserApi
{
    [Multipart]
    [Post("/api/user/change-photo")]
    Task<ApiResult<string>> ChangePhotoAsync([Header("Authorization")] string token, StreamPart photo);

    [Get("/api/user/posts")]
    Task<PostDto[]> GetUserPostsAsync([Header("Authorization")] string token, int startIndex, int pageSize);

    [Get("/api/user/bookmarked-posts")]
    Task<PostDto[]> GetUserBookmarkedPostsAsync([Header("Authorization")] string token, int startIndex, int pageSize);

    [Get("/api/user/notifications")]
    Task<NotificationDto[]> GetNotificationAsync([Header("Authorization")] string token, int startIndex, int pageSize);

    [Post("/api/user/change-password")]
    Task<ApiResult<string>> ChangePasswordAsync([Header("Authorization")] string token, [Body] ChangePasswordDto dto);

    [Post("/api/user/change-name")]
    Task<ApiResult<string>> ChangeNameAsync([Header("Authorization")] string token, [Body] ChangeNameDto dto);
}