using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;

namespace SocialMauiApp.Api.Services
{
    public class SyncService
    {
        private readonly SQLiteContext _sqliteContext;
        private readonly DataContext _dataContext;

        public SyncService(SQLiteContext sqliteContext, DataContext dataContext)
        {
            _sqliteContext = sqliteContext;
            _dataContext = dataContext;
        }

        public async Task SynchronizeAsync()
        {
            try
            {
                // Lấy thời gian đồng bộ gần nhất
                var syncMetadata = await _sqliteContext.SyncMetadata.FirstOrDefaultAsync();
                var lastSyncTime = syncMetadata?.LastSyncTime ?? DateTime.MinValue;

                // Đồng bộ từ SQLite lên SQL Server
                await SyncLocalToServerAsync();

                // Đồng bộ từ SQL Server xuống SQLite
                await SyncServerToLocalAsync(lastSyncTime);

                // Cập nhật thời gian đồng bộ
                syncMetadata = syncMetadata ?? new SyncMetadata();
                syncMetadata.LastSyncTime = DateTime.UtcNow;
                if (syncMetadata.Id == 0)
                    await _sqliteContext.SyncMetadata.AddAsync(syncMetadata);
                await _sqliteContext.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Sync error: {ex.Message}");
                throw;
            }
        }

        private async Task SyncLocalToServerAsync()
        {
            // Đồng bộ Post
            var localPendingPosts = await _sqliteContext.Posts
                .Where(p => !p.IsSynced && !p.IsDeleted)
                .ToListAsync();
            if (localPendingPosts.Any())
            {
                foreach (var post in localPendingPosts)
                {
                    var serverPost = await _dataContext.Posts.FindAsync(post.Id);
                    if (serverPost == null)
                    {
                        _dataContext.Posts.Add(post);
                    }
                    else
                    {
                        serverPost.Content = post.Content;
                        serverPost.PhotoPath = post.PhotoPath;
                        serverPost.PhotoUrl = post.PhotoUrl;
                        serverPost.ModifiedOn = post.ModifiedOn;
                        serverPost.IsDeleted = post.IsDeleted;
                        _dataContext.Posts.Update(serverPost);
                    }
                }
                await _dataContext.SaveChangesAsync();

                // Cập nhật trạng thái đồng bộ trong SQLite
                foreach (var post in localPendingPosts)
                {
                    post.IsSynced = true;
                }
                await _sqliteContext.SaveChangesAsync();
            }

            // Đồng bộ Comment
            var localPendingComments = await _sqliteContext.Comments
                .Where(c => !c.IsSynced)
                .ToListAsync();
            if (localPendingComments.Any())
            {
                foreach (var comment in localPendingComments)
                {
                    var serverComment = await _dataContext.Comments.FindAsync(comment.Id);
                    if (serverComment == null)
                    {
                        _dataContext.Comments.Add(comment);
                    }
                    else
                    {
                        serverComment.Content = comment.Content;
                        serverComment.PhotoPath = comment.PhotoPath;
                        serverComment.PhotoUrl = comment.PhotoUrl;
                        serverComment.AddedOn = comment.AddedOn;
                        _dataContext.Comments.Update(serverComment);
                    }
                }
                await _dataContext.SaveChangesAsync();

                // Cập nhật trạng thái đồng bộ trong SQLite
                foreach (var comment in localPendingComments)
                {
                    comment.IsSynced = true;
                }
                await _sqliteContext.SaveChangesAsync();
            }
        }

