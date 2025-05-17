using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Text.Json;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class AdminViewModel : BaseViewModel
    {
        private readonly AuthService _authService;
        private readonly IAdminApi _adminApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        [ObservableProperty]
        private int _postCount;

        [ObservableProperty]
        private int _userCount;

        [ObservableProperty]
        private int _commentCount;

        [ObservableProperty]
        private int _likeCount;

        [ObservableProperty]
        private bool _isLoading;

        [ObservableProperty]
        private ObservableCollection<UserDto> _users;

        [ObservableProperty]
        private UserDto? _selectedUser;

        public AdminViewModel(AuthService authService, IAdminApi adminApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            _authService = authService;
            _adminApi = adminApi;
            _realtimeUpdatesService = realtimeUpdatesService;
            Users = new ObservableCollection<UserDto>();

            // Initialize commands
            LoadDashboardCommand = new AsyncRelayCommand(LoadDashboardAsync);
            NavigateToPostManagementCommand = new AsyncRelayCommand(NavigateToPostManagementAsync);
            ToggleUserLockCommand = new AsyncRelayCommand(ToggleUserLockAsync);
            DeleteUserCommand = new AsyncRelayCommand(DeleteUserAsync);
            LogoutCommand = new AsyncRelayCommand(LogoutAsync);
        }

        public IAsyncRelayCommand LoadDashboardCommand { get; }
        public IAsyncRelayCommand NavigateToPostManagementCommand { get; }
        public IAsyncRelayCommand ToggleUserLockCommand { get; }
        public IAsyncRelayCommand DeleteUserCommand { get; }
        public IAsyncRelayCommand LogoutCommand { get; }

        public async Task InitializeAsync()
        {
            await LoadDashboardCommand.ExecuteAsync(null);
        }

        public void Cleanup()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(AdminViewModel));
        }

        private async Task LoadDashboardAsync()
        {
            if (IsLoading) return;
            IsLoading = true;

            try
            {
                // Verify admin access
                if (_authService.User == null || _authService.User.Role != "Admin")
                {
                    await ShowErrorAlertAsync("You do not have permission to access the admin dashboard.");
                    await Shell.Current.GoToAsync("..");
                    return;
                }

                // Fetch dashboard data
                var dashboardData = await _adminApi.GetDashboardAsync();
                Debug.WriteLine($"Dashboard data received: {JsonSerializer.Serialize(dashboardData)}");

                if (dashboardData == null)
                {
                    await ShowErrorAlertAsync("Received null dashboard data from server.");
                    return;
                }

                // Update UI properties on main thread
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    PostCount = dashboardData.PostCount;
                    UserCount = dashboardData.UserCount;
                    CommentCount = dashboardData.CommentCount;
                    LikeCount = dashboardData.LikeCount;
                    Debug.WriteLine($"UI updated - PostCount: {PostCount}, UserCount: {UserCount}, CommentCount: {CommentCount}, LikeCount: {LikeCount}");
                });

                // Load users and configure real-time updates
                await LoadUsersAsync();
                ConfigureRealtimeUpdates();
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadDashboardAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load dashboard: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private async Task LoadUsersAsync()
        {
            try
            {
                var users = await _adminApi.GetUsersAsync(null, null, 1, 10);
                Debug.WriteLine($"Users fetched: {JsonSerializer.Serialize(users)}");

                if (users == null)
                {
                    await ShowErrorAlertAsync("Received null user data from server.");
                    return;
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    Users.Clear();
                    foreach (var user in users)
                    {
                        Users.Add(user);
                    }
                    Debug.WriteLine($"Users collection updated: {Users.Count} items");
                });
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadUsersAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load users: {ex.Message}");
            }
        }

        private async Task NavigateToPostManagementAsync()
        {
            try
            {
                await NavigateAsync($"{nameof(PostManagementPage)}");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"NavigateToPostManagementAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to navigate: {ex.Message}");
            }
        }

        private async Task ToggleUserLockAsync()
        {
            if (IsLoading || SelectedUser == null) return;
            IsLoading = true;

            try
            {
                var result = SelectedUser.IsLocked
                    ? await _adminApi.UnlockUserAsync(SelectedUser.Id)
                    : await _adminApi.LockUserAsync(SelectedUser.Id);

                Debug.WriteLine($"ToggleUserLock result: {JsonSerializer.Serialize(result)}");

                if (result.IsSuccess)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        SelectedUser.IsLocked = !SelectedUser.IsLocked;
                        var index = Users.IndexOf(Users.First(u => u.Id == SelectedUser.Id));
                        Users[index] = SelectedUser; // Update collection
                        Debug.WriteLine($"User {SelectedUser.Name} {(SelectedUser.IsLocked ? "locked" : "unlocked")}");
                    });
                    await ToastAsync($"User {(SelectedUser.IsLocked ? "locked" : "unlocked")} successfully.");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"ToggleUserLockAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to toggle user lock: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private async Task DeleteUserAsync()
        {
            if (IsLoading || SelectedUser == null) return;
            IsLoading = true;

            try
            {
                var confirm = await Application.Current.MainPage.DisplayAlert(
                    "Confirm Delete",
                    $"Are you sure you want to delete user {SelectedUser.Name}?",
                    "Yes", "No");

                if (!confirm) return;

                var result = await _adminApi.DeleteUserAsync(SelectedUser.Id);
                Debug.WriteLine($"DeleteUser result: {JsonSerializer.Serialize(result)}");

                if (result.IsSuccess)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        Users.Remove(SelectedUser);
                        SelectedUser = null;
                        UserCount = Users.Count; // Update user count
                        Debug.WriteLine($"User deleted, new UserCount: {UserCount}");
                    });
                    await ToastAsync("User deleted successfully.");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"DeleteUserAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to delete user: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private async Task LogoutAsync()
        {
            if (IsLoading) return;
            IsLoading = true;

            try
            {
                // Clear auth token and user data
                _authService.Logout();
                Debug.WriteLine("User logged out successfully.");

                // Navigate to login page
                await MainThread.InvokeOnMainThreadAsync(async () =>
                {
                    await Shell.Current.GoToAsync("//LoginPage");
                });
                await ToastAsync("Logged out successfully.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LogoutAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to logout: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private void OnPostAdded(PostDto post)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                PostCount++;
                OnPropertyChanged(nameof(PostCount));
                Debug.WriteLine($"Post added, new PostCount: {PostCount}");
            });
        }

        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (PostCount > 0)
                {
                    PostCount--;
                    OnPropertyChanged(nameof(PostCount));
                    Debug.WriteLine($"Post deleted, new PostCount: {PostCount}");
                }
            });
        }

        private void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(AdminViewModel));
            //_realtimeUpdatesService.AddPostAddedHandler(nameof(AdminViewModel), OnPostAdded);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(AdminViewModel), OnPostDeleted);
            Debug.WriteLine("Realtime updates configured for AdminViewModel.");
        }

        private async Task ShowErrorAlertAsync(string message)
        {
            await MainThread.InvokeOnMainThreadAsync(async () =>
            {
                await Application.Current.MainPage.DisplayAlert("Error", message, "OK");
            });
        }

        private async Task ToastAsync(string message)
        {
            await CommunityToolkit.Maui.Alerts.Toast.Make(message, CommunityToolkit.Maui.Core.ToastDuration.Short).Show();
        }
    }
}