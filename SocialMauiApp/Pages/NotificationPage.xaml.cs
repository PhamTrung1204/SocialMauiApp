using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class NotificationPage : ContentPage
{
    private readonly NotificationViewModel _notificationViewModel;
    private readonly RealtimeUpdatesService _realtimeUpdatesService;
    public NotificationPage(NotificationViewModel notificationViewModel, RealtimeUpdatesService realtimeUpdatesService)
    {
        InitializeComponent();
       BindingContext = _notificationViewModel;
        _notificationViewModel = notificationViewModel;
        _realtimeUpdatesService = realtimeUpdatesService;
    }
    protected override void OnAppearing()
    {
        base.OnAppearing();
        _notificationViewModel.ConfigureRealtimeUpdates();
    }
    protected override void OnDisappearing()
    {
        base.OnDisappearing();
        _realtimeUpdatesService.RemoveHandlers(nameof(NotificationViewModel));
    }
  
}