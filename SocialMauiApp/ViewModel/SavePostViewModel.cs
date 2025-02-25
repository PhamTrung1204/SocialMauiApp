using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
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
        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            Console.WriteLine("SelectPhotoAsync called.");

            if (!MediaPicker.Default.IsCaptureSupported)
            {
                Console.WriteLine("Camera not supported.");
                await ToastAsync("Camera not supported on this device.");
                return;
            }

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

            Console.WriteLine("Photo selected: " + fileResult.FullPath);
            PhotoPath = fileResult.FullPath;
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
            PhotoPath = fileResult.FullPath;
        }

        [RelayCommand]
        private void RemovePhoto()
        {
            PhotoPath = "";
        }
        [RelayCommand]
        private async Task SavePostAsync()
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

                if (!string.IsNullOrWhiteSpace(PhotoPath))
                {
                    Console.WriteLine("Processing photo: " + PhotoPath);
                    var fileName = Path.GetFileName(PhotoPath);
                    var fileStream = File.OpenRead(PhotoPath);
                    photoStreamPart = new StreamPart(fileStream, fileName);
                }

                var serializedSavePostDto = JsonSerializer.Serialize(new SavePostDto { Content = Content });
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

                await NavigateBackAsync();
            });
        }

    }
}
