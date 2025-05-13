using Microsoft.AspNetCore.SignalR;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;

namespace SocialMauiApp.Api.Services
{
    public class PostService
    {
        private readonly DataContext _context;
        private readonly PhotoUploadService _photoUploadService;
        private readonly IHubContext<SocialHub, ISocialHubClient> _hubContext;

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
                .FromSqlInterpolated($"EXEC GetPosts @StartIndex={startIndex}, @PageSize={pageSize}, @CurrentUserId={currentUserId}")
                .ToArrayAsync();
            return posts;
        }

        public async Task<PostDto?> GetPostAsync(Guid postId, Guid currentUserId)
        {
            var rawPosts = await _context.Set<PostDto>()
                .FromSqlRaw("EXEC GetPostById @PostId, @CurrentUserId",
                    new SqlParameter("@PostId", postId),
                    new SqlParameter("@CurrentUserId", currentUserId))
                .ToListAsync();
            var posts = rawPosts.Select(p => new PostDto
            {
                PostId = p.PostId,
                UserId = p.UserId,
                UserName = p.UserName,
                UserPhotoUrl = p.UserPhotoUrl,
                Content = p.Content,
                PhotoUrl = p.PhotoUrl,
                PostedOn = p.PostedOn,
                ModifiedOn = p.ModifiedOn,
                IsLiked = Convert.ToBoolean(p.IsLiked),
                IsBookmarked = Convert.ToBoolean(p.IsBookmarked)
            }).ToList();
            return posts.FirstOrDefault();
        }

        private async Task NotifyCountsAsync(Guid postId)
        {
            var likeCount = await _context.Likes.CountAsync(l => l.PostId == postId);
            var commentCount = await _context.Comments.CountAsync(c => c.PostId == postId);
            var dto = new PostDto
            {
                PostId = postId,
                LikeCount = likeCount,
                CommentCount = commentCount
            };
            await _hubContext.Clients.All.PostCountsUpdated(dto);
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
                var existingComment = await _context.Comments
                    .FirstOrDefaultAsync(c => c.PostId == dto.PostId && c.UserId == currentUser.Id && c.Content == dto.Content && c.AddedOn > DateTime.UtcNow.AddSeconds(-5));
                if (existingComment != null)
                {
                    return ApiResult<CommentDto>.Fail("Duplicate comment detected");
                }

                comment = new Comment
                {
                    Id = Guid.NewGuid(),
                    PostId = dto.PostId,
                    UserId = currentUser.Id,
                    Content = dto.Content,
                    AddedOn = DateTime.UtcNow,
                    ParentCommentId = dto.ParentCommentId
                };
                if (dto.Photo != null)
                {
                    (comment.PhotoPath, comment.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", currentUser.Id.ToString(), "comments");
                }
                _context.Comments.Add(comment);
                sendNotification = true;
            }
            else
            {
                comment = await _context.Comments.FindAsync(dto.CommentId);
                if (comment is null)
                {
                    return ApiResult<CommentDto>.Fail("Comment not found");
                }
                if (comment.UserId != currentUser.Id)
                {
                    return ApiResult<CommentDto>.Fail("You can modify your own comments only");
                }
                comment.Content = dto.Content;
                comment.AddedOn = DateTime.UtcNow;
                if (dto.Photo != null)
                {
                    var existingPhotoPath = comment.PhotoPath;
                    (comment.PhotoPath, comment.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", currentUser.Id.ToString(), "comments");
                    if (!string.IsNullOrEmpty(existingPhotoPath) && File.Exists(existingPhotoPath))
                    {
                        File.Delete(existingPhotoPath);
                    }
                }
                else if (dto.IsExistingPhotoRemoved)
                {
                    var existingPhotoPath = comment.PhotoPath;
                    comment.PhotoPath = null;
                    comment.PhotoUrl = null;
                    if (!string.IsNullOrEmpty(existingPhotoPath) && File.Exists(existingPhotoPath))
                    {
                        File.Delete(existingPhotoPath);
                    }
                }
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
                    UserPhotoUrl = currentUser.PhotoUrl,
                    PhotoUrl = comment.PhotoUrl,
                    ParentCommentId = comment.ParentCommentId,
                    Level = comment.ParentCommentId == null ? 0 : 1
                };
                if (sendNotification)
                {
                    var notificationDto = new NotificationDto(postOwnerId, $"{currentUser.Name} commented on your post", DateTime.Now, dto.PostId);
                    await SaveNotificationAsync(notificationDto);
                    await _hubContext.Clients.All.CommentAddedToThePost(commentDto);
                }
                await NotifyCountsAsync(commentDto.PostId);
                return ApiResult<CommentDto>.Success(commentDto);
            }
            catch (Exception ex)
            {
                return ApiResult<CommentDto>.Fail(ex.Message);
            }
        }

