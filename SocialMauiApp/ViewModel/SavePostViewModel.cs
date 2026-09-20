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
        private string? _existingVideoUrl;

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
        [NotifyPropertyChangedFor(nameof(HasPhoto))]
        private string _photoPath = string.Empty;

        [ObservableProperty]
        [NotifyPropertyChangedFor(nameof(HasVideo))]
        private string _videoPath = string.Empty;

        public bool HasPhoto => !string.IsNullOrWhiteSpace(PhotoPath);

        public bool HasVideo => !string.IsNullOrWhiteSpace(VideoPath);

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
                await ToastAsync($"Error selecting photo: {ex.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private async Task PickFromDeviceAsync()
        {
            Console.WriteLine($"Picking photo from device at {DateTime.Now:HH:mm:ss} +07, 31/05/2025...");
            FileResult? fileResult = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions { Title = "Select Photo" });
            if (fileResult is null)
            {
                Console.WriteLine($"No photo selected at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                await ToastAsync("No photo selected");
                return;
            }

            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

            using var stream = await fileResult.OpenReadAsync();
            using var fileStream = File.Create(tempFile);
            await stream.CopyToAsync(fileStream);

            Console.WriteLine($"[PickFromDeviceAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
            VideoPath = string.Empty;
            PhotoPath = tempFile;
        }

        private async Task CapturePhotoAsync()
        {
            Console.WriteLine($"Capturing photo at {DateTime.Now:HH:mm:ss} +07, 31/05/2025...");
            FileResult? fileResult = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions { Title = "Take Photo" });
            if (fileResult is null)
            {
                Console.WriteLine($"No photo captured at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                await ToastAsync("No photo captured");
                return;
            }

            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

            using var stream = await fileResult.OpenReadAsync();
            using var fileStream = File.Create(tempFile);
            await stream.CopyToAsync(fileStream);

            Console.WriteLine($"[CapturePhotoAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
            VideoPath = string.Empty;
            PhotoPath = tempFile;
        }

        [RelayCommand]
        private async Task SelectVideoAsync()
        {
            if (IsBusy) return;
            IsBusy = true;
            try
            {
                var fileResult = await MediaPicker.Default.PickVideoAsync(new MediaPickerOptions { Title = LocalizationService.Instance.Get("Post_SelectVideoTitle") });
                if (fileResult is null)
                {
                    await ToastAsync(LocalizationService.Instance.Get("Post_NoVideoSelected"));
                    return;
                }

                var fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.mp4" : fileResult.FileName;
                var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

                using (var stream = await fileResult.OpenReadAsync())
                using (var fileStream = File.Create(tempFile))
                {
                    await stream.CopyToAsync(fileStream);
                }

                var sizeInMb = new FileInfo(tempFile).Length / (1024d * 1024d);
                if (sizeInMb > 60)
                {
                    File.Delete(tempFile);
                    await ToastAsync(LocalizationService.Instance.Format("Post_VideoTooLarge", sizeInMb.ToString("F1")));
                    return;
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    // Một bài viết chỉ mang một loại media.
                    PhotoPath = string.Empty;
                    VideoPath = tempFile;
                });
            }
            catch (Exception ex)
            {
                await ToastAsync(LocalizationService.Instance.Format("Post_VideoPickError", ex.Message));
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task RemoveVideo()
        {
            await MainThread.InvokeOnMainThreadAsync(() => VideoPath = string.Empty);
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
                if (string.IsNullOrWhiteSpace(Content) && !HasPhoto && !HasVideo)
                {
                    await ToastAsync(LocalizationService.Instance.Get("Post_NeedContent"));
                    return;
                }

                var originalLikeCount = Post?.LikeCount ?? 0;
                var originalCommentCount = Post?.CommentCount ?? 0;
                var originalIsLiked = Post?.IsLiked ?? false;
                var originalIsBookmarked = Post?.IsBookmarked ?? false;

                await MakeApiCall(async () =>
                {
                    var photoStreamPart = await BuildStreamPartAsync(PhotoPath, "image/jpeg");
                    var videoStreamPart = await BuildStreamPartAsync(VideoPath, ContentTypeForVideo(VideoPath));

                    var dto = new SavePostDto
                    {
                        Content = Content,
                        PostId = Post?.PostId ?? default,
                        IsExistingPhotoRemoved = !HasPhoto && !string.IsNullOrWhiteSpace(_existingPhotoUrl),
                        IsExistingVideoRemoved = !HasVideo && !string.IsNullOrWhiteSpace(_existingVideoUrl)
                    };

                    var serializedDto = JsonSerializer.Serialize(dto);
                    var result = await _postApi.SavePostAsync(photoStreamPart, videoStreamPart, serializedDto);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    var saved = new PostModel(_postApi, _realtimeUpdatesService, _authService)
                    {
                        PostId = result.Data.PostId,
                        Content = result.Data.Content,
                        PhotoUrl = result.Data.PhotoUrl,
                        VideoUrl = result.Data.VideoUrl,
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

                    // Notify SignalR first to ensure the HomePage receives the update
                    try
                    {
                        await _realtimeUpdatesService.EnsureConnectedAsync();
                        if (Post?.PostId == default)
                        {
                            await _realtimeUpdatesService.NotifyPostAddedAsync(result.Data);
                            Console.WriteLine($"Notified PostAdded for post {saved.PostId} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                        }
                        else
                        {
                            await _realtimeUpdatesService.NotifyPostChangedAsync(result.Data);
                            Console.WriteLine($"Notified PostChanged for post {saved.PostId} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
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
                        Console.WriteLine($"SignalR error: {signalREx.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                    }

                    // Update UI after SignalR notification
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        Content = string.Empty;
                        PhotoPath = string.IsNullOrWhiteSpace(saved.PhotoUrl) ? string.Empty : saved.PhotoUrl;
                        VideoPath = string.IsNullOrWhiteSpace(saved.VideoUrl) ? string.Empty : saved.VideoUrl;
                        Post = saved;
                        OnPropertyChanged(nameof(Content));
                        OnPropertyChanged(nameof(PhotoPath));
                        OnPropertyChanged(nameof(Post));
                    });

                    // Navigate after notifying to ensure HomePage is ready
                    try
                    {
                        if (Post != null && Post.PostId != default)
                        {
                            Console.WriteLine($"Navigating back with updated post {saved.PostId} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                            await NavigateAsync("..", new Dictionary<string, object> { [nameof(DetailsViewModel.Post)] = saved });
                        }
                        else
                        {
                            Console.WriteLine($"Navigating to HomePage with new post {saved.PostId} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                            await Shell.Current.Navigation.PopToRootAsync();
                            await NavigateAsync("//HomePage", new Dictionary<string, object> { ["newPost"] = saved });
                        }
                    }
                    catch (Exception navEx)
                    {
                        Console.WriteLine($"Navigation error: {navEx.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                        await ShowErrorAlertAsync($"Navigation failed: {navEx.Message}");
                    }
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving post: {ex.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
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

        private async Task<StreamPart?> BuildStreamPartAsync(string path, string contentType)
        {
            // Đường dẫn http là media đã có sẵn trên server -> không upload lại.
            if (string.IsNullOrWhiteSpace(path)
                || path.StartsWith("http", StringComparison.OrdinalIgnoreCase)
                || !File.Exists(path))
            {
                return null;
            }

            var memoryStream = new MemoryStream();
            await using (var fileStream = File.OpenRead(path))
            {
                await fileStream.CopyToAsync(memoryStream);
            }
            memoryStream.Position = 0;
            return new StreamPart(memoryStream, Path.GetFileName(path), contentType);
        }

        private string ContentTypeForVideo(string path) =>
            Path.GetExtension(path).ToLowerInvariant() switch
            {
                ".webm" => "video/webm",
                ".mov" => "video/quicktime",
                _ => "video/mp4"
            };

        partial void OnPostChanged(PostModel? value)
        {
            if (value is not null)
            {
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    Content = value.Content ?? string.Empty;
                    PhotoPath = value.PhotoUrl ?? string.Empty;
                    VideoPath = value.VideoUrl ?? string.Empty;
                    _existingPhotoUrl = value.PhotoUrl;
                    _existingVideoUrl = value.VideoUrl;
                    OnPropertyChanged(nameof(Content));
                    OnPropertyChanged(nameof(PhotoPath));
                    OnPropertyChanged(nameof(VideoPath));
                });
            }
        }
    }
}