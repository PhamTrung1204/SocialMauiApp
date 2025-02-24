using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Api.Services
{
    public class PostService
    {
        private readonly DataContext _context;
        private readonly PhotoUploadService _photoUploadService;

        public PostService(DataContext context, PhotoUploadService photoUploadService)
        {
            _context = context;
            _photoUploadService = photoUploadService;
        }
        public async Task<ApiResult> SavePostAsync(SavePostDto dto, Guid userId)
        {
            string? _existingPhotoPath = null;
            if (dto.PostId == default)
            {
                var post = new Post
                {
                    Content = dto.Content,
                    PostedOn = DateTime.UtcNow,
                    UserId = userId
                };
                if (dto.Photo is not null)
                {
                    (post.PhotoPath, post.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", userId.ToString(), "posts");
                }
                _context.Posts.Add(post);
            }
            else
            {
                var post = await _context.Posts.FindAsync(dto.PostId);
                if (post is null)
                {
                    return ApiResult.Fail("Post no longer exists");
                }
                if (post.UserId != userId)
                {
                    return ApiResult.Fail("Permission Denied");
                }
                post.Content = dto.Content;
                post.ModifiedOn = DateTime.UtcNow;
                if (dto.Photo is not null)
                {
                    _existingPhotoPath = post.PhotoPath;
                    (post.PhotoPath, post.PhotoUrl) = await _photoUploadService.SavePhotoAsync(dto.Photo, "uploads", "images", "users", userId.ToString(), "posts");

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
            }
            try
            {
                await _context.SaveChangesAsync();
                if (!string.IsNullOrEmpty(_existingPhotoPath) && File.Exists(_existingPhotoPath))
                {
                    File.Delete(_existingPhotoPath);
                }
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }

        }

        //public async Task<(string PhotoPath, string PhotoUrl)> SavePostPhotoAsync(IFormFile photo, Guid userId)
        //{
        //    var targetFolderPath = Path.Combine(_webHostEnvironment.WebRootPath, "uploads", "images", "users", userId.ToString(), "posts");
        //    if (!Directory.Exists(targetFolderPath))
        //    {
        //        Directory.CreateDirectory(targetFolderPath);
        //    }
        //    var extension = Path.GetExtension(photo.FileName);
        //    var newPhotoName = $"{Guid.NewGuid()}_{DateTime.UtcNow.Ticks}{extension}";
        //    var fullPhotoPath = Path.Combine(targetFolderPath, newPhotoName);
        //    using FileStream fs = File.Create(fullPhotoPath);
        //    await photo.CopyToAsync(fs);
        //    var domainUrl = _configuration.GetValue<string>("Domain").TrimEnd('/');
        //    var photoUrl = $"{domainUrl}/uploads/images/users/{userId}/posts/{newPhotoName}";
        //    return (fullPhotoPath, photoUrl);
        //}
        //public async Task<PostDto[]> GetPostsAsync(int startIndex, int pageSize, Guid currentUserId)
        //{
        //    var posts = await _context.Posts
        //                        .Include(p => p.User)
        //                        .Where(p => !p.IsDeleted)
        //                        .OrderByDescending(p => p.PostOn)
        //                        .Select(p => new PostDto
        //                        {
        //                            Content = p.Content,
        //                            ModifiedOn = p.ModifiedOn,
        //                            PhotoUrl = p.PhotoUrl,
        //                            PostId = p.Id,
        //                            PostedOn = p.PostOn,
        //                            UserId = currentUserId,
        //                            UserName = p.User.Name,
        //                            UserPhotoUrl = p.User.PhotoUrl
        //                        })
        //                        .Skip(startIndex).Take(pageSize)
        //                        .ToArrayAsync();
        //    var postIds = posts.Select(p => p.PostId).ToArray();
        //    var postsLikeByThisUser = await _context.Likes
        //        .Where(l => l.UserId == currentUserId && postIds.Contains(l.PostId))
        //        .Select(l => l.PostId).ToArrayAsync();
        //    var postsSaveByThisUser = await _context.Bookmarks
        //        .Where(l => l.UserId == currentUserId && postIds.Contains(l.PostId))
        //        .Select(l => l.PostId).ToArrayAsync();
        //    foreach ( var post in posts)
        //    {
        //        post.IsLiked = postsLikeByThisUser.Contains(post.UserId);
        //        post.IsBookmarked = postsSaveByThisUser.Contains(post.UserId);
        //    }
        //    return posts;
        //}
        public async Task<PostDto[]> GetPostsAsync(int startIndex, int pageSize, Guid currentUserId)
        {
            var posts = await _context.Set<PostDto>()
                .FromSqlInterpolated($"EXEC GetPosts @StartIndex={startIndex},@PageSize={pageSize},@CurrentUserId={currentUserId}")
                .ToArrayAsync();
            return posts;
        }
        public async Task<ApiResult<CommentDto>> SaveCommentAsync(SaveCommentDto dto, LoggedInUser currentUser)
        {
            Comment? comment = null;
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
            }
            else
            {
                comment = await _context.Comments.FindAsync(currentUser.Id);
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
                    AddOn = comment.AddedOn,
                    CommentId = comment.Id,
                    Content = comment.Content,
                    PostId = comment.PostId,
                    UserId = currentUser.Id,
                    UserName = currentUser.Name,
                    UserPhotoUrl = currentUser.PhotoUrl
                };
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
                AddOn = c.AddedOn,
                CommentId = c.Id,
                Content = c.Content,
                PostId = postId,
                UserId = c.UserId,
                UserName = c.User.Name,
                UserPhotoUrl = c.User.PhotoUrl
            })
            .ToArrayAsync();
        public async Task<ApiResult> ToggleLikeAsync(Guid postId, Guid currentUserId)
        {
            var postExists = await _context.Posts.AnyAsync(p => p.Id == postId);
            if (!postExists)
            {
                return ApiResult.Fail("Post not found");
            }
            try
            {
                var like = await _context.Likes.FirstOrDefaultAsync(l => l.PostId == postId && l.UserId == currentUserId);
                if (like is null)
                {
                    like = new Likes
                    {
                        PostId = postId,
                        UserId = currentUserId
                    };
                    _context.Likes.Add(like);
                }
                else
                {
                    _context.Likes.Remove(like);
                }
                await _context.SaveChangesAsync();
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }
        public async Task<ApiResult> ToggleBookmarkAsync(Guid postId, Guid currentUserId)
        {
            var postExists = await _context.Posts.AnyAsync(p => p.Id == postId);
            if (!postExists)
            {
                return ApiResult.Fail("Post not found");
            }
            try
            {
                var bookmark = await _context.Bookmarks.FirstOrDefaultAsync(l => l.PostId == postId && l.UserId == currentUserId);
                if (bookmark is null)
                {
                    bookmark = new Bookmarks
                    {
                        PostId = postId,
                        UserId = currentUserId
                    };
                    _context.Bookmarks.Add(bookmark);
                }
                else
                {
                    _context.Bookmarks.Remove(bookmark);
                }
                await _context.SaveChangesAsync();
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
                _context.Posts.Remove(post);
                await _context.SaveChangesAsync();
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                return ApiResult.Fail(ex.Message);
            }
        }

    }
}