        public async Task<ApiResult<CommentDto>> UpdateCommentWithImageAsync(Guid commentId, UpdateCommentDto dto, LoggedInUser currentUser)
        {
            var comment = await _context.Comments.FindAsync(commentId);
            if (comment is null)
            {
                return ApiResult<CommentDto>.Fail("Comment not found");
            }
            if (comment.UserId != currentUser.Id)
            {
                return ApiResult<CommentDto>.Fail("You can only edit your own comment");
            }
            comment.Content = dto.Content;
            comment.AddedOn = DateTime.UtcNow;
            string? existingPhotoPath = null;
            if (dto.Photo != null)
            {
                existingPhotoPath = comment.PhotoPath;
                (comment.PhotoPath, comment.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", currentUser.Id.ToString(), "comments");
            }
            else if (dto.IsExistingPhotoRemoved)
            {
                existingPhotoPath = comment.PhotoPath;
                comment.PhotoPath = null;
                comment.PhotoUrl = null;
            }
            try
            {
                _context.Comments.Update(comment);
                await _context.SaveChangesAsync();
                if (!string.IsNullOrEmpty(existingPhotoPath) && File.Exists(existingPhotoPath))
                {
                    File.Delete(existingPhotoPath);
                }
                var commentDto = new CommentDto
                {
                    CommentId = comment.Id,
                    Content = comment.Content,
                    PostId = comment.PostId,
                    UserId = currentUser.Id,
                    UserName = currentUser.Name,
                    UserPhotoUrl = currentUser.PhotoUrl,
                    PhotoUrl = comment.PhotoUrl,
                    AddedOn = comment.AddedOn,
                    ParentCommentId = comment.ParentCommentId,
                    Level = comment.ParentCommentId == null ? 0 : 1
                };
                await _hubContext.Clients.All.CommentUpdated(commentDto);
                await NotifyCountsAsync(comment.PostId);
                return ApiResult<CommentDto>.Success(commentDto);
            }
            catch (Exception ex)
            {
                return ApiResult<CommentDto>.Fail(ex.Message);
            }
        }

        public async Task<ApiResult> DeleteCommentAsync(Guid commentId, LoggedInUser currentUser)
        {
            var comment = await _context.Comments.FindAsync(commentId);
            if (comment is null)
            {
                return ApiResult.Fail("Comment not found");
            }
            if (comment.UserId != currentUser.Id)
            {
                return ApiResult.Fail("You can only delete your own comment");
            }
            try
            {
                _context.Comments.Remove(comment);
                await _context.SaveChangesAsync();
                await NotifyCountsAsync(comment.PostId);
                await _hubContext.Clients.All.CommentDeleted(commentId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }

        public async Task<ApiResult<CommentDto>> UpdateCommentAsync(Guid commentId, UpdateCommentDto dto, LoggedInUser currentUser)
        {
            var comment = await _context.Comments.FindAsync(commentId);
            if (comment is null)
            {
                return ApiResult<CommentDto>.Fail("Comment not found");
            }
            if (comment.UserId != currentUser.Id)
            {
                return ApiResult<CommentDto>.Fail("You can only edit your own comment");
            }
            comment.Content = dto.Content;
            comment.AddedOn = DateTime.UtcNow;
            try
            {
                _context.Comments.Update(comment);
                await _context.SaveChangesAsync();
                var commentDto = new CommentDto
                {
                    CommentId = comment.Id,
                    Content = comment.Content,
                    PostId = comment.PostId,
                    UserId = currentUser.Id,
                    UserName = currentUser.Name,
                    UserPhotoUrl = currentUser.PhotoUrl,
                    AddedOn = comment.AddedOn,
                    PhotoUrl = comment.PhotoUrl,
                    ParentCommentId = comment.ParentCommentId,
                    Level = comment.ParentCommentId == null ? 0 : 1
                };
                await _hubContext.Clients.All.CommentUpdated(commentDto);
                return ApiResult<CommentDto>.Success(commentDto);
            }
            catch (Exception ex)
            {
                return ApiResult<CommentDto>.Fail(ex.Message);
            }
        }

        public async Task<CommentDto[]> GetPostsCommentAsync(Guid postId, int startIndex, int pageSize)
        {
            var comments = await _context.Comments
                .Where(c => c.PostId == postId && c.ParentCommentId == null)
                .OrderByDescending(c => c.AddedOn)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(c => new CommentDto
                {
                    AddedOn = c.AddedOn,
                    CommentId = c.Id,
                    Content = c.Content,
                    PostId = c.PostId,
                    UserId = c.UserId,
                    UserName = c.User.Name,
                    UserPhotoUrl = c.User.PhotoUrl,
                    PhotoUrl = c.PhotoUrl,
                    ParentCommentId = c.ParentCommentId,
                    Level = c.ParentCommentId == null ? 0 : 1,
                    Replies = new ObservableCollection<CommentDto>(c.Replies.Select(r => new CommentDto
                    {
                        AddedOn = r.AddedOn,
                        CommentId = r.Id,
                        Content = r.Content,
                        PostId = r.PostId,
                        UserId = r.UserId,
                        UserName = r.User.Name,
                        UserPhotoUrl = r.User.PhotoUrl,
                        PhotoUrl = r.PhotoUrl,
                        ParentCommentId = r.ParentCommentId,
                        Level = 1
                    }).ToArray())
                })
                .ToArrayAsync();
            return comments;
        }

        public async Task<ApiResult> ToggleLikeAsync(Guid postId, LoggedInUser currentUser)
        {
            var postOwnerId = await _context.Posts.Where(p => p.Id == postId).Select(p => p.UserId).FirstOrDefaultAsync();
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
                    var notificationDto = new NotificationDto(postOwnerId, $"{currentUser.Name} liked your post", DateTime.Now, postId);
                    await SaveNotificationAsync(notificationDto);
                    await _hubContext.Clients.All.NotificationGenerated(notificationDto);
                }
                await NotifyCountsAsync(postId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }

        // Lưu bài post
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

        // Xóa bài post
        public async Task<ApiResult> DeletePostAsync(Guid postId, Guid currentUserId)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var post = await _context.Posts.FirstOrDefaultAsync(p => p.Id == postId);
                if (post is null)
                    return ApiResult.Fail("Post not found");
                if (post.UserId != currentUserId)
                    return ApiResult.Fail("You can delete your own posts only");
                if (!string.IsNullOrEmpty(post.PhotoPath) && File.Exists(post.PhotoPath))
                {
                    try
                    {
                        File.Delete(post.PhotoPath);
                    }
                    catch (Exception exFile)
                    {
                        Console.WriteLine("Error deleting file: " + exFile.ToString());
                    }
                }
                _context.Comments.RemoveRange(_context.Comments.Where(c => c.PostId == postId));
                _context.Likes.RemoveRange(_context.Likes.Where(l => l.PostId == postId));
                _context.Bookmarks.RemoveRange(_context.Bookmarks.Where(b => b.PostId == postId));
                _context.Notifications.RemoveRange(_context.Notifications.Where(n => n.PostId == postId));
                _context.Posts.Remove(post);
                int result = await _context.SaveChangesAsync();
                await transaction.CommitAsync();
                if (result > 0)
                {
                    await _hubContext.Clients.All.PostDeleted(postId);
                    return ApiResult.Success();
                }
                return ApiResult.Fail("No rows affected");
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                Console.WriteLine("Error in DeletePostAsync: " + ex.ToString());
                return ApiResult.Fail(ex.Message);
            }
        }

        // Lưu thông báo
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
                Console.WriteLine("Error in SaveNotificationAsync: " + ex.ToString());
            }
        }
    }
}