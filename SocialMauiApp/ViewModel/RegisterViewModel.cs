using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Maui.Media;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(CroppedPhotoSource), "new-src")]
    public partial class RegisterViewModel : BaseViewModel
    {
        private readonly IAuthApi _authApi;

        public RegisterViewModel(IAuthApi authApi)
        {
            _authApi = authApi;
        }

        [ObservableProperty] private string _name;
        [ObservableProperty] private string _email;
        [ObservableProperty] private string _password;
        [ObservableProperty] private string _repeatPassword;
        [ObservableProperty] private string _photoImageSource = "user.png";

        [RelayCommand]
        private async Task RegisterAsync()
        {
            if (string.IsNullOrWhiteSpace(Name) || string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password) || string.IsNullOrWhiteSpace(RepeatPassword))
            {
                await ToastAsync("All fields are required");
                return;
            }
            if (Password.ToString() != RepeatPassword.ToString())
            {
                await ShowErrorAlertAsync("Confirmed password incorrect");
                return;
            }
            await MakeApiCall(async () =>
            {
                var registerDto = new RegisterDto(Name, Email, Password, RepeatPassword);
                var result = await _authApi.RegisterAsync(registerDto);
                
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
               

                var userId = result.Data;
                if (!string.IsNullOrWhiteSpace(PhotoImageSource) && PhotoImageSource != "personal.png")
                {
                    var photoName = Path.GetFileName(PhotoImageSource);
                    using var fs = File.OpenRead(PhotoImageSource);
                    var photoStreamPart = new StreamPart(fs, photoName);
                    var apiResult = await _authApi.UploadPhotoAsync(userId, photoStreamPart);

                    if (!apiResult.IsSuccess)
                    {
                        await ToastAsync("Photo upload failed.");
                        return;
                    }
                }

                await ToastAsync("Successfully registered");
                await NavigateAsync($"//{nameof(LoginPage)}");
            });
        }

        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            if (MediaPicker.Default.IsCaptureSupported)
            {
                var photo = await MediaPicker.Default.CapturePhotoAsync();
                if (photo != null)
                {
                    var fileName = $"{Guid.NewGuid()}.jpg";
                    var localPath = Path.Combine(FileSystem.CacheDirectory, fileName);

                    using (var stream = await photo.OpenReadAsync())
                    using (var newStream = File.OpenWrite(localPath))
                    {
                        await stream.CopyToAsync(newStream);
                    }

                    if (!File.Exists(localPath))
                    {
                        await ToastAsync("Không lưu được ảnh. Vui lòng thử lại.");
                        return;
                    }

                    var param = new Dictionary<string, object>
            {
                { "new-src", localPath }
            };

                    await NavigateAsync(nameof(CropPhotoPage), param);
                }
            }
            else
            {
                await ToastAsync("Thiết bị không hỗ trợ chụp ảnh");
            }
        }

        [ObservableProperty] private string? _croppedPhotoSource;

        partial void OnCroppedPhotoSourceChanged(string? value)
        {
            if (!string.IsNullOrWhiteSpace(value))
            {
                PhotoImageSource = value;
            }
        }
    }
}
