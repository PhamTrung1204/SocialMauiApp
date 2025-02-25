using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Security.Claims;

namespace SocialMauiApp.Api.Endpoints
{
    public static class UserEndpoints
    {
        public static IEndpointRouteBuilder MapUserEndpoints(this IEndpointRouteBuilder app)
        {
            var userGroup = app.MapGroup("api/user")
                .RequireAuthorization()
                .WithName("User");
            userGroup.MapPost("/change-photo", async (IFormFile photo, UserService userService, ClaimsPrincipal principal) =>
            Results.Ok(await userService.ChangePhotoAsync(photo, principal.GetUserId())))
                .DisableAntiforgery()
            .Produces<ApiResult>()
            .WithName("ChangePhoto");

            userGroup.MapPost("/posts", async (int startIndex, int pageSize, UserService userService, ClaimsPrincipal principal) =>
            Results.Ok(await userService.GetUserPostsAsync(startIndex, pageSize, principal.GetUserId())))
            .Produces<PostDto[]>()
            .WithName("GetUserPosts");

            userGroup.MapPost("/bookmarked-posts", async (int startIndex, int pageSize, UserService userService, ClaimsPrincipal principal) =>
            Results.Ok(await userService.GetUserBookmarkedPostsAsync(startIndex, pageSize, principal.GetUserId())))
            .Produces<PostDto[]>()
            .WithName("GetBookmarkedPosts");

            return app;
        }

    }
}