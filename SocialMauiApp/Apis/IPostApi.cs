using Refit;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Apis;

[Headers("Authorization: Bearer")]
public interface IPostApi
{
    [Multipart]
    [Post("/api/posts/save")]
    Task<ApiResult> SavePostAsync(StreamPart? photo,string serializedSavePostDto);
    [Get("/api/posts")]
    Task<PostDto[]> GetPostsAsync(int startIndex, int pageSize);
    [Post("/api/posts/{postId}/comments")]
    Task<ApiResult<CommentDto>> SaveCommentAsync(Guid postId, SaveCommentDto dto);
    [Get("/api/posts/{postId}/comments")]
    Task<CommentDto[]> GetPostsCommentAsync(Guid postId, int startIndex, int pageSize);
    [Post("/api/posts/{postId}/toggle-like")]
    Task<ApiResult> ToggleLikeAsync(Guid postId);
    [Post("/api/posts/{postId}/toggle-bookmark")]
    Task<ApiResult> ToggleBookmarkAsync(Guid postId);
    [Delete("/api/posts/{postId}")]
    Task<ApiResult> DeletePostAsync(Guid postId);
}
