using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMediaMaui.Shared.Dtos
{
    public class UserDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Role { get; set; } // "Admin" hoặc "Client"
        public bool IsLocked { get; set; }
        public string? PhotoUrl { get; set; }
        public bool IsAdmin { get; set; }
    }
}
