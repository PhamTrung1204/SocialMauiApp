using SQLite;
using System;

namespace SocialMauiApp.Data
{
    [Table("Comments")]
    public class CommentEntity
    {
        [PrimaryKey]
        public Guid CommentId { get; set; }

        public Guid PostId { get; set; }

        public string Content { get; set; }

        public string PhotoUrl { get; set; }

        public Guid UserId { get; set; }

        public string UserName { get; set; }

        public string UserPhotoUrl { get; set; }

        public DateTime AddedOn { get; set; }

        public bool IsOwnComment { get; set; }

        public int Level { get; set; }

        public Guid? ParentCommentId { get; set; }

    }
}