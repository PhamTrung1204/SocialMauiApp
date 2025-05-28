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
                await Shell.Current.DisplayAlert("Not Available",
                    "Fingerprint authentication is not available on this device.", "OK");
                IsFingerprintEnabled = false;
                return;
            }

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

        [RelayCommand]
        private async Task ShowChangePasswordAsync()
        {
            IsChangePasswordVisible = true;
            IsProfileMenuOpen = false;

            var currentPasswordEntry = new Entry { Placeholder = "Current Password", IsPassword = true };
            var newPasswordEntry = new Entry { Placeholder = "New Password", IsPassword = true };
            var confirmNewPasswordEntry = new Entry { Placeholder = "Confirm New Password", IsPassword = true };

            var stackLayout = new VerticalStackLayout
            {
                Spacing = 10,
                Children =
                {
                    new Label { Text = "Change Password", FontAttributes = FontAttributes.Bold, FontSize = 18 },
                    currentPasswordEntry,
                    newPasswordEntry,
                    confirmNewPasswordEntry,
                    new Button
                    {
                        Text = "Save",
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
                        Text = "Cancel",
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
                await ShowErrorAlertAsync("All fields are required.");
                return;
            }

            if (NewPassword != ConfirmNewPassword)
            {
                await ShowErrorAlertAsync("New password and confirmation do not match.");
                return;
            }

            if (NewPassword.Length < 6)
            {
                await ShowErrorAlertAsync("New password must be at least 6 characters long.");
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
                var result = await _userApi.ChangePasswordAsync(token, dto);
                if (result.IsSuccess)
                {
                    await ToastAsync("Password changed successfully.");
                    await CancelChangePasswordAsync();
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Failed to change password.");
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

            var nameEntry = new Entry { Placeholder = "New Name", Text = User.Name };

            var stackLayout = new VerticalStackLayout
            {
                Spacing = 10,
                Children =
                {
                    new Label { Text = "Change Name", FontAttributes = FontAttributes.Bold, FontSize = 18 },
                    nameEntry,
                    new Button
                    {
                        Text = "Save",
                        Command = new Command(async () =>
                        {
                            NewName = nameEntry.Text;
                            await ChangeNameAsync();
                        })
                    },
                    new Button
                    {
                        Text = "Cancel",
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
                await ShowErrorAlertAsync("Name is required.");
                return;
            }

            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var dto = new ChangeNameDto { NewName = NewName };
                var result = await _userApi.ChangeNameAsync(token, dto);
                if (result.IsSuccess)
                {
                    User = User with { Name = NewName };
                    _authService.Login(new LoginResponseDto(User, _authService.Token));
                    await ToastAsync("Name changed successfully.");
                    await CancelChangeNameAsync();
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Failed to change name.");
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
                await ShowErrorAlertAsync("Cropped image is invalid or does not exist.");
                return;
            }

            var confirm = await Shell.Current.DisplayAlert("Confirm", "Use this photo as your new profile picture?", "Yes", "No");
            if (!confirm)
            {
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

                    User = User with { PhotoUrl = result.Data };
                    _authService.Login(new LoginResponseDto(User, _authService.Token));

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
                        MyPosts.Add(PostModel.FromDto(p, PostsApi, _realtimeUpdatesService, _authService));
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
                        var newPost = PostModel.FromDto(p, PostsApi, _realtimeUpdatesService, _authService);
                        if (!BookmarkedPosts.Any(existing => existing.PostId == newPost.PostId))
                        {
                            BookmarkedPosts.Add(newPost);
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