        private async Task SyncServerToLocalAsync(DateTime lastSyncTime)
        {
            // Đồng bộ Post từ SQL Server xuống SQLite
            var serverPosts = await _dataContext.Posts
                .Where(p => p.ModifiedOn > lastSyncTime)
                .ToListAsync();
            foreach (var serverPost in serverPosts)
            {
                var localPost = await _sqliteContext.Posts
                    .FirstOrDefaultAsync(p => p.Id == serverPost.Id);
                if (localPost == null)
                {
                    serverPost.IsSynced = true;
                    await _sqliteContext.Posts.AddAsync(serverPost);
                }
                else if (serverPost.ModifiedOn > localPost.ModifiedOn)
                {
                    localPost.Content = serverPost.Content;
                    localPost.PhotoPath = serverPost.PhotoPath;
                    localPost.PhotoUrl = serverPost.PhotoUrl;
                    localPost.ModifiedOn = serverPost.ModifiedOn;
                    localPost.IsDeleted = serverPost.IsDeleted;
                    localPost.IsSynced = true;
                }
            }

            // Đồng bộ Comment từ SQL Server xuống SQLite
            var serverComments = await _dataContext.Comments
                .Where(c => c.AddedOn > lastSyncTime)
                .ToListAsync();
            foreach (var serverComment in serverComments)
            {
                var localComment = await _sqliteContext.Comments
                    .FirstOrDefaultAsync(c => c.Id == serverComment.Id);
                if (localComment == null)
                {
                    serverComment.IsSynced = true;
                    await _sqliteContext.Comments.AddAsync(serverComment);
                }
                else if (serverComment.AddedOn > localComment.AddedOn)
                {
                    localComment.Content = serverComment.Content;
                    localComment.PhotoPath = serverComment.PhotoPath;
                    localComment.PhotoUrl = serverComment.PhotoUrl;
                    localComment.AddedOn = serverComment.AddedOn;
                    localComment.IsSynced = true;
                }
            }

            await _sqliteContext.SaveChangesAsync();
        }

        // Phương thức lấy Post từ SQL Server dựa trên thời gian (dành cho endpoint)
        public async Task<List<Post>> GetPostsSinceAsync(DateTime since)
        {
            return await _dataContext.Posts
                .Where(p => p.ModifiedOn > since)
                .ToListAsync();
        }

        // Phương thức cập nhật hoặc chèn Post vào SQL Server (dành cho endpoint)
        public async Task<bool> UpsertPostsAsync(List<Post> posts)
        {
            try
            {
                foreach (var post in posts)
                {
                    var existingPost = await _dataContext.Posts.FindAsync(post.Id);
                    if (existingPost == null)
                    {
                        _dataContext.Posts.Add(post);
                    }
                    else
                    {
                        existingPost.Content = post.Content;
                        existingPost.PhotoPath = post.PhotoPath;
                        existingPost.PhotoUrl = post.PhotoUrl;
                        existingPost.ModifiedOn = post.ModifiedOn;
                        existingPost.IsDeleted = post.IsDeleted;
                        _dataContext.Posts.Update(existingPost);
                    }
                }
                await _dataContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"UpsertPostsAsync Error: {ex.Message}");
                return false;
            }
        }

        // Phương thức lấy Comment từ SQL Server dựa trên thời gian (dành cho endpoint)
        public async Task<List<Comment>> GetCommentsSinceAsync(DateTime since, Guid postId)
        {
            return await _dataContext.Comments
                .Where(c => c.AddedOn > since && c.PostId == postId)
                .ToListAsync();
        }

        // Phương thức cập nhật hoặc chèn Comment vào SQL Server (dành cho endpoint)
        public async Task<bool> UpsertCommentsAsync(List<Comment> comments)
        {
            try
            {
                foreach (var comment in comments)
                {
                    var existingComment = await _dataContext.Comments.FindAsync(comment.Id);
                    if (existingComment == null)
                    {
                        _dataContext.Comments.Add(comment);
                    }
                    else
                    {
                        existingComment.Content = comment.Content;
                        existingComment.PhotoPath = comment.PhotoPath;
                        existingComment.PhotoUrl = comment.PhotoUrl;
                        existingComment.AddedOn = comment.AddedOn;
                        _dataContext.Comments.Update(existingComment);
                    }
                }
                await _dataContext.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"UpsertCommentsAsync Error: {ex.Message}");
                return false;
            }
        }
    }
}