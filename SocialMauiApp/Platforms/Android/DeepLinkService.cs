// File: Platforms/Android/DeepLinkService.cs
using Android.Content;
using SocialMauiApp.Services;

namespace SocialMauiApp.Platforms.Android
{
    public class DeepLinkService : IDeepLinkService
    {
        public Uri? GetPendingDeepLink()
        {
            return com.companyname.socialmauiapp.MainActivity.PendingDeepLink;
        }

        public void ClearPendingDeepLink()
        {
            com.companyname.socialmauiapp.MainActivity.PendingDeepLink = null;
        }
    }
}