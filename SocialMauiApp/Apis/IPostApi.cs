using Refit;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Apis;

[Headers("Authorization: Bearer")]
public interface IPostApi
{
    [Multipart]
    [Post("/api/posts/save")]
    Task<ApiResult<PostDto>> SavePostAsync(StreamPart? photo, string serializedSavePostDto);
    [Get("/api/posts")]
    Task<PostDto[]> GetPostsAsync(int startIndex, int pageSize);
    [Post("/api/posts/{postId}/comments")]
    Task<ApiResult<CommentDto>> SaveCommentAsync(Guid postId, SaveCommentDto dto);
    [Get("/api/posts/{postId}/comments")]
    Task<CommentDto[]> GetPostsCommentAsync(Guid postId, int startIndex, int pageSize);
    [Put("/api/posts/comments/{commentId}")]
    Task<ApiResult<CommentDto>> UpdateCommentAsync(Guid commentId, [Body] UpdateCommentDto dto);
    [Delete("/api/posts/comments/{commentId}")]
    Task<ApiResult> DeleteCommentAsync(Guid commentId);
    
    [Multipart]
    [Post("/api/posts/{postId}/upload-photo")]
    Task<ApiResult<CommentDto>> SaveCommentWithImagesAsync(
    Guid postId,
    [AliasAs("photo")] StreamPart? image,
    [AliasAs("serializedCommentDto")] string serializedCommentDto
);
    [Multipart]
    [Put("/api/posts/comments/{commentId}/upload-photo")]
    Task<ApiResult<CommentDto>> UpdateCommentWithImagesAsync(
    Guid commentId,
    [AliasAs("photo")] StreamPart? image,
    [AliasAs("serializedCommentDto")] string serializedCommentDto
);



    [Post("/api/posts/{postId}/toggle-like")]
    Task<ApiResult> ToggleLikeAsync(Guid postId);
    [Post("/api/posts/{postId}/toggle-bookmark")]
    Task<ApiResult> ToggleBookmarkAsync(Guid postId);
    [Delete("/api/posts/{postId}")]
    Task<ApiResult> DeletePostAsync(Guid postId);
    [Get("/api/posts/{postId}")]
    Task<PostDto?> GetPostAsync(Guid postId);
}
