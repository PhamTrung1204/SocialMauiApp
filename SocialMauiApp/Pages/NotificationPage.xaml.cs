using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages
{
    public partial class NotificationPage : ContentPage
    {
        private readonly NotificationViewModel _notificationViewModel;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        public NotificationPage(NotificationViewModel notificationViewModel, RealtimeUpdatesService realtimeUpdatesService)
        {
            InitializeComponent();
            _notificationViewModel = notificationViewModel;
            _realtimeUpdatesService = realtimeUpdatesService;
            BindingContext = _notificationViewModel;
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
            // Cấu hình realtime updates và fetch notification khi trang xuất hiện
            _notificationViewModel.ConfigureRealtimeUpdates();

            // Nếu danh sách thông báo rỗng, gọi lệnh fetch
            if (_notificationViewModel.Notifications.Count == 0)
            {
                _notificationViewModel.FetchNotificationCommand.Execute(null);
            }
        }

        protected override void OnDisappearing()
        {
            // Loại bỏ handler để tránh rò rỉ bộ nhớ khi trang không còn hiển thị
            _realtimeUpdatesService.RemoveHandlers(nameof(NotificationViewModel));
            base.OnDisappearing();
        }
    }
}
