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
                Console.WriteLine($"Bắt đầu đồng bộ hóa tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");

                if (!_sqliteContext.Database.CanConnect())
                {
                    Console.WriteLine($"Không thể kết nối đến cơ sở dữ liệu SQLite tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                    throw new Exception("Không thể kết nối đến cơ sở dữ liệu SQLite.");
                }

                var syncMetadata = await _sqliteContext.SyncMetadata.FirstOrDefaultAsync();
                if (syncMetadata == null)
                {
                    syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = DateTime.MinValue };
                    await _sqliteContext.SyncMetadata.AddAsync(syncMetadata);
                    await _sqliteContext.SaveChangesAsync();
                    Console.WriteLine($"Đã khởi tạo bản ghi SyncMetadata mới tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }

                var lastSyncTime = syncMetadata.LastSyncTime;
                Console.WriteLine($"Thời gian đồng bộ gần nhất: {lastSyncTime} tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");

                await SyncLocalToServerAsync();
                await SyncServerToLocalAsync(lastSyncTime);

                // Cập nhật SyncMetadata với xử lý đồng thời
                syncMetadata.LastSyncTime = DateTime.UtcNow;

                try
                {
                    _sqliteContext.SyncMetadata.Update(syncMetadata);
                    await _sqliteContext.SaveChangesAsync();
                    Console.WriteLine($"Đã cập nhật SyncMetadata với LastSyncTime={syncMetadata.LastSyncTime} tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    Console.WriteLine($"Phát hiện xung đột đồng thời tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                    var entry = ex.Entries.Single();
                    var databaseValues = entry.GetDatabaseValues();
                    if (databaseValues == null)
                    {
                        Console.WriteLine($"Bản ghi SyncMetadata (Id={syncMetadata.Id}) không tồn tại. Thêm mới bản ghi.");
                        await _sqliteContext.SyncMetadata.AddAsync(syncMetadata);
                    }
                    else
                    {
                        entry.OriginalValues.SetValues(databaseValues);
                        _sqliteContext.SyncMetadata.Update(syncMetadata);
                    }
                    await _sqliteContext.SaveChangesAsync();
                    Console.WriteLine($"Đã giải quyết xung đột đồng thời và cập nhật SyncMetadata tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Lỗi đồng bộ: {ex.Message} tại {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
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
            // Step 1: Đồng bộ Users từ SQL Server xuống SQLite
            var serverUsers = await _dataContext.Users
                .Where(u => u.RefreshTokenExpiry > lastSyncTime || u.ResetTokenExpiry > lastSyncTime || (u.VerificationTokenExpiry.HasValue && u.VerificationTokenExpiry > lastSyncTime))
                .ToListAsync();
            var userIds = serverUsers.Select(u => u.Id).ToList();

            // Fetch additional Users referenced by Posts and Comments
            var serverPosts = await _dataContext.Posts
                .Where(p => p.ModifiedOn > lastSyncTime)
                .ToListAsync();
            var serverComments = await _dataContext.Comments
                .Where(c => c.AddedOn > lastSyncTime)
                .ToListAsync();
            var referencedUserIdsFromPosts = serverPosts.Select(p => p.UserId).Distinct().ToList();
            var referencedUserIdsFromComments = serverComments.Select(c => c.UserId).Distinct().ToList();
            var allReferencedUserIds = userIds
                .Union(referencedUserIdsFromPosts)
                .Union(referencedUserIdsFromComments)
                .Distinct()
                .ToList();

            var existingUserIds = await _sqliteContext.Users
                .Where(u => allReferencedUserIds.Contains(u.Id))
                .Select(u => u.Id)
                .ToListAsync();
            var missingUserIds = allReferencedUserIds.Except(existingUserIds).ToList();

            if (missingUserIds.Any())
            {
                var missingUsers = await _dataContext.Users
                    .Where(u => missingUserIds.Contains(u.Id))
                    .ToListAsync();
                serverUsers.AddRange(missingUsers);
            }

            foreach (var serverUser in serverUsers)
            {
                var localUser = await _sqliteContext.Users
                    .FirstOrDefaultAsync(u => u.Id == serverUser.Id);
                if (localUser == null)
                {
                    await _sqliteContext.Users.AddAsync(serverUser);
                }
                else
                {
                    localUser.Name = serverUser.Name;
                    localUser.Email = serverUser.Email;
                    localUser.PasswordHash = serverUser.PasswordHash;
                    localUser.Role = serverUser.Role;
                    localUser.EmailConfirmed = serverUser.EmailConfirmed;
                    localUser.VerificationToken = serverUser.VerificationToken;
                    localUser.VerificationTokenExpiry = serverUser.VerificationTokenExpiry;
                    localUser.ResetToken = serverUser.ResetToken;
                    localUser.ResetTokenExpiry = serverUser.ResetTokenExpiry;
                    localUser.PhotoPath = serverUser.PhotoPath;
                    localUser.PhotoUrl = serverUser.PhotoUrl;
                    localUser.IsLocked = serverUser.IsLocked;
                    localUser.RefreshToken = serverUser.RefreshToken;
                    localUser.RefreshTokenExpiry = serverUser.RefreshTokenExpiry;
                }
            }
            await _sqliteContext.SaveChangesAsync();
            Console.WriteLine($"Synced {serverUsers.Count} users to SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");

            // Step 2: Đồng bộ Post từ SQL Server xuống SQLite
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
            await _sqliteContext.SaveChangesAsync();
            Console.WriteLine($"Synced {serverPosts.Count} posts to SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");

            // Step 3: Get all PostIds that will be referenced by Comments
            var referencedPostIds = serverComments.Select(c => c.PostId).Distinct().ToList();
            var existingPostIds = await _sqliteContext.Posts
                .Where(p => referencedPostIds.Contains(p.Id))
                .Select(p => p.Id)
                .ToListAsync();
            var missingPostIds = referencedPostIds.Except(existingPostIds).ToList();

            if (missingPostIds.Any())
            {
                var missingPosts = await _dataContext.Posts
                    .Where(p => missingPostIds.Contains(p.Id))
                    .ToListAsync();
                foreach (var missingPost in missingPosts)
                {
                    missingPost.IsSynced = true;
                    await _sqliteContext.Posts.AddAsync(missingPost);
                }
                await _sqliteContext.SaveChangesAsync();
                Console.WriteLine($"Synced {missingPosts.Count} additional posts for comments to SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
            }

            // Step 4: Ensure all parent Comments are synced before their replies
            var parentCommentIds = serverComments
                .Where(c => c.ParentCommentId.HasValue)
                .Select(c => c.ParentCommentId.Value)
                .Distinct()
                .ToList();
            var existingCommentIds = await _sqliteContext.Comments
                .Where(c => parentCommentIds.Contains(c.Id))
                .Select(c => c.Id)
                .ToListAsync();
            var missingParentCommentIds = parentCommentIds.Except(existingCommentIds).ToList();

            if (missingParentCommentIds.Any())
            {
                var missingParentComments = await _dataContext.Comments
                    .Where(c => missingParentCommentIds.Contains(c.Id))
                    .ToListAsync();
                foreach (var missingParentComment in missingParentComments)
                {
                    var localParentComment = await _sqliteContext.Comments
                        .FirstOrDefaultAsync(c => c.Id == missingParentComment.Id);
                    if (localParentComment == null)
                    {
                        missingParentComment.IsSynced = true;
                        await _sqliteContext.Comments.AddAsync(missingParentComment);
                    }
                }
                await _sqliteContext.SaveChangesAsync();
                Console.WriteLine($"Synced {missingParentComments.Count} parent comments to SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
            }

            // Step 5: Đồng bộ Comment từ SQL Server xuống SQLite
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
            Console.WriteLine($"Synced {serverComments.Count} comments to SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
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