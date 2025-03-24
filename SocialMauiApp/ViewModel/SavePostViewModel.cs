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

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(Post), nameof(Post))]
    public partial class SavePostViewModel : BaseViewModel
    {
        private readonly IPostApi _postApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        public SavePostViewModel(IPostApi postApi)
        {
            _postApi = postApi;
        }

        [ObservableProperty]
        private PostModel? _post;

        [ObservableProperty]
        private string _content = string.Empty;

        [ObservableProperty]
        private string _photoPath = string.Empty;

        // Lưu lại đường dẫn ảnh cũ để so sánh khi lưu bài đăng (nếu cần)
        private string? _existingPhotoUrl;

        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            if (IsBusy) return;
            IsBusy = true;
            try
            {
                // Yêu cầu quyền truy cập ảnh
                PermissionStatus permissionStatus = PermissionStatus.Unknown;
                if (DeviceInfo.Platform == DevicePlatform.Android)
                {
                    permissionStatus = await Permissions.RequestAsync<Permissions.StorageRead>();
                }
                else
                {
                    permissionStatus = await Permissions.RequestAsync<Permissions.Photos>();
                }
                if (permissionStatus != PermissionStatus.Granted)
                {
                    await ToastAsync("Quyền truy cập ảnh không được cấp");
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
            }
            finally
            {
                IsBusy = false;
            }
        }

        private async Task PickFromDeviceAsync()
        {
            Console.WriteLine("Picking photo from device...");
            FileResult? fileResult = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions { Title = "Select Photo" });
            if (fileResult is null)
            {
                Console.WriteLine("No photo selected.");
                await ToastAsync("No photo selected");
                return;
            }
            // Nếu fileResult.FileName trống, tạo tên file mới dựa trên GUID
            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            using var stream = await fileResult.OpenReadAsync();
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);
            using (var fileStream = File.Create(tempFile))
            {
                await stream.CopyToAsync(fileStream);
            }
            Console.WriteLine($"[PickFromDeviceAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)}");
            PhotoPath = tempFile;
        }

        private async Task CapturePhotoAsync()
        {
            Console.WriteLine("Capturing photo...");
            FileResult? fileResult = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions { Title = "Take Photo" });
            if (fileResult is null)
            {
                Console.WriteLine("No photo captured.");
                await ToastAsync("No photo captured");
                return;
            }
            string fileName = string.IsNullOrWhiteSpace(fileResult.FileName) ? $"{Guid.NewGuid()}.jpg" : fileResult.FileName;
            using var stream = await fileResult.OpenReadAsync();
            var tempFile = Path.Combine(FileSystem.CacheDirectory, fileName);
            using (var fileStream = File.Create(tempFile))
            {
                await stream.CopyToAsync(fileStream);
            }
            Console.WriteLine($"[CapturePhotoAsync] File saved at: {tempFile}, exists: {File.Exists(tempFile)}");
            PhotoPath = tempFile;
        }

        [RelayCommand]
        private void RemovePhoto()
        {
            PhotoPath = string.Empty;
        }

        [RelayCommand]
        private async Task SavePostAsync()
        {
            if (IsBusy) return;
            IsBusy = true;
            try
            {
                // Kiểm tra nội dung và ảnh hợp lệ
                if (string.IsNullOrWhiteSpace(Content) && string.IsNullOrWhiteSpace(PhotoPath))
                {
                    await ToastAsync("Either content or photo is required");
                    return;
                }

                await MakeApiCall(async () =>
                {
                    // Xử lý ảnh nếu có (tạo StreamPart)
                    StreamPart? photoStreamPart = null;
                    if (!string.IsNullOrWhiteSpace(PhotoPath) && File.Exists(PhotoPath) && _existingPhotoUrl != PhotoPath)
                    {
                        var fileName = Path.GetFileName(PhotoPath);
                        var fileStream = File.OpenRead(PhotoPath);
                        photoStreamPart = new StreamPart(fileStream, fileName);
                    }

                    var dto = new SavePostDto
                    {
                        Content = Content,
                        PostId = Post?.PostId ?? default
                    };

                    // Nếu không có ảnh mới nhưng trước đó có ảnh thì đánh dấu ảnh cũ đã bị loại bỏ
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

                    var savedPost = PostModel.FromDto(result.Data, _postApi, _realtimeUpdatesService);
                    Content = string.Empty;
                    PhotoPath = !string.IsNullOrWhiteSpace(savedPost.PhotoUrl) ? savedPost.PhotoUrl : string.Empty;

                    // Phân biệt giữa sửa bài và đăng bài mới
                    if (Post != null && Post.PostId != default)
                    {
                        // Trường hợp sửa bài: quay lại trang DetailPostPage
                        await NavigateAsync("..", new Dictionary<string, object>
                        {
                            [nameof(DetailsViewModel.Post)] = savedPost
                        });
                    }
                    else
                    {
                        // Trường hợp đăng bài mới: điều hướng về HomePage kèm bài đăng mới
                        await NavigateAsync("//HomePage", new Dictionary<string, object>
                        {
                            ["newPost"] = savedPost
                        });
                    }
                });
            }
            finally
            {
                IsBusy = false;
            }
        }

        partial void OnPostChanged(PostModel? value)
        {
            if (value is not null)
            {
                Content = value.Content ?? string.Empty;
                PhotoPath = value.PhotoUrl ?? string.Empty;
                _existingPhotoUrl = value.PhotoUrl;
            }
        }
    }
}
