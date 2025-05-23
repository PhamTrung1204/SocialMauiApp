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
            _preferencesService = Application.Current.Handler.MauiContext.Services.GetRequiredService<IPreferencesService>();
        }

        private static void RegisterRoutes()
        {
            Routing.RegisterRoute("RegisterPage", typeof(RegisterPage));
            Routing.RegisterRoute(nameof(PostDetailsPage), typeof(PostDetailsPage));
            Routing.RegisterRoute(nameof(AddPostPage), typeof(AddPostPage));
            Routing.RegisterRoute(nameof(ProfilePage), typeof(ProfilePage));
            Routing.RegisterRoute(nameof(HomePage), typeof(HomePage));
            Routing.RegisterRoute(nameof(NotificationPage), typeof(NotificationPage));
            Routing.RegisterRoute(nameof(CropPhotoPage), typeof(CropPhotoPage));
            Routing.RegisterRoute(nameof(LoginPage), typeof(LoginPage));
            Routing.RegisterRoute(nameof(AdminDashboardPage), typeof(AdminDashboardPage));
            Routing.RegisterRoute(nameof(PostManagementPage), typeof(PostManagementPage));
        }
    }
}
