using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;

namespace SocialMauiApp.Api.Services
{
    public class SyncService
    {
        private readonly SQLiteContext _sqliteContext;
        private readonly DataContext _dataContext;
        private readonly ILogger<SyncService> _logger;
        private readonly SemaphoreSlim _syncSemaphore = new SemaphoreSlim(1, 1);

        public SyncService(SQLiteContext sqliteContext, DataContext dataContext, ILogger<SyncService> logger)
        {
            _sqliteContext = sqliteContext ?? throw new ArgumentNullException(nameof(sqliteContext));
            _dataContext = dataContext ?? throw new ArgumentNullException(nameof(dataContext));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public async Task SynchronizeAsync(CancellationToken cancellationToken = default)
        {
            await _syncSemaphore.WaitAsync(cancellationToken);
            try
            {
                _logger.LogInformation("Starting synchronization at {Time}.", DateTime.Now.ToString("HH:mm:ss"));

                if (!await _sqliteContext.Database.CanConnectAsync(cancellationToken))
                {
                    _logger.LogError("Cannot connect to SQLite database at {Time}.", DateTime.Now.ToString("HH:mm:ss"));
                    throw new InvalidOperationException("Cannot connect to SQLite database.");
                }

                var syncMetadata = await _sqliteContext.SyncMetadata.FirstOrDefaultAsync(cancellationToken);
                if (syncMetadata == null)
                {
                    syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = DateTime.MinValue };
                    await _sqliteContext.SyncMetadata.AddAsync(syncMetadata, cancellationToken);
                    await _sqliteContext.SaveChangesAsync(cancellationToken);
                    _logger.LogInformation("Initialized new SyncMetadata record at {Time}.", DateTime.Now.ToString("HH:mm:ss"));
                }

                var lastSyncTime = syncMetadata.LastSyncTime;
                _logger.LogInformation("Last synchronization time: {LastSyncTime} at {Time}.", lastSyncTime, DateTime.Now.ToString("HH:mm:ss"));

                await SyncLocalToServerAsync(cancellationToken);
                await SyncServerToLocalAsync(lastSyncTime, cancellationToken);

                // Update SyncMetadata with concurrency handling
                syncMetadata.LastSyncTime = DateTime.UtcNow;

                try
                {
                    _sqliteContext.SyncMetadata.Update(syncMetadata);
                    await _sqliteContext.SaveChangesAsync(cancellationToken);
                    _logger.LogInformation("Updated SyncMetadata with LastSyncTime={LastSyncTime} at {Time}.", syncMetadata.LastSyncTime, DateTime.Now.ToString("HH:mm:ss"));
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    _logger.LogWarning(ex, "Detected concurrency conflict at {Time}.", DateTime.Now.ToString("HH:mm:ss"));
                    var entry = ex.Entries.Single();
                    var databaseValues = await entry.GetDatabaseValuesAsync(cancellationToken);
                    if (databaseValues == null)
                    {
                        _logger.LogInformation("SyncMetadata record (Id={Id}) does not exist. Adding new record.", syncMetadata.Id);
                        await _sqliteContext.SyncMetadata.AddAsync(syncMetadata, cancellationToken);
                    }
                    else
                    {
                        entry.OriginalValues.SetValues(databaseValues);
                        _sqliteContext.SyncMetadata.Update(syncMetadata);
                    }
                    await _sqliteContext.SaveChangesAsync(cancellationToken);
                    _logger.LogInformation("Resolved concurrency conflict and updated SyncMetadata at {Time}.", DateTime.Now.ToString("HH:mm:ss"));
                }
            }
            catch (OperationCanceledException)
            {
                _logger.LogWarning("Synchronization was canceled at {Time}.", DateTime.Now.ToString("HH:mm:ss"));
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Synchronization error at {Time}: {Message}", DateTime.Now.ToString("HH:mm:ss"), ex.Message);
                throw;
            }
            finally
            {
                _syncSemaphore.Release();
            }
        }

