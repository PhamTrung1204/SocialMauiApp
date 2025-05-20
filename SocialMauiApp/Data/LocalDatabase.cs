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

            await _database.CreateTableAsync<PostEntity>();
            await _database.CreateTableAsync<CommentEntity>(); // Sử dụng CommentEntity thay vì CommentDto
            await _database.CreateTableAsync<SyncMetadata>();

            // Ensure indexes for better performance
            await _database.ExecuteAsync("CREATE INDEX IF NOT EXISTS idx_postid ON Comments (PostId, ParentCommentId);");
            await _database.ExecuteAsync("CREATE INDEX IF NOT EXISTS idx_postid ON Posts (PostId);");

            _isInitialized = true;
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
            await InitializeAsync();
            var commentEntities = await _database.Table<CommentEntity>()
                .Where(c => c.PostId == postId && !c.ParentCommentId.HasValue)
                .Skip(startIndex)
                .Take(pageSize)
                .ToListAsync();

            var comments = new List<CommentDto>();
            foreach (var entity in commentEntities)
            {
                var comment = ToCommentDto(entity);
                comment.Replies = new ObservableCollection<CommentDto>(await GetRepliesAsync(comment.CommentId));
                comments.Add(comment);
            }
            return comments;
        }

        public async Task<List<CommentDto>> GetRepliesAsync(Guid parentCommentId)
        {
            await InitializeAsync();
            var replyEntities = await _database.Table<CommentEntity>()
                .Where(c => c.ParentCommentId == parentCommentId)
                .ToListAsync();

            var replies = new List<CommentDto>();
            foreach (var entity in replyEntities)
            {
                var reply = ToCommentDto(entity);
                reply.Replies = new ObservableCollection<CommentDto>(await GetRepliesAsync(reply.CommentId));
                replies.Add(reply);
            }
            return replies;
        }

        public async Task<int> SaveCommentAsync(CommentDto comment)
        {
            await InitializeAsync();
            var entity = ToCommentEntity(comment);
            var existingComment = await _database.Table<CommentEntity>().FirstOrDefaultAsync(c => c.CommentId == comment.CommentId);
            int result;
            if (existingComment != null)
            {
                result = await _database.UpdateAsync(entity);
            }
            else
            {
                result = await _database.InsertAsync(entity);
            }

            if (comment.Replies != null)
            {
                foreach (var reply in comment.Replies)
                {
                    reply.ParentCommentId = comment.CommentId;
                    await SaveCommentAsync(reply);
                }
            }

            return result;
        }

        public async Task<int> DeleteCommentAsync(CommentDto comment)
        {
            await InitializeAsync();
            // Delete all replies recursively
            var replies = await GetRepliesAsync(comment.CommentId);
            foreach (var reply in replies)
            {
                await DeleteCommentAsync(reply);
            }

            var entity = await _database.Table<CommentEntity>().FirstOrDefaultAsync(c => c.CommentId == comment.CommentId);
            if (entity != null)
            {
                return await _database.DeleteAsync(entity);
            }
            return 0;
        }

        public async Task<int> DeleteCommentByIdAsync(Guid commentId)
        {
            await InitializeAsync();
            var comment = await _database.Table<CommentEntity>().FirstOrDefaultAsync(c => c.CommentId == commentId);
            if (comment != null)
            {
                var commentDto = ToCommentDto(comment);
                return await DeleteCommentAsync(commentDto);
            }
            return 0; // No comment found to delete
        }

        // Methods for SyncMetadata
        public async Task<SyncMetadata> GetSyncMetadataAsync()
        {
            await InitializeAsync();
            return await _database.Table<SyncMetadata>().FirstOrDefaultAsync(m => m.Id == 1);
        }

        public async Task<int> SaveSyncMetadataAsync(SyncMetadata metadata)
        {
            await InitializeAsync();
            var existingMetadata = await _database.Table<SyncMetadata>().FirstOrDefaultAsync(m => m.Id == metadata.Id);
            if (existingMetadata != null)
            {
                return await _database.UpdateAsync(metadata);
            }
            return await _database.InsertAsync(metadata);
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
                Replies = new ObservableCollection<CommentDto>() // Will be populated in GetCommentsAsync/GetRepliesAsync
            };
        }
    }
}