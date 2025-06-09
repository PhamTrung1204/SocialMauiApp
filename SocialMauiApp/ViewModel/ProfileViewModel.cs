using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;
using Microsoft.Maui.Storage;

namespace SocialMauiApp.ViewModel;

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

    [ObservableProperty] private LoggedInUser user;
    [ObservableProperty] private bool isUploading;
    [ObservableProperty] private bool isFingerprintEnabled;
    [ObservableProperty] private bool isProfileMenuOpen;
    [ObservableProperty] private string currentPassword;
    [ObservableProperty] private string newPassword;
    [ObservableProperty] private string confirmNewPassword;
    [ObservableProperty] private string newName;
    [ObservableProperty] private bool isChangePasswordVisible;
    [ObservableProperty, NotifyPropertyChangedFor(nameof(IsBookmarksTabSelected))]
    private bool isMyPostsTabSelected = true;
    [ObservableProperty] private string? croppedPhotoSource;

    public bool IsBookmarksTabSelected => !IsMyPostsTabSelected;
    private int _myPostsStartIndex = 0;
    public ObservableCollection<PostModel> MyPosts { get; set; } = new ObservableCollection<PostModel>();
    private int _bookmarkedPostsStartIndex = 0;
    public ObservableCollection<PostModel> BookmarkedPosts { get; set; } = new ObservableCollection<PostModel>();
    private const int PageSize = 4;

    partial void OnIsFingerprintEnabledChanged(bool value)
    {
        _preferencesService.SetBool("FingerprintAuthEnabled", value);
    }

    private async Task<bool> TryRefreshTokenAsync()
    {
        var refreshToken = await SecureStorage.GetAsync("RefreshToken");
        if (string.IsNullOrEmpty(refreshToken))
        {
            await ShowErrorAlertAsync("Your session has expired. Please log in again.");
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
            Console.WriteLine($"Token refresh error: {ex.Message}");
        }

        await ShowErrorAlertAsync("Your session has expired. Please log in again.");
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
            await Shell.Current.DisplayAlert("Not Available",
                "Fingerprint authentication is not available on this device.", "OK");
            IsFingerprintEnabled = false;
            _preferencesService.SetBool("FingerprintAuthEnabled", false);
            SecureStorage.Remove("StoredPassword");
            return;
        }

        if (!IsFingerprintEnabled)
        {
            var emailEntry = new Entry { Placeholder = "Enter email", Text = _preferencesService.GetString("LastEmail", "") };
            var passwordEntry = new Entry { Placeholder = "Enter password", IsPassword = true };
            var stackLayout = new VerticalStackLayout
            {
                Spacing = 10,
                Children =
                {
                    new Label { Text = "Enable Fingerprint Login", FontAttributes = FontAttributes.Bold, FontSize = 18 },
                    emailEntry,
                    passwordEntry,
                    new Button
                    {
                        Text = "Confirm",
                        Command = new Command(async () =>
                        {
                            var email = emailEntry.Text;
                            var password = passwordEntry.Text;
                            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
                            {
                                await Shell.Current.DisplayAlert("Error", "Please enter both email and password.", "OK");
                                return;
                            }

                            var loginDto = new LoginDto(email, password);
                            var loginResult = await _authApi.LoginAsync(loginDto);
                            if (!loginResult.IsSuccess)
                            {
                                await Shell.Current.DisplayAlert("Error", "Invalid email or password.", "OK");
                                return;
                            }

                            var result = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
                                "Enable Fingerprint Login",
                                "Confirm your fingerprint to enable fingerprint login")
                            {
                                AllowAlternativeAuthentication = false,
                                CancelTitle = "Cancel"
                            });

                            if (result.Authenticated)
                            {
                                await SecureStorage.SetAsync("StoredPassword", password);
                                await SecureStorage.SetAsync("AuthToken", loginResult.Data.Token);
                                await SecureStorage.SetAsync("RefreshToken", loginResult.Data.RefreshToken);
                                _preferencesService.SetString("LastEmail", email);
                                _preferencesService.SetBool("FingerprintAuthEnabled", true);
                                IsFingerprintEnabled = true;
                                _authService.Login(loginResult.Data);
                                await Shell.Current.DisplayAlert("Success",
                                    "Fingerprint login enabled successfully.", "OK");
                                await Shell.Current.Navigation.PopModalAsync();
                            }
                            else
                            {
                                await Shell.Current.DisplayAlert("Error",
                                    "Fingerprint authentication failed.", "OK");
                            }
                        })
                    },
                    new Button
                    {
                        Text = "Cancel",
                        Command = new Command(async () => await Shell.Current.Navigation.PopModalAsync())
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
        else
        {
            var confirm = await Shell.Current.DisplayAlert("Disable Fingerprint Login",
                "Are you sure you want to disable fingerprint login?", "Yes", "No");

            if (confirm)
            {
                IsFingerprintEnabled = false;
                _preferencesService.SetBool("FingerprintAuthEnabled", false);
                SecureStorage.Remove("StoredPassword");
                await Shell.Current.DisplayAlert("Success",
                    "Fingerprint login has been disabled.", "OK");
            }
        }
    }

    [RelayCommand]
    private async Task LogoutAsync()
    {
        if (await Shell.Current.DisplayAlert("Confirm Logout?", "Are you sure you want to log out?", "Yes", "No"))
        {
            _authService.Logout();
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
                    Command = new Command(async () => await CancelChangePasswordAsync())
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
            try
            {
                var result = await _userApi.ChangePasswordAsync(token, dto);
                if (result.IsSuccess)
                {
                    if (_preferencesService.GetBool("FingerprintAuthEnabled", false))
                    {
                        await SecureStorage.SetAsync("StoredPassword", NewPassword);
                    }
                    await ToastAsync("Password changed successfully.");
                    await CancelChangePasswordAsync();
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Unable to change password.");
                }
            }
            catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
            {
                if (await TryRefreshTokenAsync())
                {
                    token = "Bearer " + _authService.Token;
                    var result = await _userApi.ChangePasswordAsync(token, dto);
                    if (result.IsSuccess)
                    {
                        if (_preferencesService.GetBool("FingerprintAuthEnabled", false))
                        {
                            await SecureStorage.SetAsync("StoredPassword", NewPassword);
                        }
                        await ToastAsync("Password changed successfully.");
                        await CancelChangePasswordAsync();
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Unable to change password.");
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
                    Command = new Command(async () => await CancelChangeNameAsync())
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
            try
            {
                var result = await _userApi.ChangeNameAsync(token, dto);
                if (result.IsSuccess)
                {
                    User = User with { Name = NewName };
                    _authService.Login(new LoginResponseDto(User, _authService.Token, await SecureStorage.GetAsync("RefreshToken")));
                    _preferencesService.SetString("DisplayName", NewName);
                    await ToastAsync("Name changed successfully.");
                    await CancelChangeNameAsync();
                    await _realtimeUpdatesService.NotifyUserNameChangedAsync(new UserNameChangedDto
                    {
                        UserId = User.Id,
                        NewName = NewName
                    });
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Unable to change name.");
                }
            }
            catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
            {
                if (await TryRefreshTokenAsync())
                {
                    token = "Bearer " + _authService.Token;
                    var result = await _userApi.ChangeNameAsync(token, dto);
                    if (result.IsSuccess)
                    {
                        User = User with { Name = NewName };
                        _authService.Login(new LoginResponseDto(User, _authService.Token, await SecureStorage.GetAsync("RefreshToken")));
                        _preferencesService.SetString("DisplayName", NewName);
                        await ToastAsync("Name changed successfully.");
                        await CancelChangeNameAsync();
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Unable to change name.");
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
            await ShowErrorAlertAsync("Cropped image is invalid or does not exist.");
            return;
        }

        var confirm = await Shell.Current.DisplayAlert("Confirm", "Use this image as your new profile picture?", "Yes", "No");
        if (!confirm)
        {
            try
            {
                File.Delete(newValue);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unable to delete temporary file: {ex.Message}");
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
                        Console.WriteLine($"Unable to delete temporary file: {ex.Message}");
                    }
                }
                catch (ApiException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
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
                            Console.WriteLine($"Unable to delete temporary file: {ex.Message}");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Unable to upload image: {ex.Message}");
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
        OnPropertyChanged(nameof(PostModel.IsLikeIcon));
        OnPropertyChanged(nameof(PostModel.IsBookmarkIcon));
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