//using Microsoft.EntityFrameworkCore;
//using SocialMauiApp.Api.Data;
//using SocialMauiApp.Api.Data.Entities;
//using SocialMediaMaui.Shared.Dtos;
//using System;
//using System.Linq;
//using System.Threading.Tasks;

//namespace SocialMauiApp.Api.Services
//{
//    public class AdminService
//    {
//        private readonly DataContext _context;
//        private readonly PhotoUploadService _photoUploadService;
//        public AdminService(DataContext context)
//        {
//            _context = context;
//        }

//        // Dashboard
//        public async Task<DashboardDto> GetDashboardAsync()
//        {
//            var postCount = await _context.Posts.CountAsync();
//            var userCount = await _context.Users.CountAsync();
//            var commentCount = await _context.Comments.CountAsync();
//            var likeCount = await _context.Likes.CountAsync();

//            return new DashboardDto
//            {
//                PostCount = postCount,
//                UserCount = userCount,
//                CommentCount = commentCount,
//                LikeCount = likeCount
//            };
//        }

//        // Quản lý người dùng
//        public async Task<UserDto[]> GetUsersAsync(string? search, string? role, int page, int pageSize)
//        {
//            var query = _context.Users.AsQueryable();

//            if (!string.IsNullOrEmpty(search))
//            {
//                query = query.Where(u => u.Name.Contains(search) || u.Email.Contains(search));
//            }

//            if (!string.IsNullOrEmpty(role))
//            {
//                query = query.Where(u => u.Role == role);
//            }

//            var users = await query.OrderBy(u => u.Name)
//                                   .Skip((page - 1) * pageSize)
//                                   .Take(pageSize)
//                                   .Select(u => new UserDto
//                                   {
//                                       Id = u.Id,
//                                       Name = u.Name,
//                                       Email = u.Email,
//                                       Role = u.Role,
//                                       IsLocked = u.IsLocked
//                                   })
//                                   .ToArrayAsync();
//            return users;
//        }

//        public async Task<ApiResult> LockUserAsync(Guid userId)
//        {
//            var user = await _context.Users.FindAsync(userId);
//            if (user == null)
//                return ApiResult.Fail("User not found");

//            user.IsLocked = true;
//            await _context.SaveChangesAsync();
//            return ApiResult.Success();
//        }

//        public async Task<ApiResult> UnlockUserAsync(Guid userId)
//        {
//            var user = await _context.Users.FindAsync(userId);
//            if (user == null)
//                return ApiResult.Fail("User not found");

//            user.IsLocked = false;
//            await _context.SaveChangesAsync();
//            return ApiResult.Success();
//        }

//        public async Task<ApiResult> ChangeUserRoleAsync(Guid userId, string newRole)
//        {
//            var user = await _context.Users.FindAsync(userId);
//            if (user == null)
//                return ApiResult.Fail("User not found");

//            user.Role = newRole;
//            await _context.SaveChangesAsync();
//            return ApiResult.Success();
//        }

//        // Quản lý bài viết
//        public async Task<PostDto[]> GetPostsForAdminAsync(string? search, Guid? authorId, string? status, int page, int pageSize)
//        {
//            var query = _context.Posts.AsQueryable();

//            if (!string.IsNullOrEmpty(search))
//            {
//                query = query.Where(p => p.Content.Contains(search));
//            }

//            if (authorId.HasValue)
//            {
//                query = query.Where(p => p.UserId == authorId.Value);
//            }

//            var posts = await query.OrderByDescending(p => p.PostedOn)
//                                   .Skip((page - 1) * pageSize)
//                                   .Take(pageSize)
//                                   .Select(p => new PostDto
//                                   {
//                                       PostId = p.Id,
//                                       Content = p.Content,
//                                       PhotoUrl = p.PhotoUrl,
//                                       PostedOn = p.PostedOn,
//                                       UserId = p.UserId,
//                                       UserName = p.User.Name,
                                      
//                                   })
//                                   .ToArrayAsync();
//            return posts;
//        }

//        public async Task<ApiResult> DeletePostByAdminAsync(Guid postId)
//        {
//            using var transaction = await _context.Database.BeginTransactionAsync();
//            try
//            {
//                var post = await _context.Posts.FirstOrDefaultAsync(p => p.Id == postId);
//                if (post == null)
//                    return ApiResult.Fail("Post not found");

//                if (!string.IsNullOrEmpty(post.PhotoPath) && File.Exists(post.PhotoPath))
//                {
//                    File.Delete(post.PhotoPath);
//                }

