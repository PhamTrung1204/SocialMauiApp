using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;

namespace SocialMauiApp.Api.Services
{
    public class FriendService
    {
        private readonly DataContext _context;
        private readonly NotificationService _notificationService;
        private readonly IHubContext<SocialHub, ISocialHubClient> _hubContext;
        private readonly ILogger<FriendService> _logger;

        public FriendService(
            DataContext context,
            NotificationService notificationService,
            IHubContext<SocialHub, ISocialHubClient> hubContext,
            ILogger<FriendService> logger)
        {
            _context = context;
            _notificationService = notificationService;
            _hubContext = hubContext;
            _logger = logger;
        }

        private IQueryable<Friendship> Between(Guid a, Guid b) =>
            _context.Friendships.Where(f =>
                (f.RequesterId == a && f.AddresseeId == b) ||
                (f.RequesterId == b && f.AddresseeId == a));

        private static string Describe(Friendship? row, Guid currentUserId)
        {
            if (row is null)
            {
                return FriendshipStatuses.NotFriends;
            }
            if (row.Status == FriendshipStatus.Accepted)
            {
                return FriendshipStatuses.Friends;
            }
            return row.RequesterId == currentUserId
                ? FriendshipStatuses.Pending
                : FriendshipStatuses.RequestReceived;
        }

