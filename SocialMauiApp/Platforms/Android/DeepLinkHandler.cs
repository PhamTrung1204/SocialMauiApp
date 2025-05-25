using Android.Content;
using Microsoft.Maui.Controls;
using SocialMauiApp.Services;

namespace SocialMauiApp.Platforms.Android
{
    public static class DeepLinkHandler
    {
        public static async Task HandleDeepLink(Intent intent, IServiceProvider serviceProvider)
        {
            if (intent?.Data != null)
            {
                var uri = intent.Data.ToString();
                Console.WriteLine($"Deep link received: {uri}");

                // Use IDeepLinkService to store the deep link for App.cs to process
                var deepLinkService = serviceProvider.GetService<IDeepLinkService>();
                if (deepLinkService != null)
                {
                    try
                    {
                        // Store the deep link in MainActivity.PendingDeepLink via the service
                        com.companyname.socialmauiapp.MainActivity.PendingDeepLink = new Uri(uri);

                        // Optionally, trigger navigation manually if needed (not recommended)
                        if (Shell.Current != null)
                        {
                            if (uri.Contains("socialmauiapp://ResetPasswordPage"))
                            {
                                var query = System.Web.HttpUtility.ParseQueryString(new Uri(uri).Query);
                                var resetToken = query["resetToken"];
                                var parameters = new Dictionary<string, object>
                                {
                                    { "resetToken", resetToken ?? string.Empty }
                                };
                                await Shell.Current.GoToAsync("//ResetPasswordPage", parameters);
                                Console.WriteLine("Navigation to ResetPasswordPage completed via DeepLinkHandler.");
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
                                Console.WriteLine("Navigation to RegisterPage completed via DeepLinkHandler.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Shell.Current is null. Deep link will be processed by App.cs.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error handling deep link: {ex.Message}\nStack Trace: {ex.StackTrace}");
                    }
                }
                else
                {
                    Console.WriteLine("IDeepLinkService not available. Deep link cannot be processed.");
                }
            }
            else
            {
                Console.WriteLine("No deep link data received.");
            }
        }
    }
}