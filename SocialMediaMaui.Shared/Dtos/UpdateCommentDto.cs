using Microsoft.AspNetCore.Http;
using System;

namespace SocialMediaMaui.Shared.Dtos
{
    public class UpdateCommentDto
    {
        public Guid CommentId { get; set; }
        public string Content { get; set; } = string.Empty;
        public IFormFile? Photo { get; set; }
        public bool IsExistingPhotoRemoved { get; set; }
    }
}