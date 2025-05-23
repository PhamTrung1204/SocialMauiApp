using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.OS;

namespace com.companyname.socialmauiapp;

[Activity(Theme = "@style/Maui.SplashTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation | ConfigChanges.UiMode | ConfigChanges.ScreenLayout | ConfigChanges.SmallestScreenSize | ConfigChanges.Density)]
public class MainActivity : MauiAppCompatActivity
{
    protected override void OnCreate(Bundle savedInstanceState)
    {
        base.OnCreate(savedInstanceState);
        HandleIntent(Intent);
    }

    protected override void OnNewIntent(Intent intent)
    {
        base.OnNewIntent(intent);
        HandleIntent(intent);
    }

    private void HandleIntent(Intent intent)
    {
        if (intent?.Data != null)
        {
            var uri = intent.Data.ToString();
            Console.WriteLine($"Received deep link: {uri}");
            try
            {
                // Gửi URI đến MAUI để xử lý
                Microsoft.Maui.Controls.Application.Current?.SendOnAppLinkRequestReceived(new Uri(uri));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error processing deep link: {ex.Message}");
            }
        }
        else
        {
            Console.WriteLine("No deep link data received.");
        }
    }
}