        public async Task<ApiResult<FriendshipStatusDto>> GetStatusAsync(Guid currentUserId, Guid otherUserId)
        {
            if (currentUserId == otherUserId)
            {
                return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.Self));
            }
            var row = await Between(currentUserId, otherUserId).FirstOrDefaultAsync();
            return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(Describe(row, currentUserId)));
        }

        public async Task<ApiResult<FriendshipStatusDto>> SendRequestAsync(Guid currentUserId, Guid targetUserId, string currentUserName)
        {
            if (currentUserId == targetUserId)
            {
                return ApiResult<FriendshipStatusDto>.Fail("You cannot send a friend request to yourself.");
            }
            if (!await _context.Users.AnyAsync(u => u.Id == targetUserId))
            {
                return ApiResult<FriendshipStatusDto>.Fail("That user does not exist.");
            }

            var existing = await Between(currentUserId, targetUserId).FirstOrDefaultAsync();
            if (existing is not null)
            {
                if (existing.Status == FriendshipStatus.Accepted)
                {
                    return ApiResult<FriendshipStatusDto>.Fail("You are already friends.");
                }
                if (existing.RequesterId == currentUserId)
                {
                    return ApiResult<FriendshipStatusDto>.Fail("You have already sent a request.");
                }
                // Hai bên cùng gửi lời mời cho nhau -> thành bạn luôn.
                return await AcceptRequestAsync(currentUserId, targetUserId, currentUserName);
            }

            var friendship = new Friendship
            {
                RequesterId = currentUserId,
                AddresseeId = targetUserId,
                Status = FriendshipStatus.Pending,
                CreatedAt = DateTime.UtcNow
            };

            try
            {
                _context.Friendships.Add(friendship);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException ex)
            {
                // Khóa chính (RequesterId, AddresseeId) chặn lời mời trùng khi bấm hai lần.
                _logger.LogWarning(ex, "Duplicate friend request {From} -> {To}.", currentUserId, targetUserId);
                return ApiResult<FriendshipStatusDto>.Fail("You have already sent a request.");
            }

            await _notificationService.SaveAndBroadcastAsync(
                new NotificationDto(targetUserId, $"{currentUserName} sent you a friend request", DateTime.UtcNow, null));
            await _hubContext.Clients.All.FriendRequestReceived(new FriendRequestDto(currentUserId, targetUserId, FriendshipStatuses.Pending));

            return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.Pending));
        }

        public async Task<ApiResult<FriendshipStatusDto>> AcceptRequestAsync(Guid currentUserId, Guid requesterId, string currentUserName)
        {
            var row = await _context.Friendships
                .FirstOrDefaultAsync(f => f.RequesterId == requesterId && f.AddresseeId == currentUserId);

            if (row is null)
            {
                return ApiResult<FriendshipStatusDto>.Fail("Friend request not found.");
            }
            if (row.Status == FriendshipStatus.Accepted)
            {
                return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.Friends));
            }

            row.Status = FriendshipStatus.Accepted;
            row.AcceptedAt = DateTime.UtcNow;
            _context.Friendships.Update(row);
            await _context.SaveChangesAsync();

            await _notificationService.SaveAndBroadcastAsync(
                new NotificationDto(requesterId, $"{currentUserName} accepted your friend request", DateTime.UtcNow, null));
            await _hubContext.Clients.All.FriendRequestAccepted(new FriendRequestDto(requesterId, currentUserId, FriendshipStatuses.Friends));

            return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.Friends));
        }

        public async Task<ApiResult<FriendshipStatusDto>> RejectRequestAsync(Guid currentUserId, Guid requesterId)
        {
            var row = await _context.Friendships
                .FirstOrDefaultAsync(f => f.RequesterId == requesterId
                                       && f.AddresseeId == currentUserId
                                       && f.Status == FriendshipStatus.Pending);
            if (row is null)
            {
                return ApiResult<FriendshipStatusDto>.Fail("Friend request not found.");
            }

            _context.Friendships.Remove(row);
            await _context.SaveChangesAsync();
            return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.NotFriends));
        }

        public async Task<ApiResult<FriendshipStatusDto>> CancelRequestAsync(Guid currentUserId, Guid targetUserId)
        {
            var row = await _context.Friendships
                .FirstOrDefaultAsync(f => f.RequesterId == currentUserId
                                       && f.AddresseeId == targetUserId
                                       && f.Status == FriendshipStatus.Pending);
            if (row is null)
            {
                return ApiResult<FriendshipStatusDto>.Fail("There is no pending request to cancel.");
            }

            _context.Friendships.Remove(row);
            await _context.SaveChangesAsync();
            return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.NotFriends));
        }

        public async Task<ApiResult<FriendshipStatusDto>> RemoveFriendAsync(Guid currentUserId, Guid friendId)
        {
            var row = await Between(currentUserId, friendId)
                .FirstOrDefaultAsync(f => f.Status == FriendshipStatus.Accepted);
            if (row is null)
            {
                return ApiResult<FriendshipStatusDto>.Fail("You are not friends yet.");
            }

            _context.Friendships.Remove(row);
            await _context.SaveChangesAsync();
            await _hubContext.Clients.All.FriendRemoved(new FriendRequestDto(currentUserId, friendId, FriendshipStatuses.NotFriends));

            return ApiResult<FriendshipStatusDto>.Success(new FriendshipStatusDto(FriendshipStatuses.NotFriends));
        }

        public async Task<FriendshipDto[]> GetFriendsAsync(Guid currentUserId, int startIndex, int pageSize) =>
            await _context.Friendships
                .Where(f => f.Status == FriendshipStatus.Accepted
                         && (f.RequesterId == currentUserId || f.AddresseeId == currentUserId))
                .OrderByDescending(f => f.AcceptedAt)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(f => new FriendshipDto
                {
                    UserId = currentUserId,
                    FriendId = f.RequesterId == currentUserId ? f.AddresseeId : f.RequesterId,
                    FriendName = f.RequesterId == currentUserId ? f.Addressee.Name : f.Requester.Name,
                    FriendPhotoUrl = f.RequesterId == currentUserId ? f.Addressee.PhotoUrl : f.Requester.PhotoUrl,
                    Status = FriendshipStatuses.Friends,
                    CreatedAt = f.CreatedAt
                })
                .ToArrayAsync();

        public async Task<FriendshipDto[]> GetIncomingRequestsAsync(Guid currentUserId, int startIndex, int pageSize) =>
            await _context.Friendships
                .Where(f => f.AddresseeId == currentUserId && f.Status == FriendshipStatus.Pending)
                .OrderByDescending(f => f.CreatedAt)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(f => new FriendshipDto
                {
                    UserId = currentUserId,
                    FriendId = f.RequesterId,
                    FriendName = f.Requester.Name,
                    FriendPhotoUrl = f.Requester.PhotoUrl,
                    Status = FriendshipStatuses.RequestReceived,
                    CreatedAt = f.CreatedAt
                })
                .ToArrayAsync();

        public async Task<FriendshipDto[]> GetSentRequestsAsync(Guid currentUserId, int startIndex, int pageSize) =>
            await _context.Friendships
                .Where(f => f.RequesterId == currentUserId && f.Status == FriendshipStatus.Pending)
                .OrderByDescending(f => f.CreatedAt)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(f => new FriendshipDto
                {
                    UserId = currentUserId,
                    FriendId = f.AddresseeId,
                    FriendName = f.Addressee.Name,
                    FriendPhotoUrl = f.Addressee.PhotoUrl,
                    Status = FriendshipStatuses.Pending,
                    CreatedAt = f.CreatedAt
                })
                .ToArrayAsync();

        public async Task<UserDto[]> SuggestAsync(Guid currentUserId, string? searchText, int startIndex, int pageSize)
        {
            var query = _context.Users.Where(u => u.Id != currentUserId && !u.IsLocked);

            if (!string.IsNullOrWhiteSpace(searchText))
            {
                var pattern = "%" + searchText.Trim()
                    .Replace("\\", "\\\\")
                    .Replace("%", "\\%")
                    .Replace("_", "\\_") + "%";
                query = query.Where(u => EF.Functions.ILike(u.Name, pattern) || EF.Functions.ILike(u.Email, pattern));
            }

            return await query
                .Where(u => !_context.Friendships.Any(f =>
                    (f.RequesterId == currentUserId && f.AddresseeId == u.Id) ||
                    (f.RequesterId == u.Id && f.AddresseeId == currentUserId)))
                .OrderBy(u => u.Name)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(u => new UserDto
                {
                    Id = u.Id,
                    Name = u.Name,
                    Email = u.Email,
                    Role = u.Role,
                    PhotoUrl = u.PhotoUrl,
                    IsLocked = u.IsLocked
                })
                .ToArrayAsync();
        }
    }
}
