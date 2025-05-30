using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;
using Microsoft.Maui.Storage;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(CroppedPhotoSource), "new-src")]
    public partial class ProfileViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly IUserApi _userApi;
        private readonly IAuthApi _authApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly IFingerprint _fingerprint;
        private readonly IPreferencesService _preferencesService;

        public ProfileViewModel(
            IPostApi postsApi,
            AuthService authService,
            IAuthApi authApi,
            IUserApi userApi,
            RealtimeUpdatesService realtimeUpdatesService,
            IPreferencesService preferencesService)
            : base(postsApi, realtimeUpdatesService)
        {
            User = authService.User!;
            _authService = authService;
            _authApi = authApi;
            _userApi = userApi;
            _realtimeUpdatesService = realtimeUpdatesService;
            _fingerprint = CrossFingerprint.Current;
            _preferencesService = preferencesService;

            IsFingerprintEnabled = _preferencesService.GetBool("FingerprintAuthEnabled", false);
            ConfigureRealtimeUpdates();
        }

        [ObservableProperty]
        private LoggedInUser _user;

        [ObservableProperty]
        private bool _isUploading;

        [ObservableProperty]
        private bool _isFingerprintEnabled;

        [ObservableProperty]
        private bool _isProfileMenuOpen;

        [ObservableProperty]
        private string _currentPassword;

        [ObservableProperty]
        private string _newPassword;

        [ObservableProperty]
        private string _confirmNewPassword;

        [ObservableProperty]
        private string _newName;

        [ObservableProperty]
        private bool _isChangePasswordVisible;

        [ObservableProperty, NotifyPropertyChangedFor(nameof(IsBookmarksTabSelected))]
        private bool _isMyPostsTabSelected = true;

        public bool IsBookmarksTabSelected => !IsMyPostsTabSelected;

        private int _myPostsStartIndex = 0;
        public ObservableCollection<PostModel> MyPosts { get; set; } = new ObservableCollection<PostModel>();

        private int _bookmarkedPostsStartIndex = 0;
        public ObservableCollection<PostModel> BookmarkedPosts { get; set; } = new ObservableCollection<PostModel>();

        private const int PageSize = 4;

        [ObservableProperty]
        private string? _croppedPhotoSource;

        partial void OnIsFingerprintEnabledChanged(bool value)
        {
            _preferencesService.SetBool("FingerprintAuthEnabled", value);
        }

        /// <summary>
        /// Làm mới token nếu JWT hết hạn.
        /// </summary>
        /// <returns>True nếu token được làm mới thành công hoặc không cần làm mới, False nếu thất bại.</returns>
        private async Task<bool> TryRefreshTokenAsync()
        {
            var refreshToken = await SecureStorage.GetAsync("RefreshToken");
            if (string.IsNullOrEmpty(refreshToken))
            {
                await ShowErrorAlertAsync("Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
                await NavigateAsync($"//{nameof(LoginPage)}");
                return false;
            }

            try
            {
                var refreshResult = await _authApi.RefreshTokenAsync(new RefreshTokenDto { RefreshToken = refreshToken });
                if (refreshResult.IsSuccess && refreshResult.Data != null)
                {
                    await SecureStorage.SetAsync("AuthToken", refreshResult.Data.Token);
                    await SecureStorage.SetAsync("RefreshToken", refreshResult.Data.RefreshToken);
                    _authService.Login(refreshResult.Data);
                    return true;
                }
            }
            catch (Exception ex)
            {
                // Lỗi khi làm mới token
                Console.WriteLine($"Lỗi làm mới token: {ex.Message}");
            }

            await ShowErrorAlertAsync("Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
            await NavigateAsync($"//{nameof(LoginPage)}");
            return false;
        }

        [RelayCommand]
        private void ToggleProfileMenu()
        {
            IsProfileMenuOpen = !IsProfileMenuOpen;
        }

        [RelayCommand]
        private async Task ShowFingerprintSettingsAsync()
        {
            var canAuthenticate = await _fingerprint.IsAvailableAsync();

            if (!canAuthenticate)
            {
                await Shell.Current.DisplayAlert("Không khả dụng",
                    "Xác thực vân tay không khả dụng trên thiết bị này.", "OK");
                IsFingerprintEnabled = false;
                return;
            }

            if (!IsFingerprintEnabled)
            {
                var result = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
                    "Bật đăng nhập bằng vân tay",
                    "Xác minh vân tay của bạn để bật đăng nhập bằng vân tay")
                {
                    AllowAlternativeAuthentication = true,
                    CancelTitle = "Hủy"
                });

                if (result.Authenticated)
                {
                    IsFingerprintEnabled = true;
                    await Shell.Current.DisplayAlert("Thành công",
                        "Đăng nhập bằng vân tay đã được bật thành công.", "OK");
                }
                else
                {
                    IsFingerprintEnabled = false;
                }
            }
            else
            {
                var confirm = await Shell.Current.DisplayAlert("Tắt đăng nhập bằng vân tay",
                    "Bạn có chắc chắn muốn tắt đăng nhập bằng vân tay không?", "Có", "Không");

                if (confirm)
                {
                    IsFingerprintEnabled = false;
                    await Shell.Current.DisplayAlert("Thành công",
                        "Đăng nhập bằng vân tay đã bị tắt.", "OK");
                }
            }
        }

        [RelayCommand]
        private async Task LogoutAsync()
        {
            if (await Shell.Current.DisplayAlert("Xác nhận đăng xuất?", "Bạn có thực sự muốn đăng xuất không?", "Có", "Không"))
            {
                _authService.Logout();
                SecureStorage.Remove("AuthToken");
                SecureStorage.Remove("RefreshToken");
                _preferencesService.SetBool("FingerprintAuthEnabled", false);
                _preferencesService.SetString("LastEmail", "");
                _preferencesService.SetString("DisplayName", "");
                _preferencesService.SetString("AvatarUrl", "");
                await NavigateAsync($"//{nameof(LoginPage)}");
            }
        }

        [RelayCommand]
        private async Task ShowChangePasswordAsync()
        {
            IsChangePasswordVisible = true;
            IsProfileMenuOpen = false;

            var currentPasswordEntry = new Entry { Placeholder = "Mật khẩu hiện tại", IsPassword = true };
            var newPasswordEntry = new Entry { Placeholder = "Mật khẩu mới", IsPassword = true };
            var confirmNewPasswordEntry = new Entry { Placeholder = "Xác nhận mật khẩu mới", IsPassword = true };

            var stackLayout = new VerticalStackLayout
            {
                Spacing = 10,
                Children =
                {
                    new Label { Text = "Đổi mật khẩu", FontAttributes = FontAttributes.Bold, FontSize = 18 },
                    currentPasswordEntry,
                    newPasswordEntry,
                    confirmNewPasswordEntry,
                    new Button
                    {
                        Text = "Lưu",
                        Command = new Command(async () =>
                        {
                            CurrentPassword = currentPasswordEntry.Text;
                            NewPassword = newPasswordEntry.Text;
                            ConfirmNewPassword = confirmNewPasswordEntry.Text;
                            await ChangePasswordAsync();
                        })
                    },
                    new Button
                    {
                        Text = "Hủy",
                        Command = new Command(async () =>
                        {
                            await CancelChangePasswordAsync();
                        })
                    }
                }
            };

            var contentPage = new ContentPage
            {
                Content = stackLayout,
                Padding = new Thickness(20)
            };

            await Shell.Current.Navigation.PushModalAsync(contentPage);
        }

        [RelayCommand]
        private async Task ChangePasswordAsync()
        {
            if (string.IsNullOrWhiteSpace(CurrentPassword) ||
                string.IsNullOrWhiteSpace(NewPassword) ||
                string.IsNullOrWhiteSpace(ConfirmNewPassword))
            {
                await ShowErrorAlertAsync("Tất cả các trường đều bắt buộc.");
                return;
            }

            if (NewPassword != ConfirmNewPassword)
            {
                await ShowErrorAlertAsync("Mật khẩu mới và xác nhận không khớp.");
                return;
            }

            if (NewPassword.Length < 6)
            {
                await ShowErrorAlertAsync("Mật khẩu mới phải dài ít nhất 6 ký tự.");
                return;
            }

            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var dto = new ChangePasswordDto
                {
                    CurrentPassword = CurrentPassword,
                    NewPassword = NewPassword
                };
                try
                {
                    var result = await _userApi.ChangePasswordAsync(token, dto);
                    if (result.IsSuccess)
                    {
                        await ToastAsync("Đổi mật khẩu thành công.");
                        await CancelChangePasswordAsync();
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Không thể đổi mật khẩu.");
                    }
                }
                catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    // Token hết hạn, thử làm mới
                    if (await TryRefreshTokenAsync())
                    {
                        token = "Bearer " + _authService.Token;
                        var result = await _userApi.ChangePasswordAsync(token, dto);
                        if (result.IsSuccess)
                        {
                            await ToastAsync("Đổi mật khẩu thành công.");
                            await CancelChangePasswordAsync();
                        }
                        else
                        {
                            await ShowErrorAlertAsync(result.Error ?? "Không thể đổi mật khẩu.");
                        }
                    }
                }
            });
        }

        [RelayCommand]
        private async Task CancelChangePasswordAsync()
        {
            CurrentPassword = string.Empty;
            NewPassword = string.Empty;
            ConfirmNewPassword = string.Empty;
            IsChangePasswordVisible = false;
            await Shell.Current.Navigation.PopModalAsync();
        }

        [RelayCommand]
        private async Task ShowChangeNameAsync()
        {
            IsProfileMenuOpen = false;

            var nameEntry = new Entry { Placeholder = "Tên mới", Text = User.Name };

            var stackLayout = new VerticalStackLayout
            {
                Spacing = 10,
                Children =
                {
                    new Label { Text = "Đổi tên", FontAttributes = FontAttributes.Bold, FontSize = 18 },
                    nameEntry,
                    new Button
                    {
                        Text = "Lưu",
                        Command = new Command(async () =>
                        {
                            NewName = nameEntry.Text;
                            await ChangeNameAsync();
                        })
                    },
                    new Button
                    {
                        Text = "Hủy",
                        Command = new Command(async () =>
                        {
                            await CancelChangeNameAsync();
                        })
                    }
                }
            };

            var contentPage = new ContentPage
            {
                Content = stackLayout,
                Padding = new Thickness(20)
            };

            await Shell.Current.Navigation.PushModalAsync(contentPage);
        }

        [RelayCommand]
        private async Task ChangeNameAsync()
        {
            if (string.IsNullOrWhiteSpace(NewName))
            {
                await ShowErrorAlertAsync("Tên là bắt buộc.");
                return;
            }

            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var dto = new ChangeNameDto { NewName = NewName };
                try
                {
                    var result = await _userApi.ChangeNameAsync(token, dto);
                    if (result.IsSuccess)
                    {
                        User = User with { Name = NewName };
                        _authService.Login(new LoginResponseDto(User, _authService.Token, await SecureStorage.GetAsync("RefreshToken")));
                        _preferencesService.SetString("DisplayName", NewName);
                        await ToastAsync("Đổi tên thành công.");
                        await CancelChangeNameAsync();
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Không thể đổi tên.");
                    }
                }
                catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    // Token hết hạn, thử làm mới
                    if (await TryRefreshTokenAsync())
                    {
                        token = "Bearer " + _authService.Token;
                        var result = await _userApi.ChangeNameAsync(token, dto);
                        if (result.IsSuccess)
                        {
                            User = User with { Name = NewName };
                            _authService.Login(new LoginResponseDto(User, _authService.Token, await SecureStorage.GetAsync("RefreshToken")));
                            _preferencesService.SetString("DisplayName", NewName);
                            await ToastAsync("Đổi tên thành công.");
                            await CancelChangeNameAsync();
                        }
                        else
                        {
                            await ShowErrorAlertAsync(result.Error ?? "Không thể đổi tên.");
                        }
                    }
                }
            });
        }

        [RelayCommand]
        private async Task CancelChangeNameAsync()
        {
            NewName = string.Empty;
            await Shell.Current.Navigation.PopModalAsync();
        }

        [RelayCommand]
        public async Task ChangePhotoAsync()
        {
            var selectedPhotoSource = await ChoosePhotoAsync();
            if (!string.IsNullOrWhiteSpace(selectedPhotoSource))
            {
                await NavigateAsync(nameof(CropPhotoPage), new Dictionary<string, object> { ["new-src"] = selectedPhotoSource });
            }
        }

        async partial void OnCroppedPhotoSourceChanged(string? oldValue, string? newValue)
        {
            if (string.IsNullOrWhiteSpace(newValue) || !File.Exists(newValue))
            {
                await ShowErrorAlertAsync("Hình ảnh đã cắt không hợp lệ hoặc không tồn tại.");
                return;
            }

            var confirm = await Shell.Current.DisplayAlert("Xác nhận", "Sử dụng ảnh này làm ảnh đại diện mới của bạn?", "Có", "Không");
            if (!confirm)
            {
                try
                {
                    File.Delete(newValue);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Không thể xóa tệp tạm: {ex.Message}");
                }
                return;
            }

            IsUploading = true;
            await MakeApiCall(async () =>
            {
                try
                {
                    using var fs = File.OpenRead(newValue);
                    var fileName = Path.GetFileName(newValue);
                    var photoStreamPart = new StreamPart(fs, fileName, "image/jpeg");

                    var token = "Bearer " + _authService.Token;
                    try
                    {
                        var result = await _userApi.ChangePhotoAsync(token, photoStreamPart);
                        if (!result.IsSuccess)
                        {
                            await ShowErrorAlertAsync(result.Error);
                            return;
                        }

                        User = User with { PhotoUrl = result.Data };
                        _authService.Login(new LoginResponseDto(User, _authService.Token, await SecureStorage.GetAsync("RefreshToken")));
                        _preferencesService.SetString("AvatarUrl", result.Data);
                        try
                        {
                            File.Delete(newValue);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Không thể xóa tệp tạm: {ex.Message}");
                        }
                    }
                    catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                    {
                        // Token hết hạn, thử làm mới
                        if (await TryRefreshTokenAsync())
                        {
                            token = "Bearer " + _authService.Token;
                            var result = await _userApi.ChangePhotoAsync(token, photoStreamPart);
                            if (!result.IsSuccess)
                            {
                                await ShowErrorAlertAsync(result.Error);
                                return;
                            }

                            User = User with { PhotoUrl = result.Data };
                            _authService.Login(new LoginResponseDto(User, _authService.Token, await SecureStorage.GetAsync("RefreshToken")));
                            _preferencesService.SetString("AvatarUrl", result.Data);
                            try
                            {
                                File.Delete(newValue);
                            }
                            catch (Exception)
                            {
                                Console.WriteLine($"Không thể xóa tệp tạm: {ex.Message}");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    await ShowErrorAlertAsync($"Không thể tải ảnh lên: {ex.Message}");
                }
                finally
                {
                    IsUploading = false;
                }
            });
        }

        [RelayCommand]
        private async Task SelectMyPostsTabAsync()
        {
            IsMyPostsTabSelected = true;
            _myPostsStartIndex = 0;
            await FetchMyPostsAsync();
        }

        [RelayCommand]
        private async Task SelectBookmarkedPostsTabAsync()
        {
            IsMyPostsTabSelected = false;
            _bookmarkedPostsStartIndex = 0;
            await FetchBookmarkedPostsAsync();
        }

        [RelayCommand]
        private async Task FetchMyPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                try
                {
                    var posts = await _userApi.GetUserPostsAsync(token, _myPostsStartIndex, PageSize);
                    if (posts.Length > 0)
                    {
                        if (_myPostsStartIndex == 0)
                            MyPosts.Clear();
                        _myPostsStartIndex += posts.Length;
                        foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                        {
                            MyPosts.Add(PostModel.FromDto(p, PostsApi, _realtimeUpdatesService, _authService));
                        }
                    }
                }
                catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    // Token hết hạn, thử làm mới
                    if (await TryRefreshTokenAsync())
                    {
                        token = "Bearer " + _authService.Token;
                        var posts = await _userApi.GetUserPostsAsync(token, _myPostsStartIndex, PageSize);
                        if (posts.Length > 0)
                        {
                            if (_myPostsStartIndex == 0)
                                MyPosts.Clear();
                            _myPostsStartIndex += posts.Length;
                            foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                            {
                                MyPosts.Add(PostModel.FromDto(p, PostsApi, _realtimeUpdatesService, _authService));
                            }
                        }
                    }
                }
            });
        }

        [RelayCommand]
        private async Task FetchBookmarkedPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                try
                {
                    var posts = await _userApi.GetUserBookmarkedPostsAsync(token, _bookmarkedPostsStartIndex, PageSize);
                    if (posts.Length > 0)
                    {
                        if (_bookmarkedPostsStartIndex == 0)
                            BookmarkedPosts.Clear();

                        _bookmarkedPostsStartIndex += posts.Length;
                        foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                        {
                            var newPost = PostModel.FromDto(p, PostsApi, _realtimeUpdatesService, _authService);
                            if (!BookmarkedPosts.Any(existing => existing.PostId == newPost.PostId))
                            {
                                BookmarkedPosts.Add(newPost);
                            }
                        }
                    }
                }
                catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    // Token hết hạn, thử làm mới
                    if (await TryRefreshTokenAsync())
                    {
                        token = "Bearer " + _authService.Token;
                        var posts = await _userApi.GetUserBookmarkedPostsAsync(token, _bookmarkedPostsStartIndex, PageSize);
                        if (posts.Length > 0)
                        {
                            if (_bookmarkedPostsStartIndex == 0)
                                BookmarkedPosts.Clear();

                            _bookmarkedPostsStartIndex += posts.Length;
                            foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                            {
                                var newPost = PostModel.FromDto(p, PostsApi, _realtimeUpdatesService, _authService);
                                if (!BookmarkedPosts.Any(existing => existing.PostId == newPost.PostId))
                                {
                                    BookmarkedPosts.Add(newPost);
                                }
                            }
                        }
                    }
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddPostChangedHandler(nameof(ProfileViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(ProfileViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(ProfileViewModel), OnUserPhotoChanged);
        }

        private void OnPostChanged(PostDto post)
        {
            var myPost = MyPosts.FirstOrDefault(p => p.PostId == post.PostId);
            if (myPost != null)
            {
                myPost.Content = post.Content;
                myPost.PhotoUrl = post.PhotoUrl;
            }

            var bookmarkedPost = BookmarkedPosts.FirstOrDefault(p => p.PostId == post.PostId);
            if (bookmarkedPost != null)
            {
                bookmarkedPost.Content = post.Content;
                bookmarkedPost.PhotoUrl = post.PhotoUrl;
            }
            OnPropertyChanged(post.IsLikeIcon);
            OnPropertyChanged(post.IsBookmarkIcon);
        }

        private void OnPostDeleted(Guid postId)
        {
            var postToRemove = MyPosts.FirstOrDefault(p => p.PostId == postId);
            if (postToRemove != null)
            {
                MyPosts.Remove(postToRemove);
            }
            postToRemove = BookmarkedPosts.FirstOrDefault(p => p.PostId == postId);
            if (postToRemove != null)
            {
                BookmarkedPosts.Remove(postToRemove);
            }
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            if (dto.UserId == User.Id)
            {
                User = User with { PhotoUrl = dto.PhotoUrl };
                foreach (var post in MyPosts)
                {
                    post.UserPhotoUrl = dto.PhotoUrl;
                }
            }
            foreach (var post in BookmarkedPosts.Where(p => p.UserId == dto.UserId))
            {
                post.UserPhotoUrl = dto.PhotoUrl;
            }
        }
    }
}