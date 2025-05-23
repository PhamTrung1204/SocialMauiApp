using Microsoft.Maui.Controls;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            return new Window(new AppShell());
        }

        protected override void OnAppLinkRequestReceived(Uri uri)
        {
            base.OnAppLinkRequestReceived(uri);

            if ((uri.Scheme == "socialmauiapp" && uri.Host == "auth" && uri.AbsolutePath.StartsWith("/verify-email")) ||
                (uri.Scheme == "https" && uri.Host == "r2dpzmzp-7022.asse.devtunnels.ms" && uri.AbsolutePath.StartsWith("/api/auth/verify-email")))
            {
                var token = uri.Query.TrimStart('?').Split('&')
                    .FirstOrDefault(p => p.StartsWith("token="))?.Split('=')[1];

                if (!string.IsNullOrEmpty(token))
                {
                    MainThread.BeginInvokeOnMainThread(async () =>
                    {
                        var parameters = new Dictionary<string, object>
                        {
                            { "token", token }
                        };
                        try
                        {
                            await Shell.Current.GoToAsync($"//{nameof(RegisterPage)}", parameters);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Navigation error: {ex.Message}");
                            await Shell.Current.DisplayAlert("Error", "Failed to process verification link. Please try again.", "OK");
                        }
                    });
                }
                else
                {
                    Console.WriteLine("No token found in URI: {uri}", uri);
                    MainThread.BeginInvokeOnMainThread(async () =>
                    {
                        await Shell.Current.DisplayAlert("Error", "Invalid verification link.", "OK");
                    });
                }
            }
        }
    }
}