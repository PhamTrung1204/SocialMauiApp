using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Maui.Media;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Devices;

namespace SocialMauiApp.ViewModel
{
    public partial class RegisterViewModel : BaseViewModel
    {
        private readonly IAuthApi _authApi;

        public RegisterViewModel(IAuthApi authApi)
        {
            _authApi = authApi;
            CheckNavigationParameters();
        }

        public async void CheckNavigationParameters()
        {
            if (Shell.Current?.CurrentPage is RegisterPage registerPage)
            {
                var parameters = registerPage.Parameters;
                if (parameters != null && parameters.TryGetValue("ShowSuccessMessage", out object value) && value is bool showSuccess && showSuccess)
                {
                    await ShowSuccessAndNavigateToLogin();
                }
            }
        }

        [ObservableProperty] private string _username;
        [ObservableProperty] private string _email;
        [ObservableProperty] private string _password;
        [ObservableProperty] private string _repeatPassword;
        [ObservableProperty] private string _photoImageSource = "user.png";

        [RelayCommand]
        public async Task ShowSuccessAndNavigateToLogin()
        {
            try
            {
                if (Application.Current?.MainPage != null)
                {
                    await Application.Current.MainPage.DisplayAlert("Success", "Registration successful! You will be redirected to the login page.", "OK");
                    await NavigateAsync($"//{nameof(LoginPage)}");
                }
                else
                {
                    Console.WriteLine("MainPage is not available for navigation.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in ShowSuccessAndNavigateToLogin: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task RegisterAsync()
        {
            if (string.IsNullOrWhiteSpace(Username) || string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password) || string.IsNullOrWhiteSpace(RepeatPassword))
            {
                await ToastAsync("Please fill in all information");
                return;
            }

            if (!IsValidGmail(Email))
            {
                await ShowErrorAlertAsync("Please use a Gmail address.");
                return;
            }

            if (Password != RepeatPassword)
            {
                await ShowErrorAlertAsync("Passwords do not match");
                return;
            }

            await MakeApiCall(async () =>
            {
                var registerDto = new RegisterDto(Username, Email, Password, RepeatPassword);
                var result = await _authApi.RegisterAsync(registerDto);

                if (!result.IsSuccess)
                {
                    if (result.Error == "Email already exists and is verified. Please log in or use a different email.")
                    {
                        bool openEmail = await Application.Current.MainPage.DisplayAlert(
                            "Email Already Exists",
                            result.Error,
                            "OK",
                            "Cancel");

                        if (openEmail)
                        {
                            await OpenEmailClientAsync(Email);
                            await NavigateAsync($"//{nameof(LoginPage)}");
                        }
                    }
                    else if (result.Error.StartsWith("Email already exists but not verified"))
                    {
                        await Application.Current.MainPage.DisplayAlert(
                            "Verification Required",
                            result.Error,
                            "OK");

                        await OpenEmailClientAsync(Email);
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Registration failed");
                    }
                    return;
                }

                var userId = result.Data;
                if (!string.IsNullOrWhiteSpace(PhotoImageSource) && PhotoImageSource != "user.png")
                {
                    var photoName = Path.GetFileName(PhotoImageSource);
                    using var fs = File.OpenRead(PhotoImageSource);
                    var photoStreamPart = new StreamPart(fs, photoName);
                    var apiResult = await _authApi.UploadPhotoAsync(userId, photoStreamPart);

                    if (!apiResult.IsSuccess)
                    {
                        await ToastAsync("Photo upload failed");
                        return;
                    }
                }

                var sendVerificationDto = new SendVerificationEmailDto { Email = Email };
                var verificationResult = await _authApi.SendVerificationEmailAsync(sendVerificationDto);
                if (verificationResult.IsSuccess)
                {
                    bool openEmail = await Application.Current.MainPage.DisplayAlert(
                        "Registration Successful",
                        $"A verification email has been sent to {Email}. Please check your inbox to verify your account.",
                        "OK",
                        "Cancel");

                    if (openEmail)
                    {
                        await OpenEmailClientAsync(Email);
                    }
                }
                else
                {
                    await ShowErrorAlertAsync(verificationResult.Error ?? "Failed to send verification email");
                }
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
                        await ToastAsync("Failed to save photo. Please try again.");
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
                await ToastAsync("Device does not support taking photos");
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

        private bool IsValidGmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;
            return email.ToLower().EndsWith("@gmail.com") && new System.Net.Mail.MailAddress(email).Address == email;
        }

        private async Task OpenEmailClientAsync(string email)
        {
            try
            {
                var gmailUri = new Uri("googlegmail:///");
                var mailtoUri = new Uri($"mailto:{email}");

                if (DeviceInfo.Platform == DevicePlatform.Android)
                {
                    try
                    {
                        await Launcher.OpenAsync(gmailUri);
                    }
                    catch
                    {
                        await Launcher.OpenAsync(mailtoUri);
                    }
                }
                else
                {
                    await Launcher.OpenAsync(mailtoUri);
                }
            }
            catch (Exception ex)
            {
                await ToastAsync("Unable to open email app. Please open Gmail manually.");
                Console.WriteLine($"Error opening email client: {ex.Message}");
            }
        }
    }

  
}