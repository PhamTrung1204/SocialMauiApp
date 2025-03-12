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