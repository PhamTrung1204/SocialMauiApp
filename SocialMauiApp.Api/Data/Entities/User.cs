using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace SocialMauiApp.Api.Data.Entities
{
    public class User
    {
        [Key]
        public Guid Id { get; set; }
        [MaxLength(30)]
        public string Name { get; set; }
        [MaxLength(150)]
        public string Email { get; set; }
        [MaxLength(300)]
        public string PasswordHash { get; set; }
        [Comment("Physical path of the images")]
        public string? PhotoPath { get; set; }
        public string? PhotoUrl { get; set; }
    }
}