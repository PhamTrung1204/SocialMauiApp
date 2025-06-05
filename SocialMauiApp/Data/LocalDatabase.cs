using SQLite;
using SocialMediaMaui.Shared.Dtos;
using System.IO;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace SocialMauiApp.Data
{
    public class LocalDatabase
    {
        private readonly SQLiteAsyncConnection _database;
        private bool _isInitialized;

        public LocalDatabase()
        {
            var dbPath = Path.Combine(FileSystem.AppDataDirectory, "local_socialmauiapp.db");
            _database = new SQLiteAsyncConnection(dbPath);
            _isInitialized = false;
        }

        public async Task InitializeAsync()
        {
            if (_isInitialized) return;

            try
            {
                var dbPath = Path.Combine(FileSystem.AppDataDirectory, "local_socialmauiapp.db");
                Console.WriteLine($"Initializing database at: {dbPath} at 11:44 AM +07, 27/05/2025.");

                await _database.CreateTableAsync<PostEntity>();
                Console.WriteLine("Posts table created or verified.");

                await _database.CreateTableAsync<CommentEntity>();
                Console.WriteLine("Comments table created or verified.");

                await _database.CreateTableAsync<SyncMetadata>();
                Console.WriteLine("SyncMetadata table created or verified.");

                await _database.ExecuteAsync("CREATE INDEX IF NOT EXISTS idx_postid ON Comments (PostId, ParentCommentId);");
                await _database.ExecuteAsync("CREATE INDEX IF NOT EXISTS idx_postid ON Posts (PostId);");
                Console.WriteLine("Indexes created or verified for Comments and Posts.");

                _isInitialized = true;
                Console.WriteLine("Database initialized successfully at 11:44 AM +07, 27/05/2025.");
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite error initializing database: {ex.Message}");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error initializing database: {ex.Message}");
                throw;
            }
        }

        // Methods for Posts
        public async Task<List<PostEntity>> GetPostsAsync()
        {
            await InitializeAsync();
            return await _database.Table<PostEntity>().ToListAsync();
        }

        public async Task<PostEntity> GetPostAsync(Guid postId)
        {
            await InitializeAsync();
            return await _database.Table<PostEntity>().FirstOrDefaultAsync(p => p.PostId == postId);
        }

        public async Task<int> SavePostAsync(PostEntity post)
        {
            await InitializeAsync();
            var existingPost = await _database.Table<PostEntity>().FirstOrDefaultAsync(p => p.PostId == post.PostId);
            if (existingPost != null)
            {
                return await _database.UpdateAsync(post);
            }
            return await _database.InsertAsync(post);
        }

        public async Task<int> DeletePostAsync(Guid postId)
        {
            await InitializeAsync();
            var post = await _database.Table<PostEntity>().FirstOrDefaultAsync(p => p.PostId == postId);
            if (post != null)
            {
                return await _database.DeleteAsync(post);
            }
            return 0;
        }

        // Methods for Comments
        public async Task<List<CommentDto>> GetCommentsAsync(Guid postId, int startIndex, int pageSize)
        {
            try
            {
                await InitializeAsync();
                var tableInfo = await _database.ExecuteScalarAsync<int>("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='Comments'");
                if (tableInfo == 0)
                {
                    Console.WriteLine($"Comments table does not exist at 11:44 AM +07, 27/05/2025.");
                    return new List<CommentDto>();
                }

                // Tải tất cả bình luận và phản hồi cùng lúc để tối ưu hóa
                var allCommentEntities = await _database.Table<CommentEntity>()
                    .Where(c => c.PostId == postId)
                    .ToListAsync();

                // Lọc bình luận cấp cao
                var topLevelComments = allCommentEntities
                    .Where(c => !c.ParentCommentId.HasValue)
                    .OrderByDescending(c => c.AddedOn)
                    .Skip(startIndex)
                    .Take(pageSize)
                    .ToList();

                var comments = new List<CommentDto>();
                foreach (var entity in topLevelComments)
                {
                    var comment = ToCommentDto(entity);
                    comment.Replies = new ObservableCollection<CommentDto>(BuildReplyHierarchy(allCommentEntities, comment.CommentId, 0));
                    comments.Add(comment);
                    Console.WriteLine($"Loaded comment {comment.CommentId} with {comment.Replies.Count} replies for post {postId}.");
                }

                Console.WriteLine($"Loaded {comments.Count} top-level comments for post {postId} (startIndex: {startIndex}, pageSize: {pageSize}) at 11:44 AM +07, 27/05/2025.");
                return comments;
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite error loading comments for post {postId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                return new List<CommentDto>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error loading comments for post {postId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                return new List<CommentDto>();
            }
        }

        private List<CommentDto> BuildReplyHierarchy(List<CommentEntity> allComments, Guid parentCommentId, int level, int maxDepth = 5)
        {
            if (level >= maxDepth)
            {
                Console.WriteLine($"Reached max reply depth ({maxDepth}) for parent comment {parentCommentId} at 11:44 AM +07, 27/05/2025.");
                return new List<CommentDto>();
            }

            var replies = allComments
                .Where(c => c.ParentCommentId == parentCommentId)
                .OrderByDescending(c => c.AddedOn)
                .ToList();

            var result = new List<CommentDto>();
            foreach (var replyEntity in replies)
            {
                var reply = ToCommentDto(replyEntity);
                reply.Level = level + 1;
                reply.Replies = new ObservableCollection<CommentDto>(BuildReplyHierarchy(allComments, reply.CommentId, level + 1, maxDepth));
                result.Add(reply);
                Console.WriteLine($"Built reply {reply.CommentId} for parent {parentCommentId} at level {reply.Level}.");
            }

            return result;
        }

        private readonly SemaphoreSlim _commentSaveSemaphore = new SemaphoreSlim(1, 1);

        public async Task SaveCommentAsync(CommentDto comment)
        {
            try
            {
                var entity = new CommentEntity
                {
                    CommentId = comment.CommentId,
                    PostId = comment.PostId,
                    Content = comment.Content,
                    PhotoUrl = comment.PhotoUrl,
                    UserId = comment.UserId,
                    UserName = comment.UserName,
                    UserPhotoUrl = comment.UserPhotoUrl,
                    AddedOn = comment.AddedOn,
                    ParentCommentId = comment.ParentCommentId
                };

                var existingComment = await _database.Table<CommentEntity>().Where(c => c.CommentId == comment.CommentId).FirstOrDefaultAsync();
                if (existingComment == null)
                {
                    await _database.InsertAsync(entity);
                    Console.WriteLine($"Inserted comment {comment.CommentId} into SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }
                else
                {
                    entity.CommentId = existingComment.CommentId;
                    await _database.UpdateAsync(entity);
                    Console.WriteLine($"Updated comment {comment.CommentId} in SQLite at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }

                if (comment.Replies != null)
                {
                    foreach (var reply in comment.Replies)
                    {
                        await SaveCommentAsync(reply);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in SaveCommentAsync for comment {comment.CommentId}: {ex.Message}, StackTrace: {ex.StackTrace} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                throw; // Ném lại để tầng trên xử lý
            }
        }

        public async Task<int> DeleteCommentAsync(CommentDto comment)
        {
            try
            {
                await InitializeAsync();
                // Load all comments for the post to build the reply hierarchy
                var allCommentEntities = await _database.Table<CommentEntity>()
                    .Where(c => c.PostId == comment.PostId)
                    .ToListAsync();

                // Delete all replies recursively
                var replies = BuildReplyHierarchy(allCommentEntities, comment.CommentId, 0);
                foreach (var reply in replies)
                {
                    await DeleteCommentAsync(reply);
                }

                var entity = await _database.Table<CommentEntity>().FirstOrDefaultAsync(c => c.CommentId == comment.CommentId);
                if (entity != null)
                {
                    int result = await _database.DeleteAsync(entity);
                    Console.WriteLine($"Deleted comment {comment.CommentId} from database at 11:44 AM +07, 27/05/2025.");
                    return result;
                }
                Console.WriteLine($"Comment {comment.CommentId} not found in database at 11:44 AM +07, 27/05/2025.");
                return 0;
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite error deleting comment {comment.CommentId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error deleting comment {comment.CommentId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                throw;
            }
        }

        public async Task<int> DeleteCommentByIdAsync(Guid commentId)
        {
            try
            {
                await InitializeAsync();
                var comment = await _database.Table<CommentEntity>().FirstOrDefaultAsync(c => c.CommentId == commentId);
                if (comment != null)
                {
                    var commentDto = ToCommentDto(comment);
                    return await DeleteCommentAsync(commentDto);
                }
                Console.WriteLine($"Comment {commentId} not found for deletion at 11:44 AM +07, 27/05/2025.");
                return 0; // No comment found to delete
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite error deleting comment by ID {commentId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error deleting comment by ID {commentId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                throw;
            }
        }

        // Methods for SyncMetadata
        public async Task<SyncMetadata> GetSyncMetadataAsync()
        {
            await InitializeAsync();
            return await _database.Table<SyncMetadata>().FirstOrDefaultAsync(m => m.Id == 1);
        }

        public async Task SaveSyncMetadataAsync(SyncMetadata syncMetadata)
        {
            try
            {
                var existingMetadata = await _database.Table<SyncMetadata>().FirstOrDefaultAsync(m => m.Id == syncMetadata.Id);
                if (existingMetadata == null)
                {
                    await _database.InsertAsync(syncMetadata);
                }
                else
                {
                    syncMetadata.Id = existingMetadata.Id;
                    await _database.UpdateAsync(syncMetadata);
                }
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite error saving SyncMetadata: {ex.Message} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                throw; // Ném lại để xử lý ở tầng trên
            }
        }
        // Helper methods to convert between CommentDto and CommentEntity
        private CommentEntity ToCommentEntity(CommentDto dto)
        {
            return new CommentEntity
            {
                CommentId = dto.CommentId,
                PostId = dto.PostId,
                Content = dto.Content,
                PhotoUrl = dto.PhotoUrl,
                UserId = dto.UserId,
                UserName = dto.UserName,
                UserPhotoUrl = dto.UserPhotoUrl,
                AddedOn = dto.AddedOn,
                IsOwnComment = dto.IsOwnComment,
                Level = dto.Level,
                ParentCommentId = dto.ParentCommentId
            };
        }

        public async Task<CommentDto> GetCommentAsync(Guid commentId)
        {
            try
            {
                await InitializeAsync();
                var tableInfo = await _database.ExecuteScalarAsync<int>("SELECT count(*) FROM sqlite_master WHERE type='table' AND name='Comments'");
                if (tableInfo == 0)
                {
                    Console.WriteLine($"Comments table does not exist at 11:44 AM +07, 27/05/2025.");
                    return null;
                }

                var entity = await _database.Table<CommentEntity>()
                    .FirstOrDefaultAsync(c => c.CommentId == commentId);

                if (entity == null)
                {
                    Console.WriteLine($"No comment found with ID {commentId} at 11:44 AM +07, 27/05/2025.");
                    return null;
                }

                // Load all comments for the post to build the reply hierarchy
                var allCommentEntities = await _database.Table<CommentEntity>()
                    .Where(c => c.PostId == entity.PostId)
                    .ToListAsync();

                var comment = ToCommentDto(entity);
                comment.Replies = new ObservableCollection<CommentDto>(
                    BuildReplyHierarchy(allCommentEntities, comment.CommentId, 0));
                Console.WriteLine($"Loaded comment {commentId} with {comment.Replies.Count} replies at 11:44 AM +07, 27/05/2025.");
                return comment;
            }
            catch (SQLiteException ex)
            {
                Console.WriteLine($"SQLite error loading comment {commentId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error loading comment {commentId}: {ex.Message} at 11:44 AM +07, 27/05/2025.");
                throw;
            }
        }

        private CommentDto ToCommentDto(CommentEntity entity)
        {
            return new CommentDto
            {
                CommentId = entity.CommentId,
                PostId = entity.PostId,
                Content = entity.Content,
                PhotoUrl = entity.PhotoUrl,
                UserId = entity.UserId,
                UserName = entity.UserName,
                UserPhotoUrl = entity.UserPhotoUrl,
                AddedOn = entity.AddedOn,
                IsOwnComment = entity.IsOwnComment,
                Level = entity.Level,
                ParentCommentId = entity.ParentCommentId,
                Replies = new ObservableCollection<CommentDto>() // Will be populated in GetCommentsAsync or GetCommentAsync
            };
        }
    }
}