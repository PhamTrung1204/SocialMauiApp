// Platforms/Android/DeepLinkHandler.cs
using Android.Content;
using Microsoft.Maui.Controls;

namespace SocialMauiApp.Platforms.Android
{
    public static class DeepLinkHandler
    {
        public static async void HandleDeepLink(Intent intent)
        {
            if (intent?.Data != null)
            {
                var uri = intent.Data.ToString();
                Console.WriteLine($"Deep link received: {uri}");

                if (uri.Contains("socialmauiapp://ResetPasswordPage"))
                {
                    var query = System.Web.HttpUtility.ParseQueryString(new Uri(uri).Query);
                    var resetToken = query["resetToken"];
                    var parameters = new Dictionary<string, object>
                    {
                        { "resetToken", resetToken ?? string.Empty }
                    };
                    await Shell.Current.GoToAsync("//ResetPasswordPage", parameters);
                }
                else if (uri.Contains("socialmauiapp://RegisterPage"))
                {
                    var query = System.Web.HttpUtility.ParseQueryString(new Uri(uri).Query);
                    var verified = query["verified"] == "true";
                    var parameters = new Dictionary<string, object>
                    {
                        { "ShowSuccessMessage", verified }
                    };
                    await Shell.Current.GoToAsync("//RegisterPage", parameters);
                }
            }
        }
    }
}