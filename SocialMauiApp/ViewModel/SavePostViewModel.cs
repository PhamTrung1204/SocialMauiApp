using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Maui.Media;
using Microsoft.Maui.Devices;
using SocialMauiApp.Services;
using Microsoft.Maui.Dispatching;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(Post), nameof(Post))]
    public partial class SavePostViewModel : BaseViewModel
    {
        private readonly IPostApi _postApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private string? _existingPhotoUrl;

        public SavePostViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            _postApi = postApi;
            _realtimeUpdatesService = realtimeUpdatesService;
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

                // Cập nhật UI trên MainThread
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    OnPropertyChanged(nameof(PhotoPath));
                });
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error selecting photo: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private async Task PickFromDeviceAsync()
        {
            Console.WriteLine("Picking photo from device at 12:29 PM +07, 27/05/2025...");
            FileResult? fileResult = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions { Title = "Select Photo" });
            if (fileResult is null)
            {
                Console.WriteLine("No photo selected.");
                await ToastAsync("No photo selected");
                return;
            }

            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

            using var stream = await fileResult.OpenReadAsync();
            using var fileStream = File.Create(tempFile);
            await stream.CopyToAsync(fileStream);

            Console.WriteLine($"[PickFromDeviceAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)}");
            PhotoPath = tempFile;
        }

        private async Task CapturePhotoAsync()
        {
            Console.WriteLine("Capturing photo at 12:29 PM +07, 27/05/2025...");
            FileResult? fileResult = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions { Title = "Take Photo" });
            if (fileResult is null)
            {
                Console.WriteLine("No photo captured.");
                await ToastAsync("No photo captured");
                return;
            }

            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);

            using var stream = await fileResult.OpenReadAsync();
            using var fileStream = File.Create(tempFile);
            await stream.CopyToAsync(fileStream);

            Console.WriteLine($"[CapturePhotoAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)}");
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
                        using var fileStream = File.OpenRead(PhotoPath); // Đảm bảo stream được đóng
                        var memoryStream = new MemoryStream();
                        await fileStream.CopyToAsync(memoryStream);
                        memoryStream.Position = 0;
                        photoStreamPart = new StreamPart(memoryStream, fileName);
                    }

                    var dto = new SavePostDto
                    {
                        Content = Content,
                        PostId = Post?.PostId ?? default
                    };

                    if (string.IsNullOrWhiteSpace(PhotoPath) && !string.IsNullOrWhiteSpace(_existingPhotoUrl))
                    {
                        dto.IsExistingPhotoRemoved = true;
                    }

                    var serializedDto = JsonSerializer.Serialize(dto);
                    var result = await _postApi.SavePostAsync(photoStreamPart, serializedDto);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    var saved = PostModel.FromDto(result.Data, _postApi, _realtimeUpdatesService);
                    saved.LikeCount = originalLikeCount;
                    saved.CommentCount = originalCommentCount;
                    saved.IsLiked = originalIsLiked;
                    saved.IsBookmarked = originalIsBookmarked;
                    saved.NotifyIsLikeIconChanged();
                    saved.NotifyIsBookmarkIconChanged();

                    // Cập nhật UI trên MainThread
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        Content = string.Empty;
                        PhotoPath = string.IsNullOrWhiteSpace(saved.PhotoUrl) ? string.Empty : saved.PhotoUrl;
                        OnPropertyChanged(nameof(Content));
                        OnPropertyChanged(nameof(PhotoPath));
                        Post = saved; // Cập nhật Post để phản ánh trên UI
                        OnPropertyChanged(nameof(Post));
                    });

                    // Định tuyến
                    try
                    {
                        if (Post != null && Post.PostId != default)
                        {
                            Console.WriteLine($"Navigating back with updated post {saved.PostId} at 12:29 PM +07, 27/05/2025.");
                            await NavigateAsync("..", new Dictionary<string, object> { [nameof(DetailsViewModel.Post)] = saved });
                        }
                        else
                        {
                            Console.WriteLine($"Navigating to HomePage with new post {saved.PostId} at 12:29 PM +07, 27/05/2025.");
                            await NavigateAsync("//HomePage", new Dictionary<string, object> { ["newPost"] = saved });
                        }
                    }
                    catch (Exception navEx)
                    {
                        Console.WriteLine($"Navigation error: {navEx.Message} at 12:29 PM +07, 27/05/2025.");
                        await ShowErrorAlertAsync($"Navigation failed: {navEx.Message}");
                    }
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving post: {ex.Message} at 12:29 PM +07, 27/05/2025.");
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