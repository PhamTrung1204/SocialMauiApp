using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace SocialMauiApp.Api.Data.Entities
{
    public class Post
    {
        [Key]
        public Guid Id { get; set; }
        public Guid UserId { get; set; }
        public virtual User User { get; set; }
        public string? Content { get; set; }
        [Comment("Physical path of the image")]
        public string? PhotoPath { get; set; }
        public string? PhotoUrl { get; set; }
        public DateTime PostedOn { get; set; }
        public DateTime ModifiedOn { get; set; }
        public bool IsDeleted { get; set; }
    }
}