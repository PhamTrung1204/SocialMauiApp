using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

using Refit;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;

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
        [ObservableProperty]
        private string _name;
        [ObservableProperty]
        private string _email;
        [ObservableProperty]
        private string _password;
        [RelayCommand]
        private async Task RegisterAsync()
        {
            if (string.IsNullOrWhiteSpace(Name) || string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
            {
                await ToastAsync("All field are required");
                return;
            }

            await MakeApiCall(async () =>
            {
                var registerDto = new RegisterDto(Name, Email, Password);
                var result = await _authApi.RegisterAsync(registerDto);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
                var userId = result.Data;
                if(!string.IsNullOrWhiteSpace(PhotoImageSource)&&PhotoImageSource!="personal.png")
                {
                    var photoName = Path.GetFileName(PhotoImageSource);
                    using var fs = File.OpenRead(PhotoImageSource);
                    var photoStreamPart = new StreamPart(fs, photoName);
                    var apiResult = await _authApi.UploadPhotoAsync(userId, photoStreamPart);
                    if (!result.IsSuccess)
                    {
                        await ToastAsync("Photo upload failed.");
                        return;
                    }
                }
                await ToastAsync($"Successfully registered");
                await NavigateAsync($"//{nameof(LoginPage)}");
            }
            );

        }
        [ObservableProperty]
        private string _photoImageSource = "personal.png";
        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            var selectedPhotoSource = await ChoosePhotoAsync();
            if (!string.IsNullOrWhiteSpace(selectedPhotoSource))
            {
                var param = new Dictionary<string, object>
                {
                    [nameof(CropPhotoPage)] = selectedPhotoSource
                };
                await NavigateAsync(nameof(CropPhotoPage), param);
            }
        }
        [ObservableProperty]
        private string? _croppedPhotoSource;
    }
}