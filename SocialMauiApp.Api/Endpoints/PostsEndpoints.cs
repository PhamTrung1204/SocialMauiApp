using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Security.Claims;
using System.Text.Json;

namespace SocialMauiApp.Api.Endpoints
{
    public static class PostsEndpoints
    {
        public static IEndpointRouteBuilder MapPostsEndpoints(this IEndpointRouteBuilder app)
        {
            var postsGroup = app.MapGroup("/api/posts")
                .RequireAuthorization()
                .WithTags("Posts");

            postsGroup.MapPost("/save", async ([FromForm] IFormFile? photo, [FromForm] string serializedSavePostDto, PostService postService, ClaimsPrincipal principal) =>
            {
                if (string.IsNullOrWhiteSpace(serializedSavePostDto))
                    return Results.BadRequest("Missing data");

                SavePostDto dto = JsonSerializer.Deserialize<SavePostDto>(serializedSavePostDto)!;
                dto.Photo = photo;

                return Results.Ok(await postService.SavePostAsync(dto, principal.GetUser()));
            })
                .DisableAntiforgery()
                .Produces<ApiResult<PostDto>>()
                .WithName("SavePost");

            postsGroup.MapGet("/", async (int startIndex, int pageSize, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.GetPostsAsync(startIndex, pageSize, principal.GetUserId())))
                .Produces<PostDto[]>()
                .WithName("GetPosts");

            postsGroup.MapPost("/{postId:guid}/comments",
                async (Guid postId, SaveCommentDto dto, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.SaveCommentAsync(dto, principal.GetUser())))
                .Produces<ApiResult<CommentDto>>()
                .WithName("SaveComment");

            postsGroup.MapGet("/{postId:guid}/comments", async (Guid postId, int startIndex, int pageSize, PostService postService) =>
                Results.Ok(await postService.GetPostsCommentAsync(postId, startIndex, pageSize)))
                .Produces<CommentDto[]>()
                .WithName("GetPostComments");

            postsGroup.MapPut("/comments/{commentId:guid}",
                async (Guid commentId, [FromBody] UpdateCommentDto dto, PostService postService, ClaimsPrincipal principal) =>
                {
                    var result = await postService.UpdateCommentAsync(commentId, dto, principal.GetUser());
                    return Results.Ok(result);
                })
                .Accepts<UpdateCommentDto>("application/json")
                .Produces<ApiResult<CommentDto>>()
                .WithName("UpdateComment");

            postsGroup.MapPut("/comments/{commentId:guid}/upload-photo",
                async (Guid commentId, [FromForm(Name = "photo")] IFormFile? photo, [FromForm(Name = "serializedCommentDto")] string serializedCommentDto, PostService postService, ClaimsPrincipal principal) =>
                {
                    if (string.IsNullOrWhiteSpace(serializedCommentDto))
                        return Results.BadRequest("Missing comment data");

                    try
                    {
                        var dto = JsonSerializer.Deserialize<UpdateCommentDto>(serializedCommentDto);
                        if (dto == null)
                            return Results.BadRequest("Invalid comment data");

                        dto.Photo = photo;
                        var result = await postService.UpdateCommentWithImageAsync(commentId, dto, principal.GetUser());
                        return Results.Ok(result);
                    }
                    catch (JsonException ex)
                    {
                        return Results.BadRequest($"Invalid JSON format: {ex.Message}");
                    }
                })
                .DisableAntiforgery()
                .Accepts<IFormFile>("multipart/form-data")
                .Produces<ApiResult<CommentDto>>()
                .WithName("UpdateCommentWithImages");

            postsGroup.MapDelete("/comments/{commentId:guid}",
                async (Guid commentId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.DeleteCommentAsync(commentId, principal.GetUser())))
                .Produces<ApiResult>()
                .WithName("DeleteComment");

            postsGroup.MapPost("/{postId:guid}/toggle-like",
                async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.ToggleLikeAsync(postId, principal.GetUser())))
                .Produces<ApiResult>()
                .WithName("ToggleLike");

            postsGroup.MapPost("/{postId:guid}/toggle-bookmark",
                async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.ToggleBookmarkAsync(postId, principal.GetUser())))
                .Produces<ApiResult>()
                .WithName("ToggleBookmark");

            postsGroup.MapDelete("/{postId:guid}",
                async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.DeletePostAsync(postId, principal.GetUserId())))
                .Produces<ApiResult>()
                .WithName("DeletePost");

            postsGroup.MapGet("/{postId:guid}", async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.GetPostAsync(postId, principal.GetUserId())))
                .Produces<PostDto>()
                .WithName("GetPostById");

            postsGroup.MapPost("/{postId:guid}/upload-photo",
                async (Guid postId, [FromForm(Name = "photo")] IFormFile? photo, [FromForm(Name = "serializedCommentDto")] string serializedCommentDto, PostService postService, ClaimsPrincipal user) =>
                {
                    var dto = JsonSerializer.Deserialize<SaveCommentDto>(serializedCommentDto)!;
                    dto.Photo = photo;
                    var result = await postService.SaveCommentAsync(dto, user.GetUser());
                    return Results.Ok(result);
                })
                .DisableAntiforgery()
                .Accepts<IFormFile>("multipart/form-data")
                .Produces<ApiResult<CommentDto>>()
                .WithName("SaveCommentWithImages");

            postsGroup.MapPost("/{postId:guid}/comments/reply/upload-photo",
                async (Guid postId, [FromForm(Name = "photo")] IFormFile? photo, [FromForm(Name = "serializedCommentDto")] string serializedCommentDto, PostService postService, ClaimsPrincipal user) =>
                {
                    var dto = JsonSerializer.Deserialize<SaveCommentDto>(serializedCommentDto)!;
                    dto.Photo = photo;
                    var result = await postService.SaveCommentAsync(dto, user.GetUser());
                    return Results.Ok(result);
                })
                .DisableAntiforgery()
                .Accepts<IFormFile>("multipart/form-data")
                .Produces<ApiResult<CommentDto>>()
                .WithName("ReplyCommentWithImages");
            postsGroup.MapGet("/{postId:guid}/likers",
                 async (Guid postId, PostService postService) =>
                 Results.Ok(await postService.GetPostLikersAsync(postId)))
                 .Produces<string[]>()
                 .WithName("GetPostLikers");
            return app;
        }
    }
}