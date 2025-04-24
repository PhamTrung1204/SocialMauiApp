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

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(CroppedPhotoSource), "new-src")]
    public partial class ProfileViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly IUserApi _userApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly IFingerprint _fingerprint;
        private readonly IPreferencesService _preferencesService;

        public ProfileViewModel(
            IPostApi postsApi,
            AuthService authService,
            IUserApi userApi,
            RealtimeUpdatesService realtimeUpdatesService,
            IPreferencesService preferencesService)
            : base(postsApi, realtimeUpdatesService)
        {
            User = authService.User!;
            _authService = authService;
            _userApi = userApi;
            _realtimeUpdatesService = realtimeUpdatesService;
            _fingerprint = CrossFingerprint.Current;
            _preferencesService = preferencesService;

            // Load fingerprint auth setting
            IsFingerprintEnabled = _preferencesService.GetBool("FingerprintAuthEnabled", false);

            ConfigureRealtimeUpdates();
        }

        [ObservableProperty]
        private LoggedInUser _user;

        [ObservableProperty]
        private bool _isUploading;

        [ObservableProperty]
        private bool _isFingerprintEnabled;

        partial void OnIsFingerprintEnabledChanged(bool value)
        {
            _preferencesService.SetBool("FingerprintAuthEnabled", value);
        }

        [RelayCommand]
        private async Task ShowFingerprintSettingsAsync()
        {
            var canAuthenticate = await _fingerprint.IsAvailableAsync();

            if (!canAuthenticate)
            {
                await Shell.Current.DisplayAlert("Not Available",
                    "Fingerprint authentication is not available on this device.", "OK");
                IsFingerprintEnabled = false;
                return;
            }

            // If enabling fingerprint, verify first with a fingerprint check
            if (!IsFingerprintEnabled)
            {
                var result = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
                    "Enable Fingerprint Login",
                    "Verify your fingerprint to enable fingerprint login")
                {
                    AllowAlternativeAuthentication = true,
                    CancelTitle = "Cancel"
                });

                if (result.Authenticated)
                {
                    IsFingerprintEnabled = true;
                    await Shell.Current.DisplayAlert("Success",
                        "Fingerprint login has been enabled successfully.", "OK");
                }
                else
                {
                    IsFingerprintEnabled = false;
                }
            }
            else
            {
                var confirm = await Shell.Current.DisplayAlert("Disable Fingerprint",
                    "Are you sure you want to disable fingerprint login?", "Yes", "No");

                if (confirm)
                {
                    IsFingerprintEnabled = false;
                    await Shell.Current.DisplayAlert("Success",
                        "Fingerprint login has been disabled.", "OK");
                }
            }
        }

        [RelayCommand]
        private async Task LogoutAsync()
        {
            if (await Shell.Current.DisplayAlert("Confirm Logout?", "Do you really want to logout?", "Yes", "No"))
            {
                _authService.Logout();
                await NavigateAsync($"//{nameof(LoginPage)}");
            }
        }

        [ObservableProperty, NotifyPropertyChangedFor(nameof(IsBookmarksTabSelected))]
        private bool _isMyPostsTabSelected = true;
        public bool IsBookmarksTabSelected => !IsMyPostsTabSelected;

        private int _myPostsStartIndex = 0;
        public ObservableCollection<PostModel> MyPosts { get; set; } = new ObservableCollection<PostModel>();
        private int _bookmarkedPostsStartIndex = 0;
        public ObservableCollection<PostModel> BookmarkedPosts { get; set; } = new ObservableCollection<PostModel>();
        private const int PageSize = 4;

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
                var posts = await _userApi.GetUserPostsAsync(token, _myPostsStartIndex, PageSize);

                if (posts.Length > 0)
                {
                    if (_myPostsStartIndex == 0)
                        MyPosts.Clear();
                    _myPostsStartIndex += posts.Length;
                    foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                    {
                        MyPosts.Add(PostModel.FromDto(p, PostsApi, _realtimeUpdatesService));
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
                var posts = await _userApi.GetUserBookmarkedPostsAsync(token, _bookmarkedPostsStartIndex, PageSize);

                if (posts.Length > 0)
                {
                    if (_bookmarkedPostsStartIndex == 0)
                        BookmarkedPosts.Clear();

                    _bookmarkedPostsStartIndex += posts.Length;
                    foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                    {
                        var newPost = PostModel.FromDto(p, PostsApi, _realtimeUpdatesService);
                        if (!BookmarkedPosts.Any(existing => existing.PostId == newPost.PostId))
                        {
                            BookmarkedPosts.Add(newPost);
                        }
                    }
                }
            });
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

        [ObservableProperty]
        private string? _croppedPhotoSource;

        async partial void OnCroppedPhotoSourceChanged(string? oldValue, string? newValue)
        {
            if (string.IsNullOrWhiteSpace(newValue) || !File.Exists(newValue))
            {
                await ShowErrorAlertAsync("Cropped image is invalid or does not exist.");
                return;
            }

            var confirm = await Shell.Current.DisplayAlert("Confirm", "Use this photo as your new profile picture?", "Yes", "No");
            if (!confirm)
            {
                // Xóa file tạm nếu không upload
                try
                {
                    File.Delete(newValue);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Failed to delete temp file: {ex.Message}");
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
                    var result = await _userApi.ChangePhotoAsync(token, photoStreamPart);

                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    // Cập nhật User với URL ảnh mới
                    User = User with { PhotoUrl = result.Data };
                    _authService.Login(new LoginResponseDto(User, _authService.Token));

                    // Xóa file tạm sau khi upload thành công
                    try
                    {
                        File.Delete(newValue);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Failed to delete temp file: {ex.Message}");
                    }
                }
                catch (Exception ex)
                {
                    await ShowErrorAlertAsync($"Failed to upload photo: {ex.Message}");
                }
                finally
                {
                    IsUploading = false;
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