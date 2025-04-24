using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMediaMaui.Shared.Dtos
{
    public class GetRepliesDto
    {
        public Guid PostId { get; set; }
        public Guid ParentCommentId { get; set; }
        public int StartIndex { get; set; }
        public int PageSize { get; set; }
    }
}
