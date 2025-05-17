using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Security.Claims;
using System.Text.Json;

namespace SocialMauiApp.Api.Endpoints
{
    public static class AdminEndpoints
    {
        public static IEndpointRouteBuilder MapAdminEndpoints(this IEndpointRouteBuilder app)
        {
            var adminGroup = app.MapGroup("/api/admin")
                .RequireAuthorization()
                .RequireAuthorization(policy => policy.RequireRole("Admin"))
                .WithTags("Admin");

            adminGroup.MapGet("/dashboard", async ([FromServices] AdminService adminService) =>
    Results.Ok(await adminService.GetDashboardAsync()))
    .Produces<DashboardDto>()
    .WithName("GetDashboard");

            adminGroup.MapGet("/posts", async (int startIndex, int pageSize, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.GetPostsAsync(startIndex, pageSize)))
                .Produces<PostDto[]>()
                .WithName("GetAdminPosts");

            adminGroup.MapDelete("/posts/{postId:guid}", async (Guid postId, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.DeletePostAsync(postId)))
                .Produces<ApiResult>()
                .WithName("DeleteAdminPost");

            adminGroup.MapGet("/users", async (string? searchText, string? role, int page, int pageSize, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.GetUsersAsync(searchText, role, page, pageSize)))
                .Produces<UserDto[]>()
                .WithName("GetUsers");

            adminGroup.MapPost("/users/{userId:guid}/lock", async (Guid userId, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.LockUserAsync(userId)))
                .Produces<ApiResult>()
                .WithName("LockUser");

            adminGroup.MapPost("/users/{userId:guid}/unlock", async (Guid userId, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.UnlockUserAsync(userId)))
                .Produces<ApiResult>()
                .WithName("UnlockUser");

            adminGroup.MapDelete("/users/{userId:guid}", async (Guid userId, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.DeleteUserAsync(userId)))
                .Produces<ApiResult>()
                .WithName("DeleteUser");

            adminGroup.MapDelete("/comments/{commentId:guid}", async (Guid commentId, [FromServices] AdminService adminService) =>
                Results.Ok(await adminService.DeleteCommentAsync(commentId)))
                .Produces<ApiResult>()
                .WithName("DeleteAdminComment");

            return app;
        }
    }
}