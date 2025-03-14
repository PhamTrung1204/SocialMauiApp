using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;

namespace SocialMauiApp.Api.Services
{
    public class PostService
    {
        private readonly DataContext _context;
        private readonly PhotoUploadService _photoUploadService;
        private readonly IHubContext<SocialHub,ISocialHubClient> _hubContext;
        public PostService(DataContext context, PhotoUploadService photoUploadService, IHubContext<SocialHub, ISocialHubClient> hubContext)
        {
            _context = context;
            _photoUploadService = photoUploadService;
            _hubContext = hubContext;
        }
        public async Task<ApiResult<PostDto>> SavePostAsync(SavePostDto dto, LoggedInUser user)
        {
            string? _existingPhotoPath = null;
            Post? post = null;
            bool sendNotification = false; 
            if (dto.PostId == default)
            {
                post = new Post
                {
                    Content = dto.Content,
                    PostedOn = DateTime.UtcNow,
                    UserId = user.Id
                };
                if (dto.Photo is not null)
                {
                    (post.PhotoPath, post.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", user.Id.ToString(), "posts");
                }
                _context.Posts.Add(post);
            }
            else
            {
                post = await _context.Posts.FindAsync(dto.PostId);
                if (post is null)
                {
                    return ApiResult<PostDto>.Fail("Post no longer exists");
                }
                if (post.UserId != user.Id)
                {
                    return ApiResult<PostDto>.Fail("Permission Denied");
                }
                post.Content = dto.Content;
                post.ModifiedOn = DateTime.UtcNow;
                if (dto.Photo is not null)
                {
                    _existingPhotoPath = post.PhotoPath;
                    (post.PhotoPath, post.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", user.Id.ToString(), "posts");

                }
                else
                {
                    if (dto.IsExistingPhotoRemoved)
                    {
                        _existingPhotoPath = post.PhotoPath;
                        post.PhotoPath = null;
                        post.PhotoUrl = null;
                    }

                }
                _context.Posts.Update(post);
                sendNotification = true;
            }
            try
            {
                await _context.SaveChangesAsync();
                
                if (!string.IsNullOrEmpty(_existingPhotoPath) && File.Exists(_existingPhotoPath))
                {
                    File.Delete(_existingPhotoPath);
                }
                var postDto = new PostDto
                {
                    Content = post.Content,
                    PhotoUrl = post.PhotoUrl,
                    ModifiedOn = post.ModifiedOn,
                    PostId = post.Id,
                    UserId = user.Id,
                    UserName = user.Name,
                    UserPhotoUrl = user.PhotoUrl,
                    PostedOn = post.PostedOn
                };
                if (sendNotification)
                {
                    await _hubContext.Clients.All.PostChanged(postDto);
                }
                return ApiResult<PostDto>.Success(postDto);
            }
            catch (Exception ex)
            {
                return ApiResult<PostDto>.Fail(ex.Message);
            }

        }
        public async Task<PostDto[]> GetPostsAsync(int startIndex, int pageSize, Guid currentUserId)
        {
            var posts = await _context.Set<PostDto>()
                .FromSqlInterpolated($"EXEC GetPosts @StartIndex={startIndex},@PageSize={pageSize},@CurrentUserId={currentUserId}")
                .ToArrayAsync();
            return posts;
        }
        public async Task<PostDto?> GetPostAsync(Guid postId, Guid currentUserId)
        {
            var posts = await _context.Set<PostDto>()
                .FromSqlInterpolated($@"EXEC GetPostById @PostId={postId}, @CurrentUserId={currentUserId}")
                .ToArrayAsync();

            if (posts.Length == 0)
                return null;

            return posts[0];
        }

        public async Task<ApiResult<CommentDto>> SaveCommentAsync(SaveCommentDto dto, LoggedInUser currentUser)
        {
            var postOwnerId = await _context.Posts.Where(p => p.Id == dto.PostId).Select(p => p.UserId).FirstOrDefaultAsync();
            if (postOwnerId == default)
            {
                return ApiResult<CommentDto>.Fail("Post not found");
            }
            Comment? comment = null;
            bool sendNotification = false;
            if (dto.CommentId == Guid.Empty)
            {
                comment = new Comment
                {
                    PostId = dto.PostId,
                    UserId = currentUser.Id,
                    Content = dto.Content,
                    AddedOn = DateTime.UtcNow
                };
                _context.Comments.Add(comment);
                sendNotification = true;
            }
            else
            {
                comment = await _context.Comments.FindAsync(dto.CommentId); // comment = await _context.Comments.FindAsync(currentUser.Id);

                if (comment is null)
                {
                    return ApiResult<CommentDto>.Fail("Comment not found");
                }
                if (comment.UserId != currentUser.Id)
                {
                    return ApiResult<CommentDto>.Fail($"You can modify your own comments only");
                }
                comment.Content = dto.Content;
                _context.Comments.Update(comment);
            }
            try
            {
                await _context.SaveChangesAsync();
                var commentDto = new CommentDto
                {
                    AddedOn = comment.AddedOn,
                    CommentId = comment.Id,
                    Content = comment.Content,
                    PostId = comment.PostId,
                    UserId = currentUser.Id,
                    UserName = currentUser.Name,
                    UserPhotoUrl = currentUser.PhotoUrl
                };
                if(sendNotification)
                {
                    var notificationDto = new NotificationDto(postOwnerId, $"{currentUser.Name} commented on your post",DateTime.Now,dto.PostId);
                    await SaveNotificationAsync(notificationDto);
                    await _hubContext.Clients.All.CommentAddedToThePost(commentDto);
                }
                return ApiResult<CommentDto>.Success(commentDto);
            }
            catch (Exception ex)
            {
                return ApiResult<CommentDto>.Fail(ex.Message);
            }
        }
        public async Task<CommentDto[]> GetPostsCommentAsync(Guid postId, int startIndex, int pageSize) =>
            await _context.Comments
            .Where(c => c.PostId == postId)
            .OrderByDescending(c => c.AddedOn)
            .Skip(startIndex)
            .Take(pageSize)
            .Select(c => new CommentDto
            {
                AddedOn = c.AddedOn,
                CommentId = c.Id,
                Content = c.Content,
                PostId = postId,
                UserId = c.UserId,
                UserName = c.User.Name,
                UserPhotoUrl = c.User.PhotoUrl
            })
            .ToArrayAsync();
        public async Task<ApiResult> ToggleLikeAsync(Guid postId, LoggedInUser currentUser)
        {
            var postOwnerId = await _context.Posts.Where(p => p.Id == postId).Select(p=>p.UserId).FirstOrDefaultAsync();
            if (postOwnerId == default)
            {
                return ApiResult.Fail("Post not found");
            }
            try
            {
                bool sendNotification = false;
                var like = await _context.Likes.FirstOrDefaultAsync(l => l.PostId == postId && l.UserId == currentUser.Id);
                if (like is null)
                {
                    like = new Likes
                    {
                        PostId = postId,
                        UserId = currentUser.Id
                    };
                    _context.Likes.Add(like);
                    sendNotification = true;
                }
                else
                {
                    _context.Likes.Remove(like);
                }
                await _context.SaveChangesAsync();
                if (sendNotification)
                {
                    var notificationDto = new NotificationDto(postOwnerId,$"{currentUser.Name} liked your post", DateTime.Now, postId);
                    await _hubContext.Clients.All.NotificationGenerated(notificationDto);
                }
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }
        public async Task<ApiResult> ToggleBookmarkAsync(Guid postId, LoggedInUser currentUser)
        {

            var postOwnerId = await _context.Posts.Where(p => p.Id == postId).Select(p => p.UserId).FirstOrDefaultAsync();
            if (postOwnerId == default)
            {
                return ApiResult.Fail("Post not found");
            }
            try
            {
                var sendNotification = false;
                var bookmark = await _context.Bookmarks.FirstOrDefaultAsync(l => l.PostId == postId && l.UserId == currentUser.Id);
                if (bookmark is null)
                {
                    bookmark = new Bookmarks
                    {
                        PostId = postId,
                        UserId = currentUser.Id
                    };
                    _context.Bookmarks.Add(bookmark);
                    sendNotification = true;
                }
                else
                {
                    _context.Bookmarks.Remove(bookmark);
                }
                await _context.SaveChangesAsync();
                if (sendNotification)
                {
                    var notificationDto = new NotificationDto(postOwnerId, $"{currentUser.Name} saved your post", DateTime.Now, postId);
                    await SaveNotificationAsync(notificationDto);
                    await _hubContext.Clients.All.NotificationGenerated(notificationDto);
                }
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }
        public async Task<ApiResult> DeletePostAsync(Guid postId, Guid currentUserId)
        {
            try
            {
                var post = await _context.Posts.FindAsync(postId);
                if (post is null)
                    return ApiResult.Fail("Post not found");
                if (post.UserId != currentUserId)
                    return ApiResult.Fail("You can delete your own posts only");
                post.IsDeleted = true;
                _context.Posts.Update(post);
                await _context.SaveChangesAsync();
                await _hubContext.Clients.All.PostDeleted(postId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }
        public async Task SaveNotificationAsync(NotificationDto dto)
        {
            try
            {
                var notification = new Notification
                {
                    ForUserId = dto.ForUserId,
                    PostId = dto.PostId,
                    Text = dto.Text,
                    When = dto.When,
                };
                _context.Notifications.Add(notification);
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {

            }
        }
    }
}

    