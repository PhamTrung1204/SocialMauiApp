using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(Post),nameof(Post))]
    public partial class SavePostViewModel : BaseViewModel
    {
        private readonly IPostApi _postApi;
        public SavePostViewModel(IPostApi postApi)
        {
            _postApi = postApi;
        }
        [ObservableProperty]
        private string _content = string.Empty;
        [ObservableProperty]
        private string _photoPath = string.Empty;
        private string? _existingPhotoUrl;
        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            var selectPhotoSource = await ChoosePhotoAsync();
            if (!string.IsNullOrWhiteSpace(selectPhotoSource))
            {
                PhotoPath = selectPhotoSource;
            }

            if (MediaPicker.Default.IsCaptureSupported)
            {
                const string PickFromDevice = "Pick From Device";
                const string CapturePhoto = "Capture Photo";

                var result = await Shell.Current.DisplayActionSheet("Choose photo", "Cancel", null, PickFromDevice, CapturePhoto);
                Console.WriteLine("User selected: " + result);

                if (string.IsNullOrWhiteSpace(result)) return;

                switch (result)
                {
                    case PickFromDevice:
                        await PickFromDeviceAsync();
                        break;
                    case CapturePhoto:
                        await CapturePhotoAsync();
                        break;
                }
                async Task PickFromDeviceAsync()
                {
                    Console.WriteLine("Picking photo from device...");
                    FileResult? fileResult = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions
                    {
                        Title = "Select Photo"
                    });

                    if (fileResult is null)
                    {
                        Console.WriteLine("No photo selected.");
                        await ToastAsync("No photo selected");
                        return;
                    }

                    using var stream = await fileResult.OpenReadAsync();
                    // Upload stream hoặc lưu vào bộ nhớ tạm nếu cần
                    // Ví dụ: lưu tạm file để sau này upload:
                    var tempFile = Path.Combine(FileSystem.CacheDirectory, fileResult.FileName);
                    using (var fileStream = File.Create(tempFile))
                    {
                        await stream.CopyToAsync(fileStream);
                    }
                    PhotoPath = tempFile; // Gán đường dẫn tạm đã lưu
                }

                async Task CapturePhotoAsync()
                {
                    Console.WriteLine("Capturing photo...");

                    FileResult? fileResult = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions
                    {
                        Title = "Take Photo"
                    });

                    if (fileResult is null)
                    {
                        Console.WriteLine("No photo captured.");
                        await ToastAsync("No photo captured");
                        return;
                    }
                    Console.WriteLine("Photo captured: " + fileResult.FullPath);
                    using var stream = await fileResult.OpenReadAsync();
                    var tempFile = Path.Combine(FileSystem.CacheDirectory, fileResult.FileName);
                    using (var fileStream = File.Create(tempFile))
                    {
                        await stream.CopyToAsync(fileStream);
                    }
                    PhotoPath = tempFile;
                }
            }
        }
        [RelayCommand]
        private void RemovePhoto()
        {
            PhotoPath = "";
        }
        [RelayCommand]
        private async Task SavePostAsync()
        {
            if (IsBusy)
                return;

            IsBusy = true;
            try
            {
                Console.WriteLine("SavePostAsync called.");

                if (string.IsNullOrWhiteSpace(Content) && string.IsNullOrWhiteSpace(PhotoPath))
                {
                    Console.WriteLine("Validation failed: No content or photo.");
                    await ToastAsync("Either content or photo is required");
                    return;
                }

                await MakeApiCall(async () =>
                {
                    StreamPart? photoStreamPart = null;
                    if (!string.IsNullOrWhiteSpace(PhotoPath)&&_existingPhotoUrl != PhotoPath)
                    {
                        Console.WriteLine("Processing photo: " + PhotoPath);
                        var fileName = Path.GetFileName(PhotoPath);
                        var fileBytes = File.OpenRead(PhotoPath);
                        photoStreamPart = new StreamPart(fileBytes, fileName);
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

                    var serializedSavePostDto = JsonSerializer.Serialize(dto);
                    Console.WriteLine("Serialized DTO: " + serializedSavePostDto);

                    var result = await _postApi.SavePostAsync(photoStreamPart, serializedSavePostDto);

                    if (!result.IsSuccess)
                    {
                        Console.WriteLine("API call failed: " + result.Error);
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    Console.WriteLine("Post saved successfully!");
                    await ToastAsync("Post saved");

                    Content = "";
                    PhotoPath = ""; 
                    var savedPost = PostModel.FromDto(result.Data, _postApi);
                    await NavigateAsync("..", new Dictionary<string, object> { [nameof(DetailsViewModel.Post)] = savedPost});

                });
            }
            finally
            {
                IsBusy = false;
            }
        }
        [ObservableProperty]
        private PostModel? _post;
        partial void OnPostChanged(PostModel? value)
        {
            if(value is not null)
            {
                Content = Post.Content;
                PhotoPath = Post.PhotoUrl??"";
                _existingPhotoUrl = Post.PhotoUrl;
            }
        }
    }
}
