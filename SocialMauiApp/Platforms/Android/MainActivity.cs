using Android.App;
using Android.Content.PM;
using Android.OS;
using AndroidX.AppCompat.App;
using Plugin.Fingerprint;

namespace SocialMauiApp
{
    // ghi rõ Activity attribute như bình thường
    [Activity(Theme = "@style/Maui.SplashTheme",
              MainLauncher = true,
              ConfigurationChanges = ConfigChanges.ScreenSize
                                   | ConfigChanges.Orientation
                                   | ConfigChanges.UiMode
                                   | ConfigChanges.ScreenLayout
                                   | ConfigChanges.SmallestScreenSize)]
    public class MainActivity : MauiAppCompatActivity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            // Nếu muốn buộc Light Mode, thêm cấu hình sau (nếu cần)
            AppCompatDelegate.DefaultNightMode = AppCompatDelegate.ModeNightNo;
            CrossFingerprint.SetCurrentActivityResolver(() => this);
        }
    }
}
