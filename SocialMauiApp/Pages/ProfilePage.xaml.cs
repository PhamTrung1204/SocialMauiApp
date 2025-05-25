using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class ProfilePage : ContentPage
{
    private readonly ProfileViewModel _profileViewModel;
    private readonly RealtimeUpdatesService _realtimeUpdatesService;

    public ProfilePage(ProfileViewModel profileViewModel, RealtimeUpdatesService realtimeUpdatesService)
    {
        InitializeComponent();
        BindingContext = profileViewModel;
        _profileViewModel = profileViewModel;
        _realtimeUpdatesService = realtimeUpdatesService;

        // Đăng ký sự kiện để chạy animation khi IsProfileMenuOpen thay đổi
        _profileViewModel.PropertyChanged += async (sender, args) =>
        {
            if (args.PropertyName == nameof(ProfileViewModel.IsProfileMenuOpen))
            {
                if (_profileViewModel.IsProfileMenuOpen)
                {
                    ProfileMenu.IsVisible = true;
                    ProfileMenu.Scale = 0;
                    await ProfileMenu.ScaleTo(1, 200, Easing.CubicInOut);
                }
                else
                {
                    await ProfileMenu.ScaleTo(0, 200, Easing.CubicInOut);
                    ProfileMenu.IsVisible = false;
                }
            }
        };
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        _profileViewModel.ConfigureRealtimeUpdates();
    }

    protected override void OnDisappearing()
    {
        base.OnDisappearing();
        _realtimeUpdatesService.RemoveHandlers(nameof(ProfileViewModel));
    }
}