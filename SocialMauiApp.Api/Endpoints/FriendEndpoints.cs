using SocialMauiApp.Api.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Security.Claims;

namespace SocialMauiApp.Api.Endpoints
{
    public static class FriendEndpoints
    {
        public static IEndpointRouteBuilder MapFriendEndpoints(this IEndpointRouteBuilder app)
        {
            var friendsGroup = app.MapGroup("/api/friends")
                .RequireAuthorization()
                .WithTags("Friends");

            friendsGroup.MapGet("/", async (int startIndex, int pageSize, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.GetFriendsAsync(principal.GetUserId(), startIndex, pageSize)))
                .Produces<FriendshipDto[]>()
                .WithName("Friends-List");

            friendsGroup.MapGet("/requests", async (int startIndex, int pageSize, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.GetIncomingRequestsAsync(principal.GetUserId(), startIndex, pageSize)))
                .Produces<FriendshipDto[]>()
                .WithName("Friends-IncomingRequests");

            friendsGroup.MapGet("/requests/sent", async (int startIndex, int pageSize, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.GetSentRequestsAsync(principal.GetUserId(), startIndex, pageSize)))
                .Produces<FriendshipDto[]>()
                .WithName("Friends-SentRequests");

            friendsGroup.MapGet("/suggestions", async (string? searchText, int startIndex, int pageSize, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.SuggestAsync(principal.GetUserId(), searchText, startIndex, pageSize)))
                .Produces<UserDto[]>()
                .WithName("Friends-Suggestions");

            friendsGroup.MapGet("/{userId:guid}/status", async (Guid userId, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.GetStatusAsync(principal.GetUserId(), userId)))
                .Produces<ApiResult<FriendshipStatusDto>>()
                .WithName("Friends-Status");

            friendsGroup.MapPost("/{userId:guid}/request", async (Guid userId, FriendService friendService, ClaimsPrincipal principal) =>
            {
                var user = principal.GetUser();
                return Results.Ok(await friendService.SendRequestAsync(user.Id, userId, user.Name));
            })
                .Produces<ApiResult<FriendshipStatusDto>>()
                .WithName("Friends-SendRequest");

            friendsGroup.MapPost("/{userId:guid}/accept", async (Guid userId, FriendService friendService, ClaimsPrincipal principal) =>
            {
                var user = principal.GetUser();
                return Results.Ok(await friendService.AcceptRequestAsync(user.Id, userId, user.Name));
            })
                .Produces<ApiResult<FriendshipStatusDto>>()
                .WithName("Friends-AcceptRequest");

            friendsGroup.MapPost("/{userId:guid}/reject", async (Guid userId, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.RejectRequestAsync(principal.GetUserId(), userId)))
                .Produces<ApiResult<FriendshipStatusDto>>()
                .WithName("Friends-RejectRequest");

            friendsGroup.MapDelete("/{userId:guid}/request", async (Guid userId, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.CancelRequestAsync(principal.GetUserId(), userId)))
                .Produces<ApiResult<FriendshipStatusDto>>()
                .WithName("Friends-CancelRequest");

            friendsGroup.MapDelete("/{userId:guid}", async (Guid userId, FriendService friendService, ClaimsPrincipal principal) =>
                Results.Ok(await friendService.RemoveFriendAsync(principal.GetUserId(), userId)))
                .Produces<ApiResult<FriendshipStatusDto>>()
                .WithName("Friends-Remove");

            return app;
        }
    }
}
