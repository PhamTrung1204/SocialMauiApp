using CommunityToolkit.Maui.Core;
using SocialMauiApp.Pages;
using SocialMauiApp.Services;
using Microsoft.Extensions.DependencyInjection;    // để dùng GetRequiredService
using System.Threading.Tasks;

namespace SocialMauiApp
{
    public partial class AppShell : Shell
    {
        private IPreferencesService _preferencesService;

        public AppShell()
        {
            InitializeComponent();
            RegisterRoutes();

            // Lấy service từ container
            _preferencesService =
               Application.Current
                          .Handler
                          .MauiContext
                          .Services
                          .GetRequiredService<IPreferencesService>();

            // Chạy điều hướng không chặn UI
            _ = InitializeAsync();
        }

        private async Task InitializeAsync()
        {
            bool isRemembered = _preferencesService.GetBool("IsRemembered", false);
            string route = isRemembered
                ? $"//{nameof(LoginWithFingerprintPage)}"
                : $"//{nameof(LoginPage)}";

            await Shell.Current.GoToAsync(route);
        }

        private static void RegisterRoutes()
        {
            Routing.RegisterRoute(nameof(RegisterPage), typeof(RegisterPage));
            Routing.RegisterRoute(nameof(PostDetailsPage), typeof(PostDetailsPage));
            Routing.RegisterRoute(nameof(AddPostPage), typeof(AddPostPage));
            Routing.RegisterRoute(nameof(ProfilePage), typeof(ProfilePage));
            Routing.RegisterRoute(nameof(HomePage), typeof(HomePage));
            Routing.RegisterRoute(nameof(NotificationPage), typeof(NotificationPage));
            Routing.RegisterRoute(nameof(CropPhotoPage), typeof(CropPhotoPage));
            Routing.RegisterRoute(nameof(LoginWithFingerprintPage), typeof(LoginWithFingerprintPage));
            Routing.RegisterRoute(nameof(LoginPage), typeof(LoginPage));
        }
    }
}
