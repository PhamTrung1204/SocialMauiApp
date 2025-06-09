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

        await CheckLoginStatusAsync();
    }

    private async Task CheckLoginStatusAsync()
    {
        var jwt = await SecureStorage.GetAsync("AuthToken");
        if (!string.IsNullOrEmpty(jwt))
        {
            var validateResult = await _authApi.ValidateTokenAsync($"Bearer {jwt}");
            if (validateResult.IsSuccess && validateResult.Data is not null)
            {
                _authService.Login(new LoginResponseDto(validateResult.Data, jwt, await SecureStorage.GetAsync("RefreshToken")));
                Username = validateResult.Data.Name;
                string targetPage = validateResult.Data.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
                await NavigateAsync($"//{targetPage}");
                return;
            }
            else
            {
                var refreshToken = await SecureStorage.GetAsync("RefreshToken");
                if (!string.IsNullOrEmpty(refreshToken))
                {
                    var refreshResult = await _authApi.RefreshTokenAsync(new RefreshTokenDto { RefreshToken = refreshToken });
                    if (refreshResult.IsSuccess && refreshResult.Data is not null)
                    {
                        await SecureStorage.SetAsync("AuthToken", refreshResult.Data.Token);
                        await SecureStorage.SetAsync("RefreshToken", refreshResult.Data.RefreshToken);
                        _authService.Login(refreshResult.Data);
                        Username = refreshResult.Data.User.Name;
                        string targetPage = refreshResult.Data.User.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
                        await NavigateAsync($"//{targetPage}");
                        return;
                    }
                }
            }
        }

        await NavigateAsync($"//{nameof(LoginPage)}");
    }

    [RelayCommand]
    private async Task LoginAsync()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            await ShowErrorAlertAsync("Email and Password are required.");
            return;
        }

        await MakeApiCall(async () =>
        {
            var resp = await _authApi.LoginAsync(new LoginDto(Email, Password));
            if (!resp.IsSuccess)
            {
                await ShowErrorAlertAsync(resp.Error ?? "Login failed.");
                return;
            }

            _authService.Login(resp.Data);
            await SecureStorage.SetAsync("AuthToken", resp.Data.Token);
            await SecureStorage.SetAsync("RefreshToken", resp.Data.RefreshToken);

            _pref.SetBool("FingerprintAuthEnabled", true);
            _pref.SetString("LastEmail", resp.Data.User.Email);
            _pref.SetString("Username", resp.Data.User.Name);
            _pref.SetInt(FailKey, 0);
            await SecureStorage.SetAsync("StoredPassword", Password); // Lưu mật khẩu để sử dụng cho vân tay

            string targetPage = resp.Data.User.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
            await NavigateAsync($"//{targetPage}");
        });
    }

    [RelayCommand]
    private async Task LoginWithFingerprintAsync()
    {
        int failCount = _pref.GetInt(FailKey, 0);

        if (failCount >= 3)
        {
            await ShowErrorAlertAsync("Too many failed fingerprint attempts. Please log in with your password.");
            return;
        }

        var result = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
           "Login", "Use your fingerprint to log in"));

        if (!result.Authenticated)
        {
            failCount++;
            _pref.SetInt(FailKey, failCount);

            if (failCount >= 3)
            {
                ShowFingerprintOption = false;
                _pref.SetBool("FingerprintAuthEnabled", false);
                await ShowErrorAlertAsync("Too many failed attempts. Please log in with your password.");
            }
            return;
        }

        _pref.SetInt(FailKey, 0);
        await GenerateNewTokensAsync();
    }

    private async Task GenerateNewTokensAsync()
    {
        var email = _pref.GetString("LastEmail");
        var storedPassword = await SecureStorage.GetAsync("StoredPassword");

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(storedPassword))
        {
            await ShowErrorAlertAsync("No saved credentials found. Please log in with email and password first.");
            _pref.SetBool("FingerprintAuthEnabled", false);
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
                _pref.SetString("Username", resp.Data.User.Name);
                string targetPage = resp.Data.User.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
                await NavigateAsync($"//{targetPage}");
            }
            else
            {
                await ShowErrorAlertAsync("Saved credentials are invalid. Please log in with email and password again.");
                _pref.SetBool("FingerprintAuthEnabled", false);
                SecureStorage.Remove("StoredPassword");
            }
        });
    }

    [RelayCommand]
    private async Task ForgotPasswordAsync()
    {
        if (IsBusy || string.IsNullOrWhiteSpace(Email) || !IsValidGmail(Email))
        {
            await Shell.Current.DisplayAlert("Error", "Please enter a valid Gmail address.", "OK");
            return;
        }

        IsBusy = true;
        try
        {
            await NavigateAsync(nameof(ResetPasswordPage), new Dictionary<string, object> { { "email", Email } });
        }
        finally
        {
            IsBusy = false;
        }
    }

    [RelayCommand]
    private async Task SwitchAccountAsync()
    {
        _pref.SetBool("FingerprintAuthEnabled", false);
        _pref.SetString("LastEmail", "");
        _pref.SetString("Username", "");
        _pref.SetInt(FailKey, 0);
        SecureStorage.Remove("AuthToken");
        SecureStorage.Remove("RefreshToken");
        SecureStorage.Remove("StoredPassword");
        ShowFingerprintOption = false;

        await NavigateAsync($"//{nameof(LoginPage)}");
    }

    private bool IsValidGmail(string email)
    {
        if (string.IsNullOrWhiteSpace(email)) return false;
        return email.ToLower().EndsWith("@gmail.com") && new System.Net.Mail.MailAddress(email).Address == email;
    }
}