using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.Storage;
using Plugin.Fingerprint;
using Plugin.Fingerprint.Abstractions;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel;

public partial class LoginViewModel : BaseViewModel
{
    private const string FailKey = "FingerprintFailCount";

    private readonly IAuthApi _authApi;
    private readonly AuthService _authService;
    private readonly IPreferencesService _pref;
    private readonly IFingerprint _fingerprint;

    public LoginViewModel(
        IAuthApi authApi,
        AuthService authService,
        IPreferencesService preferencesService)
    {
        _authApi = authApi;
        _authService = authService;
        _pref = preferencesService;
        _fingerprint = CrossFingerprint.Current;

        Task.Run(InitializeAsync);
    }

    [ObservableProperty] private string email = string.Empty;
    [ObservableProperty] private string password = string.Empty;
    [ObservableProperty] private string username = string.Empty;
    [ObservableProperty] private bool showFingerprintOption;

    private async Task InitializeAsync()
    {
        var bioEnabled = _pref.GetBool("FingerprintAuthEnabled");
        var savedEmail = _pref.GetString("LastEmail");
        var savedUser = _pref.GetString("Username");

        if (bioEnabled && !string.IsNullOrEmpty(savedEmail))
        {
            Email = savedEmail;
            Username = savedUser;
            ShowFingerprintOption = await _fingerprint.IsAvailableAsync();
        }
    }

    [RelayCommand]
    private async Task LoginAsync()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            await ShowErrorAlertAsync("Email & Password required.");
            return;
        }

        await MakeApiCall(async () =>
        {
            var resp = await _authApi.LoginAsync(new LoginDto(Email, Password));
            if (!resp.IsSuccess)
            {
                await ShowErrorAlertAsync(resp.Error ?? "Login failed");
                return;
            }

            // Đăng nhập thành công
            _authService.Login(resp.Data);

            // Lưu để biometric
            _pref.SetBool("FingerprintAuthEnabled", true);
            _pref.SetString("LastEmail", resp.Data.User.Email);
            _pref.SetString("Username", resp.Data.User.Name);
            _pref.SetInt(FailKey, 0);                     
            await SecureStorage.SetAsync("AuthToken", resp.Data.Token);

            await NavigateAsync($"//{nameof(HomePage)}");
        });
    }

    [RelayCommand]
    private async Task LoginWithFingerprintAsync()
    {
        // Lấy số lần thất bại hiện tại
        int failCount = _pref.GetInt(FailKey, 0);

        if (failCount >= 3)
        {
            // Quá 3 lần, buộc dùng mật khẩu
            await ShowErrorAlertAsync("Too many failed attempts. Please login with your password.");
            return;
        }

        var result = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
            "Login", "Use fingerprint to login"));

        if (!result.Authenticated)
        {
            // Tăng bộ đếm và lưu
            failCount++;
            _pref.SetInt(FailKey, failCount);

            if (failCount >= 3)
            {
                // Ẩn tuỳ chọn vân tay, buộc nhập lại mật khẩu
                ShowFingerprintOption = false;
                _pref.SetBool("FingerprintAuthEnabled", true);
                await ShowErrorAlertAsync("Too many failed attempts. Please login with your password.");
            }
            return;
        }

        // Thành công reset bộ đếm
        _pref.SetInt(FailKey, 0);

        // Tiếp tục flow
        var token = await SecureStorage.GetAsync("AuthToken");
        var email = _pref.GetString("LastEmail");
        var user = _pref.GetString("Username");

        if (string.IsNullOrEmpty(token) || string.IsNullOrEmpty(email))
        {
            await ShowErrorAlertAsync("Please login with password first.");
            return;
        }

        await MakeApiCall(async () =>
        {
            var v = await _authApi.ValidateTokenAsync($"Bearer {token}");
            if (v.IsSuccess && v.Data is not null)
            {
                _authService.Login(new LoginResponseDto(v.Data, token));
                Username = user;
                await NavigateAsync($"//{nameof(HomePage)}");
            }
            else
            {
                await ShowErrorAlertAsync("Session expired, please login again.");
            }
        });
    }

    [RelayCommand]
    private async Task SwitchAccountAsync()
    {
        _pref.SetBool("FingerprintAuthEnabled", false);
        _pref.SetString("LastEmail", "");
        _pref.SetString("Username", "");
        _pref.SetInt(FailKey, 0);                        
        SecureStorage.Remove("AuthToken");
        ShowFingerprintOption = false;

        await NavigateAsync($"//{nameof(LoginPage)}");
    }
}
