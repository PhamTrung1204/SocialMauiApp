using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SQLite;
using System;

namespace SocialMauiApp.Data
{
    [Table("Posts")]
    public class PostEntity
    {
        [PrimaryKey]
        public Guid PostId { get; set; }

        public Guid UserId { get; set; }

        public string UserName { get; set; } = string.Empty;

        public string? UserPhotoUrl { get; set; }

        public string? Content { get; set; }

        public string? PhotoUrl { get; set; }

        public string PostedOnDisplay { get; set; } = string.Empty;

        public bool IsLiked { get; set; }

        public bool IsBookmarked { get; set; }

        public int LikeCount { get; set; }

        public int CommentCount { get; set; }

        public int IsSync { get; set; }

        // Parameterless constructor for SQLite
        public PostEntity() { }

        // Optional: Method to convert to PostModel
        public PostModel ToPostModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService)
        {
            return new PostModel(postApi, realtimeUpdatesService, authService)
            {
                PostId = this.PostId,
                UserId = this.UserId,
                UserName = this.UserName,
                UserPhotoUrl = this.UserPhotoUrl,
                Content = this.Content,
                PhotoUrl = this.PhotoUrl,
                PostedOnDisplay = this.PostedOnDisplay,
                IsLiked = this.IsLiked,
                IsBookmarked = this.IsBookmarked,
                LikeCount = this.LikeCount,
                CommentCount = this.CommentCount,
                IsSync = this.IsSync
            };
        }
    }
}