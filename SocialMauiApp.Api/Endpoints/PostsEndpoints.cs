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

            // Cập nhật bình luận
            postsGroup.MapPut("/comments/{commentId:guid}",
                async (Guid commentId, [FromBody] string updatedContent, PostService postService, ClaimsPrincipal principal) =>
                Results.Ok(await postService.UpdateCommentAsync(commentId, updatedContent, principal.GetUser())))
                .Produces<ApiResult<CommentDto>>()
                .WithName("UpdateComment");

            // Xoá bình luận
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
            // Endpoint upload ảnh riêng biệt, sử dụng PhotoUploadService
            postsGroup.MapPost("/upload-photo", async ([FromForm] IFormFile? photo, PhotoUploadService photoUploadService) =>
            {
                if (photo == null || photo.Length == 0)
                    return Results.BadRequest("No file uploaded.");

                try
                {
                    // Lưu file ảnh vào thư mục "Uploads/Photos"
                    var (photoPath, photoUrl) = await photoUploadService.SavePhotoAsync(photo, "Uploads", "Photos");
                    return Results.Ok(new { PhotoUrl = photoUrl });
                }
                catch (Exception ex)
                {
                    return Results.Problem($"Internal Server Error: {ex.Message}");
                }
            })
            .DisableAntiforgery()
            .Produces<ApiResult<object>>() // Thay object bằng DTO cụ thể nếu có
            .WithName("UploadPhoto");
            return app;
        }
    }
}