using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages
{
    public partial class HomePage : ContentPage
    {
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly HomeViewModel _homeViewModel;

        public HomePage(HomeViewModel homeViewModel, RealtimeUpdatesService realtimeUpdatesService)
        {
            InitializeComponent();
            BindingContext = homeViewModel;
            _homeViewModel = homeViewModel;
            _realtimeUpdatesService = realtimeUpdatesService;
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
            // Cấu hình SignalR và cập nhật UI trên main thread
            Shell.Current.Dispatcher.DispatchAsync(() =>
            {
                _homeViewModel.ConfigureRealtimeUpdates();
            });
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();
            // Hủy đăng ký các handler khi trang không còn hiển thị
            _realtimeUpdatesService.RemoveHandlers(nameof(HomeViewModel));
        }

        private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(PostDetailsPage), animate: true);
        }

        private async void GoToProfile(object sender, TappedEventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(ProfilePage), animate: true);
        }

        private async void GoToNotification(object sender, TappedEventArgs e)
        {
            _homeViewModel.IsThereNewNotification = false;
            await Shell.Current.GoToAsync(nameof(NotificationPage), animate: true);
        }
    }
}
