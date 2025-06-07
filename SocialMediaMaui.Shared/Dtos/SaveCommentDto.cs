using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace SocialMediaMaui.Shared.Dtos
{
    public class SaveCommentDto
    {
        public Guid PostId { get; set; }
        public Guid CommentId { get; set; }
        public Guid? ParentCommentId { get; set; }
        public string UserName { get; set; }
        public IFormFile Photo { get; set; }
        [Required]
        public string Content { get; set; }
        public bool IsExistingPhotoRemoved { get; set; }

        public bool Validate()
        {
            if (string.IsNullOrWhiteSpace(Content))
                return false;
            return true;
        }
    }
}
