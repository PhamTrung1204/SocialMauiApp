using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;

namespace SocialMauiApp.Api.Services
{
    public class AdminService
    {
        private readonly DataContext _context;
        private readonly PhotoUploadService _photoUploadService;
        private readonly IHubContext<SocialHub, ISocialHubClient> _hubContext;

        public AdminService(DataContext context, PhotoUploadService photoUploadService, IHubContext<SocialHub, ISocialHubClient> hubContext)
        {
            _context = context;
            _photoUploadService = photoUploadService;
            _hubContext = hubContext;
        }

        public async Task<DashboardDto> GetDashboardAsync()
        {
            System.Diagnostics.Debug.WriteLine($"Database connected: {_context.Database.CanConnect()}");
            var postCount = await _context.Posts.CountAsync(p => !p.IsDeleted);
            var userCount = await _context.Users.CountAsync();
            var commentCount = await _context.Comments.CountAsync();
            var likeCount = await _context.Likes.CountAsync();

            System.Diagnostics.Debug.WriteLine($"Dashboard counts - Posts: {postCount}, Users: {userCount}, Comments: {commentCount}, Likes: {likeCount}");

            return new DashboardDto
            {
                PostCount = postCount,
                UserCount = userCount,
                CommentCount = commentCount,
                LikeCount = likeCount
            };
        }

        public async Task<PostDto[]> GetPostsAsync(int startIndex, int pageSize)
        {
            var posts = await _context.Posts
                .Where(p => !p.IsDeleted)
                .OrderByDescending(p => p.PostedOn)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(p => new PostDto
                {
                    PostId = p.Id,
                    UserId = p.UserId,
                    UserName = p.User.Name,
                    UserPhotoUrl = p.User.PhotoUrl,
                    Content = p.Content,
                    PhotoUrl = p.PhotoUrl,
                    PostedOn = p.PostedOn,
                    ModifiedOn = p.ModifiedOn,
                    //LikeCount = p.Likes.Count,
                    //CommentCount = p.Comments.Count
                })
                .ToArrayAsync();

            return posts;
        }

        public async Task<ApiResult> DeletePostAsync(Guid postId)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var post = await _context.Posts.FirstOrDefaultAsync(p => p.Id == postId);
                if (post == null)
                    return ApiResult.Fail("Post not found");

                if (!string.IsNullOrEmpty(post.PhotoPath) && File.Exists(post.PhotoPath))
                {
                    try
                    {
                        File.Delete(post.PhotoPath);
                    }
                    catch (Exception exFile)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error deleting post photo file: {exFile.Message}");
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
                System.Diagnostics.Debug.WriteLine($"DeletePostAsync Error: {ex.Message}, Inner Exception: {ex.InnerException?.Message}");
                return ApiResult.Fail($"Failed to delete post: {ex.InnerException?.Message ?? ex.Message}");
            }
        }

        public async Task<UserDto[]> GetUsersAsync(string? searchText, string? role, int page, int pageSize)
        {
            var query = _context.Users.AsQueryable();

            if (!string.IsNullOrEmpty(searchText))
            {
                searchText = searchText.ToLower();
                query = query.Where(u => u.Name.ToLower().Contains(searchText) || u.Email.ToLower().Contains(searchText));
            }

            if (!string.IsNullOrEmpty(role))
            {
                query = query.Where(u => u.Role == role);
            }

            var users = await query
                .OrderBy(u => u.Name)
                .Skip((page - 1) * pageSize)
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

            return users;
        }

        public async Task<ApiResult> LockUserAsync(Guid userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
                return ApiResult.Fail("User not found");

            if (user.Role == "Admin")
                return ApiResult.Fail("Cannot lock an admin user");

            user.IsLocked = true;
            _context.Users.Update(user);
            await _context.SaveChangesAsync();

            await _hubContext.Clients.All.UserLocked(userId);
            return ApiResult.Success();
        }

        public async Task<ApiResult> UnlockUserAsync(Guid userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
                return ApiResult.Fail("User not found");

            user.IsLocked = false;
            _context.Users.Update(user);
            await _context.SaveChangesAsync();

            await _hubContext.Clients.All.UserUnlocked(userId);
            return ApiResult.Success();
        }

        public async Task<ApiResult> DeleteUserAsync(Guid userId)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                    return ApiResult.Fail("User not found");

