using Microsoft.AspNetCore.Mvc;
using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Security.Claims;

namespace SocialMauiApp.Api.Endpoints
{
    public static class UserEndpoints
    {
        public static IEndpointRouteBuilder MapUserEndpoints(this IEndpointRouteBuilder app)
        {
            var userGroup = app.MapGroup("/api/user")
                .RequireAuthorization()
                .WithName("User");

            userGroup.MapPost("/change-photo", async (IFormFile photo, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.ChangePhotoAsync(photo, principal.GetUserId())))
                .DisableAntiforgery()
                .Produces<ApiResult>()
                .WithName("ChangePhoto");

            userGroup.MapGet("/posts", async ([FromQuery] int startIndex, [FromQuery] int pageSize, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.GetUserPostsAsync(startIndex, pageSize, principal.GetUserId())))
                .Produces<PostDto[]>()
                .WithName("GetUserPosts");

            userGroup.MapGet("/bookmarked-posts", async ([FromQuery] int startIndex, [FromQuery] int pageSize, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.GetUserBookmarkedPostsAsync(startIndex, pageSize, principal.GetUserId())))
                .Produces<PostDto[]>()
                .WithName("GetBookmarkedPosts");

            userGroup.MapGet("/notifications", async ([FromQuery] int startIndex, [FromQuery] int pageSize, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.GetNotificationAsync(startIndex, pageSize, principal.GetUserId())))
                .Produces<NotificationDto[]>()
                .WithName("GetNotifications");

            userGroup.MapGet("/{userId:guid}/info", async (Guid userId, UserService userService) =>
            {
                var info = await userService.GetUserInfoAsync(userId);
                return info is null ? Results.NotFound() : Results.Ok(info);
            })
                .Produces<UserInfoDto>()
                .Produces(StatusCodes.Status404NotFound)
                .WithName("GetUserInfo");

            userGroup.MapGet("/{userId:guid}/posts", async (Guid userId, [FromQuery] int startIndex, [FromQuery] int pageSize, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.GetPostsOfUserAsync(userId, principal.GetUserId(), startIndex, pageSize)))
                .Produces<PostDto[]>()
                .WithName("GetPostsOfUser");

            userGroup.MapPost("/change-password", async (ChangePasswordDto dto, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.ChangePasswordAsync(dto, principal.GetUserId())))
                .Produces<ApiResult<string>>()
                .WithName("ChangePassword");

            userGroup.MapPost("/change-name", async (ChangeNameDto dto, UserService userService, ClaimsPrincipal principal) =>
                Results.Ok(await userService.ChangeNameAsync(dto, principal.GetUserId())))
                .Produces<ApiResult<string>>()
                .WithName("ChangeName");
            return app;
        }
    }
}