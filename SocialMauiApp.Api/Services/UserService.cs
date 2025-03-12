using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;

namespace SocialMauiApp.Api.Services
{
    public class UserService
    {
        private readonly DataContext _context;
        private readonly PhotoUploadService _photoUploadService;
        private readonly IHubContext<SocialHub, ISocialHubClient> _hubContext;
        public UserService(DataContext context, PhotoUploadService photoUploadService, IHubContext<SocialHub, ISocialHubClient> hubContext)
        {
            _context = context;
            _photoUploadService = photoUploadService;
            _hubContext = hubContext;
        }
        public async Task<ApiResult<string>> ChangePhotoAsync(IFormFile photo, Guid currentUserId)
        {
            var user = await _context.Users.FindAsync(currentUserId);
            if (user is null)
            {
                return ApiResult<string>.Fail("User not found");
            }
            try
            {
                var existingPhotoPath = user.PhotoPath;
                (user.PhotoPath, user.PhotoUrl) = await _photoUploadService.SavePhotoAsync(photo, "uploads", "images", "users");

                _context.Users.Update(user);
                await _context.SaveChangesAsync();
                await _hubContext.Clients.All.UserPhotoChanged(new UserPhotoChangedDto(currentUserId, user.PhotoUrl));
                if (!string.IsNullOrEmpty(existingPhotoPath) && File.Exists(existingPhotoPath))
                {
                    File.Delete(existingPhotoPath);
                }
                return ApiResult<string>.Success(user.PhotoUrl);
            }
            catch (Exception ex)
            {
                return ApiResult<string>.Fail(ex.Message);
            }
        }
        public async Task<PostDto[]> GetUserPostsAsync(int startIndex, int pageSize, Guid currentUserId)
        {
            var posts = await _context.Set<PostDto>()
              .FromSqlInterpolated($"EXEC GetUserPosts @StartIndex={startIndex},@PageSize={pageSize},@CurrentUserId={currentUserId}")
              .ToArrayAsync();
            return posts;
        }
        public async Task<PostDto[]> GetUserBookmarkedPostsAsync(int startIndex, int pageSize, Guid currentUserId)
        {
            var posts = await _context.Set<PostDto>()
              .FromSqlInterpolated($"EXEC GetUserBookmarkedPosts @StartIndex={startIndex},@PageSize={pageSize},@CurrentUserId={currentUserId}")
              .ToArrayAsync();
            return posts;
        }
        public async Task<NotificationDto[]> GetNotificationAsync(int startIndex, int pageSize, Guid currentUserId) =>
             await _context.Notifications
                .Where(n => n.ForUserId == currentUserId)
                .OrderByDescending(n => n.When)
                .Select(n => new NotificationDto(n.ForUserId, n.Text, n.When, n.PostId))
                .Skip(startIndex)
                .Take(pageSize)
                .ToArrayAsync();
            
    }
}