//                _context.Comments.RemoveRange(_context.Comments.Where(c => c.PostId == postId));
//                _context.Likes.RemoveRange(_context.Likes.Where(l => l.PostId == postId));
//                _context.Bookmarks.RemoveRange(_context.Bookmarks.Where(b => b.PostId == postId));
//                _context.Notifications.RemoveRange(_context.Notifications.Where(n => n.PostId == postId));
//                _context.Posts.Remove(post);

//                await _context.SaveChangesAsync();
//                await transaction.CommitAsync();
//                return ApiResult.Success();
//            }
//            catch (Exception ex)
//            {
//                await transaction.RollbackAsync();
//                return ApiResult.Fail(ex.Message);
//            }
//        }

//        public async Task<ApiResult<PostDto>> UpdatePostByAdminAsync(Guid postId, SavePostDto dto)
//        {
//            var post = await _context.Posts.FindAsync(postId);
//            if (post == null)
//                return ApiResult<PostDto>.Fail("Post not found");

//            post.Content = dto.Content;
//            post.ModifiedOn = DateTime.Now;
//            string? existingPhotoPath = null;

//            if (dto.Photo != null)
//            {
//                existingPhotoPath = post.PhotoPath;
//                (post.PhotoPath, post.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", post.UserId.ToString(), "posts");
//            }
//            else if (dto.IsExistingPhotoRemoved)
//            {
//                existingPhotoPath = post.PhotoPath;
//                post.PhotoPath = null;
//                post.PhotoUrl = null;
//            }

//            try
//            {
//                _context.Posts.Update(post);
//                await _context.SaveChangesAsync();

//                if (!string.IsNullOrEmpty(existingPhotoPath) && File.Exists(existingPhotoPath))
//                {
//                    File.Delete(existingPhotoPath);
//                }

//                var postDto = new PostDto
//                {
//                    PostId = post.Id,
//                    Content = post.Content,
//                    PhotoUrl = post.PhotoUrl,
//                    PostedOn = post.PostedOn,
//                    ModifiedOn = post.ModifiedOn,
//                    UserId = post.UserId,
//                    UserName = post.User.Name
//                };
//                return ApiResult<PostDto>.Success(postDto);
//            }
//            catch (Exception ex)
//            {
//                return ApiResult<PostDto>.Fail(ex.Message);
//            }
//        }

//        // Quản lý bình luận
//        public async Task<CommentDto[]> GetCommentsForAdminAsync(string? search, Guid? postId, Guid? authorId, int page, int pageSize)
//        {
//            var query = _context.Comments.AsQueryable();

//            if (!string.IsNullOrEmpty(search))
//            {
//                query = query.Where(c => c.Content.Contains(search));
//            }

//            if (postId.HasValue)
//            {
//                query = query.Where(c => c.PostId == postId.Value);
//            }

//            if (authorId.HasValue)
//            {
//                query = query.Where(c => c.UserId == authorId.Value);
//            }

//            var comments = await query.OrderByDescending(c => c.AddedOn)
//                                      .Skip((page - 1) * pageSize)
//                                      .Take(pageSize)
//                                      .Select(c => new CommentDto
//                                      {
//                                          CommentId = c.Id,
//                                          Content = c.Content,
//                                          PostId = c.PostId,
//                                          UserId = c.UserId,
//                                          UserName = c.User.Name,
//                                          PhotoUrl = c.PhotoUrl,
//                                          AddedOn = c.AddedOn,
//                                          ParentCommentId = c.ParentCommentId
//                                      })
//                                      .ToArrayAsync();
//            return comments;
//        }

//        public async Task<ApiResult> DeleteCommentByAdminAsync(Guid commentId)
//        {
//            using var transaction = await _context.Database.BeginTransactionAsync();
//            try
//            {
//                var comment = await _context.Comments.FindAsync(commentId);
//                if (comment == null)
//                    return ApiResult.Fail("Comment not found");

//                await DeleteCommentRecursivelyAsync(commentId);
//                _context.Comments.Remove(comment);
//                await _context.SaveChangesAsync();

//                await transaction.CommitAsync();
//                return ApiResult.Success();
//            }
//            catch (Exception ex)
//            {
//                await transaction.RollbackAsync();
//                return ApiResult.Fail(ex.Message);
//            }
//        }

//        private async Task DeleteCommentRecursivelyAsync(Guid commentId)
//        {
//            var childComments = await _context.Comments
//                .Where(c => c.ParentCommentId == commentId)
//                .ToListAsync();

//            foreach (var child in childComments)
//            {
//                await DeleteCommentRecursivelyAsync(child.Id);
//                if (!string.IsNullOrEmpty(child.PhotoPath) && File.Exists(child.PhotoPath))
//                {
//                    File.Delete(child.PhotoPath);
//                }
//                _context.Comments.Remove(child);
//            }
//        }
//    }
//}