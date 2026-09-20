using Refit;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Apis;

[Headers("Authorization: Bearer")]
public interface IFriendApi
{
    [Get("/api/friends")]
    Task<FriendshipDto[]> GetFriendsAsync(int startIndex, int pageSize);

    [Get("/api/friends/requests")]
    Task<FriendshipDto[]> GetIncomingRequestsAsync(int startIndex, int pageSize);

    [Get("/api/friends/requests/sent")]
    Task<FriendshipDto[]> GetSentRequestsAsync(int startIndex, int pageSize);

    [Get("/api/friends/suggestions")]
    Task<UserDto[]> GetSuggestionsAsync(string? searchText, int startIndex, int pageSize);

    [Get("/api/friends/{userId}/status")]
    Task<ApiResult<FriendshipStatusDto>> GetFriendshipStatusAsync(Guid userId);

    [Post("/api/friends/{userId}/request")]
    Task<ApiResult<FriendshipStatusDto>> SendFriendRequestAsync(Guid userId);

    [Post("/api/friends/{userId}/accept")]
    Task<ApiResult<FriendshipStatusDto>> AcceptFriendRequestAsync(Guid userId);

    [Post("/api/friends/{userId}/reject")]
    Task<ApiResult<FriendshipStatusDto>> RejectFriendRequestAsync(Guid userId);

    [Delete("/api/friends/{userId}/request")]
    Task<ApiResult<FriendshipStatusDto>> CancelFriendRequestAsync(Guid userId);

    [Delete("/api/friends/{userId}")]
    Task<ApiResult<FriendshipStatusDto>> RemoveFriendAsync(Guid userId);
}
