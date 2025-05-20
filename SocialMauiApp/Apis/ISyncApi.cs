using Refit;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SocialMauiApp.Apis
{
    [Headers("Authorization: Bearer")]
    public interface ISyncApi
    {
        [Post("/api/sync")]
        Task<ApiResult> SynchronizeAsync();

        [Get("/api/sync/posts")]
        Task<PostDto[]> GetPostsSinceAsync(DateTime since);

        [Post("/api/sync/posts/upsert")]
        Task<ApiResult> UpsertPostsAsync([Body] List<PostDto> posts);

        [Get("/api/sync/comments")]
        Task<CommentDto[]> GetCommentsSinceAsync(DateTime since, Guid postId);

        [Post("/api/sync/comments/upsert")]
        Task<ApiResult> UpsertCommentsAsync([Body] List<CommentDto> comments);
    }
}