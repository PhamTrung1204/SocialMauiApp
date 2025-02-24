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
        [JsonIgnore]
        public DateTime PostedOn { get; set; }
        [JsonIgnore]
        public DateTime? ModifiedOn { get; set; }
        public DateTime PostedOnDisplay => ModifiedOn ?? PostedOn;
        public bool IsLiked { get; set; }
        public bool IsBookmarked { get; set; }
    }
}
