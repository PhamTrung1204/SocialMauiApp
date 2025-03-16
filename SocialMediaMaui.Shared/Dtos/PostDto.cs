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

        public DateTime PostedOn { get; set; }
        public DateTime? ModifiedOn { get; set; }
        [JsonIgnore]
        public DateTime PostedOnDisplay => ModifiedOn ?? PostedOn;
        public bool IsLiked { get; set; }
        
  
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
