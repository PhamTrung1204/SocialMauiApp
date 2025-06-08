using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Plugin.Fingerprint.Abstractions;
using Plugin.Fingerprint;
using SocialMediaMaui.Shared.Dtos;
using System.Threading.Tasks;
using SocialMauiApp.Services;
using SocialMauiApp.Apis;
using Microsoft.Maui.Storage;

namespace SocialMauiApp.ViewModel
{
    public partial class LoginWithFingerprintViewModel : BaseViewModel
    {
        private readonly IPreferencesService _prefs;
        private readonly IAuthApi _authApi;
        private readonly AuthService _authService;
        private readonly IFingerprint _fingerprint;

        public LoginWithFingerprintViewModel(
            IPreferencesService preferencesService,
            IAuthApi authApi,
            AuthService authService)
        {
            _prefs = preferencesService;
            _authApi = authApi;
            _authService = authService;
            _fingerprint = CrossFingerprint.Current;

            LoadData();
            Task.Run(CheckBiometricAsync);
        }

        [ObservableProperty]
        private string _greetingText;

        [ObservableProperty]
        private string _avatarUrl;

        [ObservableProperty]
        private string _password;

        [ObservableProperty]
        private bool _isBiometricAvailable;

        private void LoadData()
        {
            var name = _prefs.GetString("DisplayName", "");
            GreetingText = $"Welcome, {name}";
            AvatarUrl = _prefs.GetString("AvatarUrl", "user.png");
        }

        private async Task CheckBiometricAsync()
        {
            IsBiometricAvailable = await _fingerprint.IsAvailableAsync();
            // Kiểm tra trạng thái đăng nhập khi khởi động
            await CheckLoginStatusAsync();
        }

        /// <summary>
        /// Kiểm tra trạng thái đăng nhập bằng token đã lưu và làm mới nếu cần.
        /// </summary>
        private async Task CheckLoginStatusAsync()
        {
            var jwt = await SecureStorage.GetAsync("AuthToken");
            if (!string.IsNullOrEmpty(jwt))
            {
                var validateResult = await _authApi.ValidateTokenAsync($"Bearer {jwt}");
                if (validateResult.IsSuccess && validateResult.Data != null)
                {
                    var refreshToken = await SecureStorage.GetAsync("RefreshToken");
                    _authService.Login(new LoginResponseDto(validateResult.Data, jwt, refreshToken));
                    await NavigateAsync($"//{nameof(HomePage)}");
                    return;
                }
                else
                {
                    // Thử làm mới token
                    var refreshToken = await SecureStorage.GetAsync("RefreshToken");
                    if (!string.IsNullOrEmpty(refreshToken))
                    {
                        var refreshResult = await _authApi.RefreshTokenAsync(new RefreshTokenDto { RefreshToken = refreshToken });
                        if (refreshResult.IsSuccess && refreshResult.Data != null)
                        {
                            await SecureStorage.SetAsync("AuthToken", refreshResult.Data.Token);
                            await SecureStorage.SetAsync("RefreshToken", refreshResult.Data.RefreshToken);
                            _authService.Login(refreshResult.Data);
                            await NavigateAsync($"//{nameof(HomePage)}");
                            return;
                        }
                    }
                }
            }
        }

        [RelayCommand]
        private async Task LoginWithPasswordAsync()
        {
            if (string.IsNullOrWhiteSpace(Password))
            {
                await ShowErrorAlertAsync("Please enter password.");
                return;
            }

            var email = _prefs.GetString("LastEmail", "");
            var dto = new LoginDto(email, Password);

            await MakeApiCall(async () =>
            {
                var resp = await _authApi.LoginAsync(dto);
                if (resp.IsSuccess)
                {
                    // Lưu token vào SecureStorage
                    await SecureStorage.SetAsync("AuthToken", resp.Data.Token);
                    await SecureStorage.SetAsync("RefreshToken", resp.Data.RefreshToken);
                    _authService.Login(resp.Data);
                    // Cập nhật thông tin hiển thị
                    _prefs.SetString("DisplayName", resp.Data.User.Name);
                    _prefs.SetString("AvatarUrl", resp.Data.User.PhotoUrl ?? "user.png");
                    await NavigateAsync($"//{nameof(HomePage)}");
                }
                else
                {
                    await ShowErrorAlertAsync("Wrong password.");
                }
            });
        }

        [RelayCommand]
        private async Task LoginWithFingerprintAsync()
        {
            var auth = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
                "Login", "Confirm to login"));
            if (!auth.Authenticated)
            {
                await ShowErrorAlertAsync("Fingerprint authentication failed");
                return;
            }

            var token = await SecureStorage.GetAsync("AuthToken");
            var refreshToken = await SecureStorage.GetAsync("RefreshToken");
            if (string.IsNullOrEmpty(token))
            {
                await ShowErrorAlertAsync("Login session is expired. Please login again.");
                return;
            }

            await MakeApiCall(async () =>
            {
                var resp = await _authApi.ValidateTokenAsync($"Bearer {token}");
                if (resp.IsSuccess && resp.Data != null)
                {
                    _authService.Login(new LoginResponseDto(resp.Data, token, refreshToken));
                    await NavigateAsync($"//{nameof(HomePage)}");
                }
                else
                {
                    // Thử làm mới token
                    if (!string.IsNullOrEmpty(refreshToken))
                    {
                        var refreshResult = await _authApi.RefreshTokenAsync(new RefreshTokenDto { RefreshToken = refreshToken });
                        if (refreshResult.IsSuccess && refreshResult.Data != null)
                        {
                            await SecureStorage.SetAsync("AuthToken", refreshResult.Data.Token);
                            await SecureStorage.SetAsync("RefreshToken", refreshResult.Data.RefreshToken);
                            _authService.Login(refreshResult.Data);
                            await NavigateAsync($"//{nameof(HomePage)}");
                        }
                        else
                        {
                            await ShowErrorAlertAsync("Login session is expired. Please login again.");
                        }
                    }
                    else
                    {
                        await ShowErrorAlertAsync("Login session is expired. Please login again.");
                    }
                }
            });
        }

        [RelayCommand]
        private async Task LoginWithAnotherAsync()
        {
            // Xóa thông tin đăng nhập
            _prefs.SetString("LastEmail", "");
            _prefs.SetString("DisplayName", "");
            _prefs.SetString("AvatarUrl", "default_avatar.png");
            SecureStorage.Remove("AuthToken");
            SecureStorage.Remove("RefreshToken");
            _authService.Logout();
            await NavigateAsync($"//{nameof(LoginPage)}");
        }
    }
}