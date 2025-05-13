using System.Globalization;
using System.Text.Json.Serialization;

namespace SocialMediaMaui.Shared.Dtos
{
    public class PostDto
    {
        public Guid PostId { get; set; }
        public Guid UserId { get; set; }
        public string UserName { get; set; }
        public string? UserPhotoUrl { get; set; }
        public string? Content { get; set; }
        public string? PhotoUrl { get; set; }
        public DateTime? PostedOn { get; set; }
        public DateTime ModifiedOn { get; set; }
        [JsonIgnore]
        public string PostedOnDisplay
        {
            get
            {
                var postTime = PostedOn ?? ModifiedOn;
                var now = DateTime.UtcNow;
                var timeSpan = now - postTime;

                if (timeSpan.TotalMinutes < 1)
                    return "Just posted";
                if (timeSpan.TotalMinutes < 60)
                    return $"{(int)timeSpan.TotalMinutes} minutes ago";
                if (timeSpan.TotalHours < 24)
                    return $"{(int)timeSpan.TotalHours} hours ago";
                if (timeSpan.TotalDays < 7)
                    return $"{(int)timeSpan.TotalDays} days ago";

                return postTime.ToString("MMM dd yyyy", new CultureInfo("en-US"));
            }
        }
        public bool IsLiked { get; set; }
        public int LikeCount { get; set; }
        public int CommentCount { get; set; }
        public bool IsBookmarked { get; set; }
        [JsonIgnore]
        public string PostTemplateContentViewName
        {
            get
            {
                if (string.IsNullOrWhiteSpace(PhotoUrl))
                {
                    return "WithNoImage";
                }
                if (string.IsNullOrWhiteSpace(Content))
                {
                    return "ImageOnly";
                }
                return "WithImage";
            }
        }
        [JsonIgnore]
        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";
        [JsonIgnore]
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";
    }
}
