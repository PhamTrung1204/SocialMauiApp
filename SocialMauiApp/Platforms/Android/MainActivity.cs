using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.OS;

namespace com.companyname.socialmauiapp;

[Activity(Theme = "@style/Maui.SplashTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation | ConfigChanges.UiMode | ConfigChanges.ScreenLayout | ConfigChanges.SmallestScreenSize | ConfigChanges.Density)]
public class MainActivity : MauiAppCompatActivity
{
    private static Uri? _pendingDeepLink;

    public static Uri? PendingDeepLink
    {
        get => _pendingDeepLink;
        set => _pendingDeepLink = value;
    }

    protected override void OnCreate(Bundle savedInstanceState)
    {
        base.OnCreate(savedInstanceState);
        Console.WriteLine("MainActivity OnCreate called.");
        HandleIntent(Intent);
    }

    protected override void OnNewIntent(Intent intent)
    {
        base.OnNewIntent(intent);
        Console.WriteLine("MainActivity OnNewIntent called.");
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
                _pendingDeepLink = new Uri(uri);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error storing deep link: {ex.Message}");
            }
        }
        else
        {
            Console.WriteLine("No deep link data received.");
        }
    }

    protected override void OnResume()
    {
        base.OnResume();
        Console.WriteLine("MainActivity OnResume called.");
    }

    protected override void OnPause()
    {
        base.OnPause();
        Console.WriteLine("MainActivity OnPause called.");
    }

    protected override void OnDestroy()
    {
        base.OnDestroy();
        Console.WriteLine("MainActivity OnDestroy called.");
    }
}