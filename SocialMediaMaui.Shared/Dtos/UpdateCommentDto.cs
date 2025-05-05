using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMediaMaui.Shared.Dtos
{
    public class UpdateCommentDto
    {
        public Guid CommentId { get; set; }
        public string Content { get; set; }
        public string ImageUrl { get; set; }
        public DateTime UpdateTime { get; set; }
    }
}
