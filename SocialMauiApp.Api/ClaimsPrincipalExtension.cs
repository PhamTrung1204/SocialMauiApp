using SocialMediaMaui.Shared.Dtos;
using System.Security.Claims;

namespace SocialMauiApp.Api
{
    public static class ClaimsPrincipalExtension
    {
        public static Guid GetUserId(this ClaimsPrincipal principal)=>        
            Guid.Parse(principal.FindFirstValue(ClaimTypes.NameIdentifier));
        
        public static LoggedInUser GetUser(this ClaimsPrincipal principal)
        {
            var userId = principal.GetUserId();
            var name = principal.FindFirstValue(ClaimTypes.Name);
            var email = principal.FindFirstValue(ClaimTypes.Email);
            var photoUrl = principal.FindFirstValue("UserPhotoUrl");
            return new LoggedInUser(userId, name, email, photoUrl);
        }
    }
}
