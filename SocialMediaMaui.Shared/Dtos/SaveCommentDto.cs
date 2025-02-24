using System.ComponentModel.DataAnnotations;

namespace SocialMediaMaui.Shared.Dtos
{
    public class SaveCommentDto
    {
        public Guid PostId { get; set; }
        public Guid CommentId { get; set; }
        [Required]
        public string Content { get; set; }
        public bool Validate()
        {
            if (string.IsNullOrWhiteSpace(Content))
                return false;
            return true;
        }
    }
}
