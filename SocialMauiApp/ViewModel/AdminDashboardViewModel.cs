//using CommunityToolkit.Mvvm.ComponentModel;
//using CommunityToolkit.Mvvm.Input;
//using Microsoft.Maui.Controls;
//using SocialMauiApp.Apis;
//using SocialMediaMaui.Shared.Dtos;
//using System;
//using System.Collections.ObjectModel;
//using System.Linq;
//using System.Threading.Tasks;

//namespace SocialMauiApp.ViewModels
//{
//    public partial class AdminDashboardViewModel : ObservableObject
//    {
//        private readonly IUserApi _userApi;
//        private readonly IPostApi _postApi;
//        private readonly string _authToken;

//        [ObservableProperty]
//        private int totalPosts;

//        [ObservableProperty]
//        private int pendingPosts;

//        [ObservableProperty]
//        private int totalUsers;

//        [ObservableProperty]
//        private ObservableCollection<UserDto> users;

//        [ObservableProperty]
//        private UserDto selectedUser;

//        public AdminDashboardViewModel(IUserApi userApi, IPostApi postApi)
//        {
//            _userApi = userApi;
//            _postApi = postApi;
//            _authToken = Preferences.Get("auth_token", string.Empty); // Lấy token từ Preferences
//            LoadDataCommand = new AsyncRelayCommand(LoadDataAsync);
//            NavigateToPostManagementCommand = new AsyncRelayCommand(NavigateToPostManagementAsync);
//            ToggleUserLockCommand = new AsyncRelayCommand(ToggleUserLockAsync);
//            DeleteUserCommand = new AsyncRelayCommand(DeleteUserAsync);
//        }

//        public IAsyncRelayCommand LoadDataCommand { get; }
//        public IAsyncRelayCommand NavigateToPostManagementCommand { get; }
//        public IAsyncRelayCommand ToggleUserLockCommand { get; }
//        public IAsyncRelayCommand DeleteUserCommand { get; }

//        private async Task LoadDataAsync()
//        {
//            try
//            {
//                // Lấy danh sách bài viết
//                var posts = await _postApi.GetPostsAsync(0, int.MaxValue);
//                TotalPosts = posts.Length;
//                //PendingPosts = posts.Count(p => !p.IsApproved);

//                // Lấy danh sách người dùng
//                // Giả định có endpoint GetAllUsersAsync, nếu không thì dùng GetUserPostsAsync để suy ra
//                UserDto[] users;
//                try
//                {
//                    users = await _userApi.GetAllUsersAsync(_authToken);
//                }
//                catch
//                {
//                    // Fallback: Suy ra danh sách người dùng từ bài viết
//                    var postUsers = await _postApi.GetPostsAsync(0, int.MaxValue);
//                    users = postUsers
//                        .GroupBy(p => p.UserId)
//                        .Select(g => new UserDto
//                        {
//                            Id = g.Key,
//                            Name = g.First().UserName,
//                            Email = g.First().UserName + "@example.com", // Giả định
                   
//                            IsLocked = false // Cần endpoint trả về IsLocked
//                        })
//                        .ToArray();
//                }

//                Users = new ObservableCollection<UserDto>(users);
//                TotalUsers = Users.Count;
//            }
//            catch (Exception ex)
//            {
//                await Application.Current.MainPage.DisplayAlert("Error", $"Can't load data: {ex.Message}", "OK");
//            }
//        }

//        private async Task NavigateToPostManagementAsync()
//        {
//            await Shell.Current.GoToAsync(nameof(AdminDashboardPage));
//        }

//        private async Task ToggleUserLockAsync()
//        {
//            if (SelectedUser == null) return;

//            try
//            {
//                bool newStatus = !SelectedUser.IsLocked;
//                var result = await _userApi.LockUserAsync(_authToken, SelectedUser.Id, newStatus);
//                if (result.IsSuccess)
//                {
//                    SelectedUser.IsLocked = newStatus;
//                    OnPropertyChanged(nameof(Users));
//                }
//                else
//                {
//                    await Application.Current.MainPage.DisplayAlert("Error", result.Error, "OK");
//                }
//            }
//            catch (Exception ex)
//            {
//                await Application.Current.MainPage.DisplayAlert("Error", $"Can't change status: {ex.Message}", "OK");
//            }
//        }

//        private async Task DeleteUserAsync()
//        {
//            if (SelectedUser == null) return;

//            bool confirm = await Application.Current.MainPage.DisplayAlert(
//                "Confirm delete",
//                $"Do you want to delete account {SelectedUser.Name}?",
//                "Yes", "No");

//            if (confirm)
//            {
//                try
//                {
//                    var result = await _userApi.DeleteUserAsync(_authToken, SelectedUser.Id);
//                    if (result.IsSuccess)
//                    {
//                        Users.Remove(SelectedUser);
//                        SelectedUser = null;
//                        TotalUsers = Users.Count;
//                    }
//                    else
//                    {
//                        await Application.Current.MainPage.DisplayAlert("Lỗi", result.Error, "OK");
//                    }
//                }
//                catch (Exception ex)
//                {
//                    await Application.Current.MainPage.DisplayAlert("Lỗi", $"Không thể xóa tài khoản: {ex.Message}", "OK");
//                }
//            }
//        }
//    }
//}