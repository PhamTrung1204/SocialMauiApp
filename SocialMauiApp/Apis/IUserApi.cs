using Microsoft.AspNetCore.Http;
using Refit;
using SocialMediaMaui.Shared.Dtos;



namespace SocialMauiApp.Apis;

public interface IUserApi
{
    [Post("api/user/change-photo")]
    Task<ApiResult<string>> ChangePhotoAsync(IFormFile photo);
    [Get("api/user/posts")]
    Task<PostDto[]> GetUserPostsAsync(int startIndex, int pageSize);
    [Get("api/user/bookmarked-posts")]
    Task<PostDto[]> GetUserBookmarkedPostsAsync(int startIndex, int pageSize);
}