        private async Task SyncLocalToServerAsync(CancellationToken cancellationToken)
        {
            _logger.LogDebug("Starting local-to-server synchronization.");

            // Sync Posts
            var localPendingPosts = await _sqliteContext.Posts
                .Where(p => !p.IsSynced && !p.IsDeleted)
                .ToListAsync(cancellationToken);
            if (localPendingPosts.Any())
            {
                foreach (var post in localPendingPosts)
                {
                    var serverPost = await _dataContext.Posts.FindAsync(new object[] { post.Id }, cancellationToken);
                    if (serverPost == null)
                    {
                        await _dataContext.Posts.AddAsync(post, cancellationToken);
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
                await _dataContext.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Synced {Count} posts to server.", localPendingPosts.Count);

                // Update sync status in SQLite
                foreach (var post in localPendingPosts)
                {
                    post.IsSynced = true;
                }
                await _sqliteContext.SaveChangesAsync(cancellationToken);
            }

            // Sync Comments
            var localPendingComments = await _sqliteContext.Comments
                .Where(c => !c.IsSynced)
                .ToListAsync(cancellationToken);
            if (localPendingComments.Any())
            {
                foreach (var comment in localPendingComments)
                {
                    var serverComment = await _dataContext.Comments.FindAsync(new object[] { comment.Id }, cancellationToken);
                    if (serverComment == null)
                    {
                        await _dataContext.Comments.AddAsync(comment, cancellationToken);
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
                await _dataContext.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Synced {Count} comments to server.", localPendingComments.Count);

                // Update sync status in SQLite
                foreach (var comment in localPendingComments)
                {
                    comment.IsSynced = true;
                }
                await _sqliteContext.SaveChangesAsync(cancellationToken);
            }
        }

        private async Task SyncServerToLocalAsync(DateTime lastSyncTime, CancellationToken cancellationToken)
        {
            _logger.LogDebug("Starting server-to-local synchronization with last sync time: {LastSyncTime}.", lastSyncTime);

            // Step 1: Sync Users from SQL Server to SQLite
            var serverUsers = await _dataContext.Users
                .Where(u => u.RefreshTokenExpiry > lastSyncTime || u.ResetTokenExpiry > lastSyncTime || (u.VerificationTokenExpiry.HasValue && u.VerificationTokenExpiry > lastSyncTime))
                .ToListAsync(cancellationToken);
            var userIds = serverUsers.Select(u => u.Id).ToList();

            // Fetch additional Users referenced by Posts and Comments
            var serverPosts = await _dataContext.Posts
                .Where(p => p.ModifiedOn > lastSyncTime)
                .ToListAsync(cancellationToken);
            var serverComments = await _dataContext.Comments
                .Where(c => c.AddedOn > lastSyncTime)
                .ToListAsync(cancellationToken);
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
                .ToListAsync(cancellationToken);
            var missingUserIds = allReferencedUserIds.Except(existingUserIds).ToList();

            if (missingUserIds.Any())
            {
                var missingUsers = await _dataContext.Users
                    .Where(u => missingUserIds.Contains(u.Id))
                    .ToListAsync(cancellationToken);
                serverUsers.AddRange(missingUsers);
            }

            foreach (var serverUser in serverUsers)
            {
                var localUser = await _sqliteContext.Users
                    .FirstOrDefaultAsync(u => u.Id == serverUser.Id, cancellationToken);
                if (localUser == null)
                {
                    await _sqliteContext.Users.AddAsync(serverUser, cancellationToken);
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
            await _sqliteContext.SaveChangesAsync(cancellationToken);
            _logger.LogInformation("Synced {Count} users to SQLite.", serverUsers.Count);

            // Step 2: Sync Posts from SQL Server to SQLite
            foreach (var serverPost in serverPosts)
            {
                var localPost = await _sqliteContext.Posts
                    .FirstOrDefaultAsync(p => p.Id == serverPost.Id, cancellationToken);
                if (localPost == null)
                {
                    serverPost.IsSynced = true;
                    await _sqliteContext.Posts.AddAsync(serverPost, cancellationToken);
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
            await _sqliteContext.SaveChangesAsync(cancellationToken);
            _logger.LogInformation("Synced {Count} posts to SQLite.", serverPosts.Count);

            // Step 3: Get all PostIds that will be referenced by Comments
            var referencedPostIds = serverComments.Select(c => c.PostId).Distinct().ToList();
            var existingPostIds = await _sqliteContext.Posts
                .Where(p => referencedPostIds.Contains(p.Id))
                .Select(p => p.Id)
                .ToListAsync(cancellationToken);
            var missingPostIds = referencedPostIds.Except(existingPostIds).ToList();

            if (missingPostIds.Any())
            {
                var missingPosts = await _dataContext.Posts
                    .Where(p => missingPostIds.Contains(p.Id))
                    .ToListAsync(cancellationToken);
                foreach (var missingPost in missingPosts)
                {
                    missingPost.IsSynced = true;
                    await _sqliteContext.Posts.AddAsync(missingPost, cancellationToken);
                }
                await _sqliteContext.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Synced {Count} additional posts for comments to SQLite.", missingPosts.Count);
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
                .ToListAsync(cancellationToken);
            var missingParentCommentIds = parentCommentIds.Except(existingCommentIds).ToList();

            if (missingParentCommentIds.Any())
            {
                var missingParentComments = await _dataContext.Comments
                    .Where(c => missingParentCommentIds.Contains(c.Id))
                    .ToListAsync(cancellationToken);
                foreach (var missingParentComment in missingParentComments)
                {
                    var localParentComment = await _sqliteContext.Comments
                        .FirstOrDefaultAsync(c => c.Id == missingParentComment.Id, cancellationToken);
                    if (localParentComment == null)
                    {
                        missingParentComment.IsSynced = true;
                        await _sqliteContext.Comments.AddAsync(missingParentComment, cancellationToken);
                    }
                }
                await _sqliteContext.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Synced {Count} parent comments to SQLite.", missingParentComments.Count);
            }

            // Step 5: Sync Comments from SQL Server to SQLite
            foreach (var serverComment in serverComments)
            {
                var localComment = await _sqliteContext.Comments
                    .FirstOrDefaultAsync(c => c.Id == serverComment.Id, cancellationToken);
                if (localComment == null)
                {
                    serverComment.IsSynced = true;
                    await _sqliteContext.Comments.AddAsync(serverComment, cancellationToken);
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
            await _sqliteContext.SaveChangesAsync(cancellationToken);
            _logger.LogInformation("Synced {Count} comments to SQLite.", serverComments.Count);
        }

        public async Task<List<Post>> GetPostsSinceAsync(DateTime since, CancellationToken cancellationToken = default)
        {
            _logger.LogDebug("Retrieving posts modified since {Since}.", since);
            return await _dataContext.Posts
                .Where(p => p.ModifiedOn > since)
                .ToListAsync(cancellationToken);
        }

        public async Task<bool> UpsertPostsAsync(List<Post> posts, CancellationToken cancellationToken = default)
        {
            try
            {
                _logger.LogDebug("Upserting {Count} posts.", posts?.Count ?? 0);
                if (posts == null || !posts.Any())
                {
                    _logger.LogWarning("No posts provided for upsert.");
                    return true;
                }

                foreach (var post in posts)
                {
                    var existingPost = await _dataContext.Posts.FindAsync(new object[] { post.Id }, cancellationToken);
                    if (existingPost == null)
                    {
                        await _dataContext.Posts.AddAsync(post, cancellationToken);
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
                await _dataContext.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Successfully upserted {Count} posts.", posts.Count);
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error upserting posts: {Message}", ex.Message);
                return false;
            }
        }

        public async Task<List<Comment>> GetCommentsSinceAsync(DateTime since, Guid postId, CancellationToken cancellationToken = default)
        {
            _logger.LogDebug("Retrieving comments for PostId {PostId} added since {Since}.", postId, since);
            return await _dataContext.Comments
                .Where(c => c.AddedOn > since && c.PostId == postId)
                .ToListAsync(cancellationToken);
        }

        public async Task<bool> UpsertCommentsAsync(List<Comment> comments, CancellationToken cancellationToken = default)
        {
            try
            {
                _logger.LogDebug("Upserting {Count} comments.", comments?.Count ?? 0);
                if (comments == null || !comments.Any())
                {
                    _logger.LogWarning("No comments provided for upsert.");
                    return true;
                }

                foreach (var comment in comments)
                {
                    var existingComment = await _dataContext.Comments.FindAsync(new object[] { comment.Id }, cancellationToken);
                    if (existingComment == null)
                    {
                        await _dataContext.Comments.AddAsync(comment, cancellationToken);
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
                await _dataContext.SaveChangesAsync(cancellationToken);
                _logger.LogInformation("Successfully upserted {Count} comments.", comments.Count);
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error upserting comments: {Message}", ex.Message);
                return false;
            }
        }
    }
}