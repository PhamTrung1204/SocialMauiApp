using Refit;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Threading.Tasks;

namespace SocialMauiApp.Apis
{
    [Headers("Authorization: Bearer")]
    public interface IPostApi
    {
        [Multipart]
        [Post("/api/posts/save")]
        Task<ApiResult<PostDto>> SavePostAsync([AliasAs("photo")] StreamPart? photo, [AliasAs("serializedSavePostDto")] string serializedSavePostDto);

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
        [Post("/api/posts/{postId}/comments/reply/upload-photo")]
        Task<ApiResult<CommentDto>> ReplyCommentWithImagesAsync(Guid postId, [AliasAs("photo")] StreamPart? photo, [AliasAs("serializedCommentDto")] string serializedCommentDto);

        [Multipart]
        [Post("/api/posts/{postId}/upload-photo")]
        Task<ApiResult<CommentDto>> SaveCommentWithImagesAsync(Guid postId, [AliasAs("photo")] StreamPart? photo, [AliasAs("serializedCommentDto")] string serializedCommentDto);

        [Multipart]
        [Put("/api/posts/comments/{commentId}/upload-photo")]
        Task<ApiResult<CommentDto>> UpdateCommentWithImagesAsync(Guid commentId, [AliasAs("photo")] StreamPart? photo, [AliasAs("serializedCommentDto")] string serializedCommentDto);

        [Delete("/api/post/delete-comment-with-children/{commentId}")]
        Task<ApiResult> DeleteCommentWithChildrenAsync(Guid commentId);

        [Post("/api/posts/{postId}/toggle-like")]
        Task<ApiResult> ToggleLikeAsync(Guid postId);

        [Post("/api/posts/{postId}/toggle-bookmark")]
        Task<ApiResult> ToggleBookmarkAsync(Guid postId);

        [Delete("/api/posts/{postId}")]
        Task<ApiResult> DeletePostAsync(Guid postId);

        [Get("/api/posts/{postId}")]
        Task<PostDto?> GetPostAsync(Guid postId);

        [Get("/api/posts/{postId}/likers")]
        Task<string[]> GetPostLikersAsync(Guid postId);
    }
}