using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Text.Json;

namespace SocialMauiApp.ViewModel
{
    public partial class LoginViewModel : BaseViewModel
    {
        private readonly IAuthApi _authApi;
        private readonly AuthService _authService;

        public LoginViewModel(IAuthApi authApi, AuthService authService)
        {
            _authApi = authApi;
            _authService = authService;
            _ = CheckBiometricAvailabilityAsync();
        }

        [ObservableProperty]
        private string _email;
        [ObservableProperty]
        private string _password;
        [ObservableProperty]
        private bool _isBiometricAvailable;
        [RelayCommand]
        private async Task LoginAsync()
        {
            if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
            {
                await ToastAsync("All fields are required");
                return;
            }

            await MakeApiCall(async () =>
            {

                var loginDto = new LoginDto(Email, Password);
                var result = await _authApi.LoginAsync(loginDto);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
                LoginResponseDto loginResponse = result.Data;
                _authService.Login(loginResponse);
                await NavigateAsync($"//{nameof(HomePage)}");
            });
        }
        private async Task CheckBiometricAvailabilityAsync()
        {
            var res = await CrossFingerprint.Current.IsAvailableAsync(true);
            IsBiometricAvailable = res;
        }

        [RelayCommand]
        private async Task BiometricLoginAsync()
        {
            // gọi dialog hệ thống
            var authConfig = new AuthenticationRequestConfiguration(
                "Xác thực",
                "Xác thực vân tay/Face ID để đăng nhập")
            {
                CancelTitle = "Huỷ",
                FallbackTitle = "Mật khẩu"
            };

            var result = await CrossFingerprint.Current.AuthenticateAsync(authConfig);
            if (!result.Authenticated)
            {
                await ToastAsync("Không thể xác thực sinh trắc học");
                return;
            }

            // lấy lại token & user từ SecureStorage
            try
            {
                var token = await SecureStorage.GetAsync("auth_token");
                var userJson = await SecureStorage.GetAsync("auth_user");
                if (string.IsNullOrEmpty(token) || string.IsNullOrEmpty(userJson))
                {
                    await ToastAsync("Chưa có thông tin đăng nhập trước đó");
                    return;
                }

                var user = JsonSerializer.Deserialize<LoggedInUser>(userJson);
                if (user is null)
                {
                    await ToastAsync("Lỗi dữ liệu người dùng");
                    return;
                }

                // Tạo đúng thứ tự: (User, Token)
                var loginResponse = new LoginResponseDto(user, token);

                // Đẩy vào AuthService và chuyển trang
                _authService.Login(loginResponse);
                await NavigateAsync($"//{nameof(HomePage)}");
            }
            catch (Exception)
            {
                await ToastAsync("Lỗi khi đọc thông tin đăng nhập");
            }
        }
    }
}
