using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Collections.ObjectModel;
using System.Diagnostics;

namespace SocialMauiApp.ViewModel
{
    public partial class AdminViewModel : BaseViewModel
    {
        private const int PageSize = 20;

        private readonly AuthService _authService;
        private readonly IAdminApi _adminApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        [ObservableProperty] private int _postCount;
        [ObservableProperty] private int _userCount;
        [ObservableProperty] private int _commentCount;
        [ObservableProperty] private int _likeCount;
        [ObservableProperty] private bool _isLoading;
        [ObservableProperty] private UserDto? _selectedUser;
        [ObservableProperty] private string? _searchText;
        [ObservableProperty] private int _page = 1;

        [ObservableProperty]
        [NotifyPropertyChangedFor(nameof(IsUsersTab))]
        [NotifyPropertyChangedFor(nameof(IsCommentsTab))]
        private int _selectedTab;

        [ObservableProperty]
        [NotifyPropertyChangedFor(nameof(IsAllRoles))]
        [NotifyPropertyChangedFor(nameof(IsAdminRole))]
        [NotifyPropertyChangedFor(nameof(IsClientRole))]
        private string? _roleFilter;

        public bool IsUsersTab => SelectedTab == 0;
        public bool IsCommentsTab => SelectedTab == 1;

        public bool IsAllRoles => string.IsNullOrEmpty(RoleFilter);
        public bool IsAdminRole => RoleFilter == "Admin";
        public bool IsClientRole => RoleFilter == "Client";

        public bool CanGoPrevious => Page > 1;

        public ObservableCollection<UserDto> Users { get; } = new();
        public ObservableCollection<CommentDto> Comments { get; } = new();

        public AdminViewModel(AuthService authService, IAdminApi adminApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            _authService = authService;
            _adminApi = adminApi;
            _realtimeUpdatesService = realtimeUpdatesService;
        }

        public async Task InitializeAsync() => await LoadDashboardCommand.ExecuteAsync(null);

        public void Cleanup() => _realtimeUpdatesService.RemoveHandlers(nameof(AdminViewModel));

        [RelayCommand]
        private async Task LoadDashboardAsync()
        {
            if (IsLoading) return;
            IsLoading = true;
            try
            {
                if (_authService.User is null || _authService.User.Role != "Admin")
                {
                    await ShowErrorAlertAsync("You do not have permission to access the admin dashboard.");
                    await NavigateBackAsync();
                    return;
                }

                var dashboard = await _adminApi.GetDashboardAsync();
                if (dashboard is not null)
                {
                    PostCount = dashboard.PostCount;
                    UserCount = dashboard.UserCount;
                    CommentCount = dashboard.CommentCount;
                    LikeCount = dashboard.LikeCount;
                }

                await LoadCurrentTabAsync();
                ConfigureRealtimeUpdates();
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadDashboardAsync error: {ex}");
                await ShowErrorAlertAsync($"Failed to load dashboard: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private async Task LoadCurrentTabAsync()
        {
            if (IsCommentsTab)
            {
                await LoadCommentsAsync();
            }
            else
            {
                await LoadUsersAsync();
            }
        }

        private async Task LoadUsersAsync()
        {
            try
            {
                var users = await _adminApi.GetUsersAsync(SearchText, RoleFilter, Page, PageSize);
                Users.Clear();
                foreach (var user in users ?? [])
                {
                    Users.Add(user);
                }
                OnPropertyChanged(nameof(CanGoPrevious));
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadUsersAsync error: {ex}");
                await ShowErrorAlertAsync($"Failed to load users: {ex.Message}");
            }
        }

        private async Task LoadCommentsAsync()
        {
            try
            {
                var comments = await _adminApi.GetCommentsAsync((Page - 1) * PageSize, PageSize);
                Comments.Clear();
                foreach (var comment in comments ?? [])
                {
                    Comments.Add(comment);
                }
                OnPropertyChanged(nameof(CanGoPrevious));
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadCommentsAsync error: {ex}");
                await ShowErrorAlertAsync($"Failed to load comments: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task SelectTabAsync(string tabIndex)
        {
            if (!int.TryParse(tabIndex, out var index) || index == SelectedTab) return;
            SelectedTab = index;
            Page = 1;
            await LoadCurrentTabAsync();
        }

        [RelayCommand]
        private async Task SearchAsync()
        {
            Page = 1;
            await LoadUsersAsync();
        }

        [RelayCommand]
        private async Task FilterRoleAsync(string? role)
        {
            RoleFilter = string.IsNullOrEmpty(role) ? null : role;
            Page = 1;
            await LoadUsersAsync();
        }

        [RelayCommand]
        private async Task NextPageAsync()
        {
            Page++;
            await LoadCurrentTabAsync();
        }

        [RelayCommand]
        private async Task PreviousPageAsync()
        {
            if (Page <= 1) return;
            Page--;
            await LoadCurrentTabAsync();
        }

        [RelayCommand]
        private async Task NavigateToPostManagementAsync() => await NavigateAsync(nameof(Pages.PostManagementPage));

        [RelayCommand]
        private async Task ToggleUserLockAsync()
        {
            if (IsLoading || SelectedUser is null) return;
            IsLoading = true;
            try
            {
                var target = SelectedUser;
                var result = target.IsLocked
                    ? await _adminApi.UnlockUserAsync(target.Id)
                    : await _adminApi.LockUserAsync(target.Id);

                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error ?? "Could not change the lock state.");
                    return;
                }

                target.IsLocked = !target.IsLocked;
                var index = Users.IndexOf(target);
                if (index >= 0)
                {
                    Users[index] = target;
                }
                await ToastAsync(target.IsLocked ? "User locked." : "User unlocked.");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Failed to toggle user lock: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        [RelayCommand]
        private async Task DeleteUserAsync()
        {
            if (IsLoading || SelectedUser is null) return;

            var target = SelectedUser;
            if (!await Shell.Current.DisplayAlert("Confirm delete", $"Delete user {target.Name}?", "Yes", "No"))
            {
                return;
            }

            IsLoading = true;
            try
            {
                var result = await _adminApi.DeleteUserAsync(target.Id);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error ?? "Could not delete the user.");
                    return;
                }

                Users.Remove(target);
                SelectedUser = null;
                // UserCount là tổng toàn hệ thống, không phải số dòng của trang hiện tại.
                if (UserCount > 0) UserCount--;
                await ToastAsync("User deleted.");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Failed to delete user: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        [RelayCommand]
        private async Task DeleteCommentAsync(CommentDto comment)
        {
            if (comment is null) return;
            if (!await Shell.Current.DisplayAlert("Confirm delete", "Delete this comment?", "Yes", "No"))
            {
                return;
            }

            try
            {
                var result = await _adminApi.DeleteCommentAsync(comment.CommentId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error ?? "Could not delete the comment.");
                    return;
                }

                Comments.Remove(comment);
                if (CommentCount > 0) CommentCount--;
                await ToastAsync("Comment deleted.");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Failed to delete comment: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task LogoutAsync()
        {
            _authService.Logout();
            await NavigateAsync("//LoginPage");
        }

        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (PostCount > 0) PostCount--;
            });
        }

        private void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(AdminViewModel));
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(AdminViewModel), OnPostDeleted);
        }
    }
}
