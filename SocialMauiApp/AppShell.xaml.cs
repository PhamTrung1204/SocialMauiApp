
using CommunityToolkit.Maui.Core;
using SocialMauiApp.Pages;

namespace SocialMauiApp
{
    public partial class AppShell : Shell
    {
        public AppShell()
        {
            InitializeComponent();
            RegisterRoutes();
        }
        private static void RegisterRoutes()
        {
            Routing.RegisterRoute(nameof(RegisterPage), typeof(RegisterPage));
            Routing.RegisterRoute(nameof(PostDetailsPage), typeof(PostDetailsPage));
            Routing.RegisterRoute(nameof(AddPostPage), typeof(AddPostPage));
            Routing.RegisterRoute(nameof(ProfilePage), typeof(ProfilePage));
            Routing.RegisterRoute(nameof(NotificationPage), typeof(NotificationPage));
        }
    }
}
