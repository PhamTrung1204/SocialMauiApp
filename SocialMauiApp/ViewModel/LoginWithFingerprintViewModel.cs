using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Threading.Tasks;
using Microsoft.Maui.Storage;

namespace SocialMauiApp.ViewModel;

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

    [ObservableProperty] private string greetingText;
    [ObservableProperty] private string avatarUrl;
    [ObservableProperty] private string password;
    [ObservableProperty] private bool isBiometricAvailable;

    private void LoadData()
    {
        var name = _prefs.GetString("DisplayName", "");
        GreetingText = string.IsNullOrEmpty(name) ? "Welcome" : $"Welcome, {name}";
        AvatarUrl = _prefs.GetString("AvatarUrl", "user.png");
    }

    private async Task CheckBiometricAsync()
    {
        IsBiometricAvailable = await _fingerprint.IsAvailableAsync();
        if (IsBiometricAvailable)
        {
            await CheckLoginStatusAsync();
        }
    }

    private async Task CheckLoginStatusAsync()
    {
        var jwt = await SecureStorage.GetAsync("AuthToken");
        if (!string.IsNullOrEmpty(jwt))
        {
            await MakeApiCall(async () =>
            {
                var validateResult = await _authApi.ValidateTokenAsync($"Bearer {jwt}");
                if (validateResult.IsSuccess && validateResult.Data != null)
                {
                    var refreshToken = await SecureStorage.GetAsync("RefreshToken");
                    _authService.Login(new LoginResponseDto(validateResult.Data, jwt, refreshToken));
                    await NavigateAsync($"//{nameof(HomePage)}");
                }
                else
                {
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
                        }
                    }
                }
            });
        }
    }

    [RelayCommand]
    private async Task LoginWithPasswordAsync()
    {
        if (string.IsNullOrWhiteSpace(Password))
        {
            await ShowErrorAlertAsync("Please enter your password.");
            return;
        }

        var email = _prefs.GetString("LastEmail", "");
        if (string.IsNullOrWhiteSpace(email))
        {
            await ShowErrorAlertAsync("No saved email found. Please log in through the main login page.");
            return;
        }

        await MakeApiCall(async () =>
        {
            var resp = await _authApi.LoginAsync(new LoginDto(email, Password));
            if (resp.IsSuccess)
            {
                await SecureStorage.SetAsync("AuthToken", resp.Data.Token);
                await SecureStorage.SetAsync("RefreshToken", resp.Data.RefreshToken);
                await SecureStorage.SetAsync("StoredPassword", Password); // Lưu mật khẩu để sử dụng cho vân tay
                _authService.Login(resp.Data);
                _prefs.SetString("LastEmail", email);
                _prefs.SetString("DisplayName", resp.Data.User.Name);
                _prefs.SetString("AvatarUrl", resp.Data.User.PhotoUrl ?? "user.png");
                _prefs.SetBool("FingerprintAuthEnabled", true);
                await NavigateAsync($"//{nameof(HomePage)}");
            }
            else
            {
                await ShowErrorAlertAsync("Incorrect password.");
            }
        });
    }

    [RelayCommand]
    private async Task LoginWithFingerprintAsync()
    {
        if (!IsBiometricAvailable)
        {
            await ShowErrorAlertAsync("Biometric authentication is not available on this device.");
            return;
        }

        var isFingerprintEnabled = _prefs.GetBool("FingerprintAuthEnabled", false);
        if (!isFingerprintEnabled)
        {
            await ShowErrorAlertAsync("Fingerprint authentication is not enabled. Please enable it in your profile after logging in.");
            return;
        }

        var auth = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
            "Login", "Confirm your fingerprint to log in"));
        if (!auth.Authenticated)
        {
            await ShowErrorAlertAsync("Fingerprint authentication failed. Please try again.");
            return;
        }

        await GenerateNewTokensAsync();
    }

    private async Task GenerateNewTokensAsync()
    {
        var email = _prefs.GetString("LastEmail", "");
        var storedPassword = await SecureStorage.GetAsync("StoredPassword");

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(storedPassword))
        {
            await ShowErrorAlertAsync("No saved credentials found. Please log in with email and password to enable fingerprint authentication.");
            _prefs.SetBool("FingerprintAuthEnabled", false);
            SecureStorage.Remove("StoredPassword");
            return;
        }

        await MakeApiCall(async () =>
        {
            var resp = await _authApi.LoginAsync(new LoginDto(email, storedPassword));
            if (resp.IsSuccess)
            {
                await SecureStorage.SetAsync("AuthToken", resp.Data.Token);
                await SecureStorage.SetAsync("RefreshToken", resp.Data.RefreshToken);
                _authService.Login(resp.Data);
                _prefs.SetString("DisplayName", resp.Data.User.Name);
                _prefs.SetString("AvatarUrl", resp.Data.User.PhotoUrl ?? "user.png");
                _prefs.SetString("LastEmail", email);
                await NavigateAsync($"//{nameof(HomePage)}");
            }
            else
            {
                await ShowErrorAlertAsync("Saved credentials are invalid. Please log in with email and password to re-enable fingerprint authentication.");
                _prefs.SetBool("FingerprintAuthEnabled", false);
                SecureStorage.Remove("StoredPassword");
            }
        });
    }

    [RelayCommand]
    private async Task LoginWithAnotherAsync()
    {
        _prefs.SetString("DisplayName", "");
        _prefs.SetString("AvatarUrl", "user.png");
        _prefs.SetBool("FingerprintAuthEnabled", false);
        SecureStorage.Remove("StoredPassword");
        _authService.Logout();
        await NavigateAsync($"//{nameof(LoginPage)}");
    }
}