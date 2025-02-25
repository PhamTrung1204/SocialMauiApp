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

            //postsGroup.MapPost("/save", async (SavePostDto dto, PostService postService, ClaimsPrincipal principal) =>
            //    Results.Ok(await postService.SavePostAsync(dto, principal.GetUserId())))
            //    .Produces<ApiResult>()
            //    .WithName("SavePost");
            postsGroup.MapPost("/save", async ([FromForm] IFormFile? photo, [FromForm] string serializedSavePhotoDto, PostService postService, ClaimsPrincipal principal) =>
               {
                   if (string.IsNullOrWhiteSpace(serializedSavePhotoDto)) return Results.BadRequest("Missing data");

                   SavePostDto dto = JsonSerializer.Deserialize<SavePostDto>(serializedSavePhotoDto)!;
                   dto.Photo = photo;
                   Results.Ok(await postService.SavePostAsync(dto, principal.GetUserId()));
                   return Results.Ok(await postService.SavePostAsync(dto, principal.GetUserId()));
               })
                .Produces<ApiResult>()
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

            postsGroup.MapPost("/{postId:guid}/toggle-like",
                async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.ToggleLikeAsync(postId, principal.GetUserId())))
                .Produces<ApiResult>()
                .WithName("ToggleLike");

            postsGroup.MapPost("/{postId:guid}/toggle-bookmark",
                async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.ToggleBookmarkAsync(postId, principal.GetUserId())))
                .Produces<ApiResult>()
                .WithName("ToggleBookmark");

            postsGroup.MapDelete("/{postId:guid}",
                async (Guid postId, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.DeletePostAsync(postId, principal.GetUserId())))
                .Produces<ApiResult>()
                .WithName("DeletePost");

            return app;
        }
    }
}