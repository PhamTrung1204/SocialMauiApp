using Microsoft.AspNetCore.Http;

namespace SocialMediaMaui.Shared.Dtos
{
    public class SavePostDto
    {
        public Guid PostId { get; set; }
        public string? Content { get; set; }
        public IFormFile? Photo { get; set; }
        public bool IsExistingPhotoRemoved { get; set; }
        public bool Validate()
        {
            if (string.IsNullOrWhiteSpace(Content) && Photo is null)
                return false;
            return true;
        }
    }
}