                if (user.Role == "Admin")
                    return ApiResult.Fail("Cannot delete an admin user");

                var userPosts = await _context.Posts.Where(p => p.UserId == userId).ToListAsync();
                foreach (var post in userPosts)
                {
                    if (!string.IsNullOrEmpty(post.PhotoPath) && File.Exists(post.PhotoPath))
                    {
                        try
                        {
                            File.Delete(post.PhotoPath);
                        }
                        catch (Exception exFile)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error deleting post photo file: {exFile.Message}");
                        }
                    }
                    _context.Comments.RemoveRange(_context.Comments.Where(c => c.PostId == post.Id));
                    _context.Likes.RemoveRange(_context.Likes.Where(l => l.PostId == post.Id));
                    _context.Bookmarks.RemoveRange(_context.Bookmarks.Where(b => b.PostId == post.Id));
                    _context.Notifications.RemoveRange(_context.Notifications.Where(n => n.PostId == post.Id));
                    _context.Posts.Remove(post);
                }

                var userComments = await _context.Comments.Where(c => c.UserId == userId).ToListAsync();
                foreach (var comment in userComments)
                {
                    if (!string.IsNullOrEmpty(comment.PhotoPath) && File.Exists(comment.PhotoPath))
                    {
                        try
                        {
                            File.Delete(comment.PhotoPath);
                        }
                        catch (Exception exFile)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error deleting comment photo file: {exFile.Message}");
                        }
                    }
                    _context.Comments.Remove(comment);
                }

                _context.Likes.RemoveRange(_context.Likes.Where(l => l.UserId == userId));
                _context.Bookmarks.RemoveRange(_context.Bookmarks.Where(b => b.UserId == userId));
                _context.Notifications.RemoveRange(_context.Notifications.Where(n => n.ForUserId == userId));
                _context.Users.Remove(user);

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();

                await _hubContext.Clients.All.UserDeleted(userId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                System.Diagnostics.Debug.WriteLine($"DeleteUserAsync Error: {ex.Message}, Inner Exception: {ex.InnerException?.Message}");
                return ApiResult.Fail($"Failed to delete user: {ex.InnerException?.Message ?? ex.Message}");
            }
        }
        public async Task<CommentDto[]> GetCommentsAsync(int startIndex, int pageSize)
        {
            var comments = await _context.Comments
                .OrderByDescending(c => c.AddedOn)
                .Skip(startIndex)
                .Take(pageSize)
                .Select(c => new CommentDto
                {
                    CommentId = c.Id,
                    UserId = c.UserId,
                    UserName = c.User.Name,
                    UserPhotoUrl = c.User.PhotoUrl,
                    PostId = c.PostId,
                    Content = c.Content,
                    PhotoUrl = c.PhotoUrl,
                    AddedOn = c.AddedOn,
             
                    ParentCommentId = c.ParentCommentId
                })
                .ToArrayAsync();

            return comments;
        }
        public async Task<ApiResult> DeleteCommentAsync(Guid commentId)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var comment = await _context.Comments.FindAsync(commentId);
                if (comment == null)
                    return ApiResult.Fail("Comment not found");

                await DeleteCommentRecursivelyAsync(commentId);
                _context.Comments.Remove(comment);
                await _context.SaveChangesAsync();

                await transaction.CommitAsync();
                await _hubContext.Clients.All.CommentDeleted(commentId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync Error: {ex.Message}, Inner Exception: {ex.InnerException?.Message}");
                return ApiResult.Fail($"Failed to delete comment: {ex.InnerException?.Message ?? ex.Message}");
            }
        }

        private async Task DeleteCommentRecursivelyAsync(Guid commentId)
        {
            var childComments = await _context.Comments
                .Where(c => c.ParentCommentId == commentId)
                .ToListAsync();

            foreach (var child in childComments)
            {
                await DeleteCommentRecursivelyAsync(child.Id);
                if (!string.IsNullOrEmpty(child.PhotoPath) && File.Exists(child.PhotoPath))
                {
                    try
                    {
                        File.Delete(child.PhotoPath);
                    }
                    catch (Exception exFile)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error deleting comment photo file: {exFile.Message}");
                    }
                }
                _context.Comments.Remove(child);
            }
        }
    }
}