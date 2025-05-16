//using Microsoft.AspNetCore.Http.HttpResults;
//using Microsoft.AspNetCore.Mvc;
//using SocialMauiApp.Api.Data;
//using SocialMauiApp.Api.Services;
//using SocialMediaMaui.Shared.Dtos;
//using System.Security.Claims;

//namespace SocialMauiApp.Api.Endpoints
//{
//    public static class AdminEndpoints
//    {
//        public static IEndpointRouteBuilder MapAdminEndpoints(this IEndpointRouteBuilder app)
//        {
//            var adminGroup = app.MapGroup("/api/admin")
//                .RequireAuthorization("Admin")
//                .WithTags("Admin");

//            // Dashboard
//            adminGroup.MapGet("/dashboard", async (AdminService adminService) =>
//                Results.Ok(await adminService.GetDashboardAsync()))
//                .WithName("GetDashboard");

//            // Quản lý bài viết
//            adminGroup.MapGet("/posts", async (AdminService adminService, string? search, Guid? authorId, string? status, int page = 1, int pageSize = 10) =>
//                Results.Ok(await adminService.GetPostsForAdminAsync(search, authorId, status, page, pageSize)))
//                .WithName("GetPostsForAdmin");

//            adminGroup.MapDelete("/posts/{postId:guid}", async (Guid postId, AdminService adminService) =>
//                Results.Ok(await adminService.DeletePostByAdminAsync(postId)))
//                .WithName("DeletePostByAdmin");

//            adminGroup.MapPut("/posts/{postId:guid}", async (Guid postId, [FromForm] IFormFile? photo, [FromForm] string serializedSavePostDto, AdminService adminService) =>
//            {
//                if (string.IsNullOrWhiteSpace(serializedSavePostDto))
//                    return Results.BadRequest("Missing data");

//                var dto = System.Text.Json.JsonSerializer.Deserialize<SavePostDto>(serializedSavePostDto);
//                dto.Photo = photo;
//                return Results.Ok(await adminService.UpdatePostByAdminAsync(postId, dto));
//            })
//                .DisableAntiforgery()
//                .WithName("UpdatePostByAdmin");

//            // Quản lý bình luận
//            adminGroup.MapGet("/comments", async (AdminService adminService, string? search, Guid? postId, Guid? authorId, int page = 1, int pageSize = 10) =>
//                Results.Ok(await adminService.GetCommentsForAdminAsync(search, postId, authorId, page, pageSize)))
//                .WithName("GetCommentsForAdmin");

//            adminGroup.MapDelete("/comments/{commentId:guid}", async (Guid commentId, AdminService adminService) =>
//                Results.Ok(await adminService.DeleteCommentByAdminAsync(commentId)))
//                .WithName("DeleteCommentByAdmin");

//            return app;
//        }
//    }
//}