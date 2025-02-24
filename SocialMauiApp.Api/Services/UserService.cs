using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Api.Services
{
    public class UserService
    {
        private readonly DataContext _context;
        private readonly PhotoUploadService _photoUploadService;

        public UserService(DataContext context, PhotoUploadService photoUploadService)
        {
            _context = context;
            _photoUploadService = photoUploadService;
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
    }
}
