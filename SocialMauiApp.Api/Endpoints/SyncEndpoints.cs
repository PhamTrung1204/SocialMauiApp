using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using SocialMauiApp.Api.Data.Entities;
using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.ObjectModel;
namespace SocialMauiApp.Api.Endpoints
{
    public static class SyncEndpoints
    {
        public static IEndpointRouteBuilder MapSyncEndpoints(this IEndpointRouteBuilder app)
        {
            var syncGroup = app.MapGroup("/api/sync")
                .RequireAuthorization()
                .WithTags("Sync");

            // Endpoint kích hoạt đồng bộ toàn bộ
            syncGroup.MapPost("/", async (SyncService syncService) =>
            {
                await syncService.SynchronizeAsync();
                return Results.Ok(new { Message = "Synchronization completed successfully." });
            })
                .Produces<object>()
                .WithName("SynchronizeData");

            // Endpoint lấy Post từ SQL Server dựa trên thời gian
            syncGroup.MapGet("/posts", async (DateTime since, SyncService syncService) =>
            {
                var posts = await syncService.GetPostsSinceAsync(since);
                return Results.Ok(posts);
            })
                .Produces<Post[]>()
                .WithName("GetPostsSince");

            // Endpoint cập nhật hoặc chèn Post vào SQL Server
            syncGroup.MapPost("/posts/upsert", async (List<Post> posts, SyncService syncService) =>
            {
                var success = await syncService.UpsertPostsAsync(posts);
                return success
                    ? Results.Ok(new { Message = "Posts upserted successfully." })
                    : Results.BadRequest(new { Message = "Failed to upsert posts." });
            })
                .Produces<object>()
                .WithName("UpsertPosts");

            // Endpoint lấy Comment từ SQL Server dựa trên thời gian
            syncGroup.MapGet("/comments", async (DateTime since, Guid postId, SyncService syncService) =>
            {
                var comments = await syncService.GetCommentsSinceAsync(since, postId);
                return Results.Ok(comments);
            })
     .Produces<Comment[]>()
     .WithName("GetCommentsSince");

            // Endpoint cập nhật hoặc chèn Comment vào SQL Server
            syncGroup.MapPost("/comments/upsert", async (List<Comment> comments, SyncService syncService) =>
            {
                var success = await syncService.UpsertCommentsAsync(comments);
                return success
                    ? Results.Ok(new { Message = "Comments upserted successfully." })
                    : Results.BadRequest(new { Message = "Failed to upsert comments." });
            })
                .Produces<object>()
                .WithName("UpsertComments");

            return app;
        }
    }
}