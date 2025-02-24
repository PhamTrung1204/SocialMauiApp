using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SocialMauiApp.Api.Data.Entities
{
    public class Notification
    {
        [Key]
        public Guid Id { get; set; }
        public Guid ForUserId { get; set; }
        [ForeignKey(nameof(ForUserId))]
        public virtual User User { get; set; }
        [Required]
        public DateTime When { get; set; }
        public Guid? PostId { get; set; }
        public virtual Post? Post { get; set; }
        [MaxLength(200)]
        public string? Text { get; set; }
       
    }
}