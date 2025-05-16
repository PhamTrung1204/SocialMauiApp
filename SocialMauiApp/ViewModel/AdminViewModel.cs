//using CommunityToolkit.Mvvm.ComponentModel;
//using CommunityToolkit.Mvvm.Input;
//using Microsoft.Maui.ApplicationModel;
//using SocialMauiApp.Apis;
//using SocialMauiApp.Services;
//using SocialMediaMaui.Shared.Dtos;
//using System.Threading.Tasks;

//namespace SocialMauiApp.ViewModels
//{
//    public partial class AdminViewModel : ObservableObject
//    {
//        private readonly AuthService _authService;
//        private readonly IAdminApi _adminApi;

//        [ObservableProperty]
//        private int _postCount;

//        [ObservableProperty]
//        private int _userCount;

//        [ObservableProperty]
//        private int _commentCount;

//        [ObservableProperty]
//        private int _likeCount;

//        [ObservableProperty]
//        private bool _isLoading;

//        public AdminViewModel(AuthService authService, IAdminApi adminApi)
//        {
//            _authService = authService;
//            _adminApi = adminApi;
//            LoadDashboardCommand = new AsyncRelayCommand(LoadDashboardAsync);
//        }

//        public IAsyncRelayCommand LoadDashboardCommand { get; }

//        private async Task LoadDashboardAsync()
//        {
//            if (IsLoading) return;
//            IsLoading = true;

//            try
//            {
//                // Kiểm tra quyền admin
//                if (_authService.User == null || _authService.User.Role != "Admin")
//                {
//                    await ShowErrorAlertAsync("You do not have permission to access the admin dashboard.");
//                    await Shell.Current.GoToAsync("..");
//                    return;
//                }

//                // Gọi API để lấy dữ liệu dashboard
//                var dashboardData = await _adminApi.GetDashboardAsync();
//                await MainThread.InvokeOnMainThreadAsync(() =>
//                {
//                    PostCount = dashboardData.PostCount;
//                    UserCount = dashboardData.UserCount;
//                    CommentCount = dashboardData.CommentCount;
//                    LikeCount = dashboardData.LikeCount;
//                });
//            }
//            catch (Exception ex)
//            {
//                await ShowErrorAlertAsync($"Failed to load dashboard: {ex.Message}");
//            }
//            finally
//            {
//                IsLoading = false;
//            }
//        }

//        // Gọi tự động khi ViewModel được khởi tạo
//        public async Task InitializeAsync()
//        {
//            await LoadDashboardCommand.ExecuteAsync(null);
//        }

//        private async Task ShowErrorAlertAsync(string message)
//        {
//            await MainThread.InvokeOnMainThreadAsync(async () =>
//            {
//                await Application.Current.MainPage.DisplayAlert("Error", message, "OK");
//            });
//        }

//        private async Task ToastAsync(string message)
//        {
//            await CommunityToolkit.Maui.Alerts.Toast.Make(message, CommunityToolkit.Maui.Core.ToastDuration.Short).Show();
//        }
//    }
//}