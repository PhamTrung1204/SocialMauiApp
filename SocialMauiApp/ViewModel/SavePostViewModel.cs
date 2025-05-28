using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Maui.Media;
using Microsoft.Maui.Devices;
using Microsoft.Maui.Dispatching;
using SocialMediaMaui.Shared.Hubs;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(Post), nameof(Post))]
    public partial class SavePostViewModel : BaseViewModel
    {
        private readonly IPostApi _postApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly AuthService _authService;
        private string? _existingPhotoUrl;

        public SavePostViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService)
        {
            _postApi = postApi;
            _realtimeUpdatesService = realtimeUpdatesService;
            _authService = authService;
        }

        [ObservableProperty]
        private PostModel? _post;

        [ObservableProperty]
        private string _content = string.Empty;

        [ObservableProperty]
        private string _photoPath = string.Empty;

        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            if (IsBusy) return;
            IsBusy = true;
            try
            {
                PermissionStatus permissionStatus = DeviceInfo.Platform == DevicePlatform.Android
                    ? await Permissions.RequestAsync<Permissions.StorageRead>()
                    : await Permissions.RequestAsync<Permissions.Photos>();

                if (permissionStatus != PermissionStatus.Granted)
                {
                    await ToastAsync("Photo access not granted");
                    return;
                }

                const string pickFromDevice = "Pick From Device";
                const string capturePhoto = "Capture Photo";

                string action = await Shell.Current.DisplayActionSheet("Choose photo", "Cancel", null, pickFromDevice, capturePhoto);
                if (string.IsNullOrWhiteSpace(action) || action == "Cancel")
                    return;

                if (action == pickFromDevice)
                {
                    await PickFromDeviceAsync();
                }
                else if (action == capturePhoto)
                {
                    await CapturePhotoAsync();
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    OnPropertyChanged(nameof(PhotoPath));
                });
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error selecting photo: {ex.Message} at 04:04 PM +07, 28/05/2025.");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private async Task PickFromDeviceAsync()
        {
            Console.WriteLine("Picking photo from device at 04:04 PM +07, 28/05/2025...");
            FileResult? fileResult = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions { Title = "Select Photo" });
            if (fileResult is null)
            {
                Console.WriteLine("No photo selected at 04:04 PM +07, 28/05/2025.");
                await ToastAsync("No photo selected");
                return;
            }

            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

            using var stream = await fileResult.OpenReadAsync();
            using var fileStream = File.Create(tempFile);
            await stream.CopyToAsync(fileStream);

            Console.WriteLine($"[PickFromDeviceAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)} at 04:04 PM +07, 28/05/2025.");
            PhotoPath = tempFile;
        }

        private async Task CapturePhotoAsync()
        {
            Console.WriteLine("Capturing photo at 04:04 PM +07, 28/05/2025...");
            FileResult? fileResult = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions { Title = "Take Photo" });
            if (fileResult is null)
            {
                Console.WriteLine("No photo captured at 04:04 PM +07, 28/05/2025.");
                await ToastAsync("No photo captured");
                return;
            }

            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

            using var stream = await fileResult.OpenReadAsync();
            using var fileStream = File.Create(tempFile);
            await stream.CopyToAsync(fileStream);

            Console.WriteLine($"[CapturePhotoAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)} at 04:04 PM +07, 28/05/2025.");
            PhotoPath = tempFile;
        }

        [RelayCommand]
        private async Task RemovePhoto()
        {
            await MainThread.InvokeOnMainThreadAsync(() =>
            {
                PhotoPath = string.Empty;
                OnPropertyChanged(nameof(PhotoPath));
            });
        }

        [RelayCommand]
        private async Task SavePostAsync()
        {
            if (IsBusy) return;
            IsBusy = true;
            try
            {
                if (string.IsNullOrWhiteSpace(Content) && string.IsNullOrWhiteSpace(PhotoPath))
                {
                    await ToastAsync("Either content or photo is required");
                    return;
                }

                var originalLikeCount = Post?.LikeCount ?? 0;
                var originalCommentCount = Post?.CommentCount ?? 0;
                var originalIsLiked = Post?.IsLiked ?? false;
                var originalIsBookmarked = Post?.IsBookmarked ?? false;

                await MakeApiCall(async () =>
                {
                    StreamPart? photoStreamPart = null;
                    if (!string.IsNullOrWhiteSpace(PhotoPath) && File.Exists(PhotoPath) && !PhotoPath.StartsWith("http", StringComparison.OrdinalIgnoreCase))
                    {
                        var fileName = Path.GetFileName(PhotoPath);
                        using var fileStream = File.OpenRead(PhotoPath);
                        var memoryStream = new MemoryStream();
                        await fileStream.CopyToAsync(memoryStream);
                        memoryStream.Position = 0;
                        photoStreamPart = new StreamPart(memoryStream, fileName, "image/jpeg");
                    }

                    var dto = new SavePostDto
                    {
                        Content = Content,
                        PostId = Post?.PostId ?? default,
                        IsExistingPhotoRemoved = string.IsNullOrWhiteSpace(PhotoPath) && !string.IsNullOrWhiteSpace(_existingPhotoUrl)
                    };

                    var serializedDto = JsonSerializer.Serialize(dto);
                    var result = await _postApi.SavePostAsync(photoStreamPart, serializedDto);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    var saved = new PostModel(_postApi, _realtimeUpdatesService)
                    {
                        PostId = result.Data.PostId,
                        Content = result.Data.Content,
                        PhotoUrl = result.Data.PhotoUrl,
                        UserId = _authService.User?.Id ?? result.Data.UserId,
                        UserName = _authService.User?.Name ?? result.Data.UserName ?? "Unknown",
                        UserPhotoUrl = _authService.User?.PhotoUrl ?? result.Data.UserPhotoUrl ?? "default_avatar.png",
                        LikeCount = originalLikeCount,
                        CommentCount = originalCommentCount,
                        IsLiked = originalIsLiked,
                        IsBookmarked = originalIsBookmarked,
                        PostedOnDisplay = result.Data.PostedOnDisplay ?? Post?.PostedOnDisplay ?? DateTime.UtcNow.ToString("g")
                    };
                    saved.NotifyIsLikeIconChanged();
                    saved.NotifyIsBookmarkIconChanged();

                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        Content = string.Empty;
                        PhotoPath = string.IsNullOrWhiteSpace(saved.PhotoUrl) ? string.Empty : saved.PhotoUrl;
                        Post = saved;
                        OnPropertyChanged(nameof(Content));
                        OnPropertyChanged(nameof(PhotoPath));
                        OnPropertyChanged(nameof(Post));
                    });

                    try
                    {
                        if (Post?.PostId == default)
                        {
                            await _realtimeUpdatesService.NotifyPostAddedAsync(result.Data);
                            Console.WriteLine($"Notified PostAdded for post {saved.PostId} at 04:04 PM +07, 28/05/2025.");
                        }
                        else
                        {
                            await _realtimeUpdatesService.NotifyPostChangedAsync(result.Data);
                            Console.WriteLine($"Notified PostChanged for post {saved.PostId} at 04:04 PM +07, 28/05/2025.");
                        }

                        if (_authService.User?.PhotoUrl != saved.UserPhotoUrl)
                        {
                            var userPhotoDto = new UserPhotoChangedDto
                            {
                                UserId = saved.UserId,
                                PhotoUrl = saved.UserPhotoUrl
                            };
                            await _realtimeUpdatesService.NotifyUserPhotoChangedAsync(userPhotoDto);
                        }
                    }
                    catch (Exception signalREx)
                    {
                        Console.WriteLine($"SignalR error: {signalREx.Message} at 04:04 PM +07, 28/05/2025.");
                    }

                    try
                    {
                        if (Post != null && Post.PostId != default)
                        {
                            Console.WriteLine($"Navigating back with updated post {saved.PostId} at 04:04 PM +07, 28/05/2025.");
                            await NavigateAsync("..", new Dictionary<string, object> { [nameof(DetailsViewModel.Post)] = saved });
                        }
                        else
                        {
                            Console.WriteLine($"Navigating to HomePage with new post {saved.PostId} at 04:04 PM +07, 28/05/2025.");
                            // Kiểm tra xem HomePage đã có trong navigation stack chưa
                            if (Shell.Current.Navigation.NavigationStack.Any(page => page.GetType().Name == "HomePage"))
                            {
                                // Pop về HomePage và truyền newPost
                                await Shell.Current.Navigation.PopToRootAsync();
                                await NavigateAsync("//HomePage", new Dictionary<string, object> { ["newPost"] = saved });
                            }
                            else
                            {
                                // Điều hướng mới đến HomePage
                                await NavigateAsync("//HomePage", new Dictionary<string, object> { ["newPost"] = saved });
                            }
                        }
                    }
                    catch (Exception navEx)
                    {
                        Console.WriteLine($"Navigation error: {navEx.Message} at 04:04 PM +07, 28/05/2025.");
                        await ShowErrorAlertAsync($"Navigation failed: {navEx.Message}");
                    }
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving post: {ex.Message} at 04:04 PM +07, 28/05/2025.");
                await ShowErrorAlertAsync($"Error: {ex.Message}");
            }
            finally
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    IsBusy = false;
                    OnPropertyChanged(nameof(IsBusy));
                });
            }
        }

        partial void OnPostChanged(PostModel? value)
        {
            if (value is not null)
            {
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    Content = value.Content ?? string.Empty;
                    PhotoPath = value.PhotoUrl ?? string.Empty;
                    _existingPhotoUrl = value.PhotoUrl;
                    OnPropertyChanged(nameof(Content));
                    OnPropertyChanged(nameof(PhotoPath));
                });
            }
        }
    }
}