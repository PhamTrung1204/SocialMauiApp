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

        // Kiểm tra token khi khởi động
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
                // Thử làm mới token
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

        // Nếu không có token hoặc làm mới thất bại, giữ ở trang đăng nhập
        await NavigateAsync($"//{nameof(LoginPage)}");
    }

    [RelayCommand]
    private async Task LoginAsync()
    {
        if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
        {
            await ShowErrorAlertAsync("Yêu cầu nhập Email và Mật khẩu.");
            return;
        }

        await MakeApiCall(async () =>
        {
            var resp = await _authApi.LoginAsync(new LoginDto(Email, Password));
            if (!resp.IsSuccess)
            {
                await ShowErrorAlertAsync(resp.Error ?? "Đăng nhập thất bại");
                return;
            }

            // Đăng nhập thành công
            _authService.Login(resp.Data);
            await SecureStorage.SetAsync("AuthToken", resp.Data.Token);
            await SecureStorage.SetAsync("RefreshToken", resp.Data.RefreshToken);

            // Lưu để biometric
            _pref.SetBool("FingerprintAuthEnabled", true);
            _pref.SetString("LastEmail", resp.Data.User.Email);
            _pref.SetString("Username", resp.Data.User.Name);
            _pref.SetInt(FailKey, 0);

            // Kiểm tra Role để điều hướng
            string targetPage = resp.Data.User.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
            await NavigateAsync($"//{targetPage}");
        });
    }

    [RelayCommand]
    private async Task LoginWithFingerprintAsync()
    {
        // Lấy số lần thất bại hiện tại
        int failCount = _pref.GetInt(FailKey, 0);

        if (failCount >= 3)
        {
            await ShowErrorAlertAsync("Quá nhiều lần thử thất bại. Vui lòng đăng nhập bằng mật khẩu.");
            return;
        }

        var result = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
            "Đăng nhập", "Sử dụng vân tay để đăng nhập"));

        if (!result.Authenticated)
        {
            failCount++;
            _pref.SetInt(FailKey, failCount);

            if (failCount >= 3)
            {
                ShowFingerprintOption = false;
                _pref.SetBool("FingerprintAuthEnabled", false);
                await ShowErrorAlertAsync("Quá nhiều lần thử thất bại. Vui lòng đăng nhập bằng mật khẩu.");
            }
            return;
        }

        _pref.SetInt(FailKey, 0);

        var token = await SecureStorage.GetAsync("AuthToken");
        var refreshToken = await SecureStorage.GetAsync("RefreshToken");
        var email = _pref.GetString("LastEmail");
        var user = _pref.GetString("Username");

        if (string.IsNullOrEmpty(token) || string.IsNullOrEmpty(email))
        {
            await ShowErrorAlertAsync("Vui lòng đăng nhập bằng mật khẩu trước.");
            return;
        }

        await MakeApiCall(async () =>
        {
            var v = await _authApi.ValidateTokenAsync($"Bearer {token}");
            if (v.IsSuccess && v.Data is not null)
            {
                _authService.Login(new LoginResponseDto(v.Data, token, refreshToken));
                Username = user;
                string targetPage = v.Data.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
                await NavigateAsync($"//{targetPage}");
            }
            else
            {
                // Thử làm mới token
                var refreshResult = await _authApi.RefreshTokenAsync(new RefreshTokenDto { RefreshToken = refreshToken });
                if (refreshResult.IsSuccess && refreshResult.Data is not null)
                {
                    await SecureStorage.SetAsync("AuthToken", refreshResult.Data.Token);
                    await SecureStorage.SetAsync("RefreshToken", refreshResult.Data.RefreshToken);
                    _authService.Login(refreshResult.Data);
                    Username = refreshResult.Data.User.Name;
                    string targetPage = refreshResult.Data.User.Role == "Admin" ? nameof(AdminDashboardPage) : nameof(HomePage);
                    await NavigateAsync($"//{targetPage}");
                }
                else
                {
                    await ShowErrorAlertAsync("Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại.");
                }
            }
        });
    }

    [RelayCommand]
    private async Task ForgotPasswordAsync()
    {
        if (IsBusy || string.IsNullOrWhiteSpace(Email) || !IsValidGmail(Email))
        {
            await Shell.Current.DisplayAlert("Lỗi", "Vui lòng nhập địa chỉ Gmail hợp lệ", "OK");
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
        ShowFingerprintOption = false;

        await NavigateAsync($"//{nameof(LoginPage)}");
    }

    private bool IsValidGmail(string email)
    {
        if (string.IsNullOrWhiteSpace(email)) return false;
        return email.ToLower().EndsWith("@gmail.com") && new System.Net.Mail.MailAddress(email).Address == email;
    }
}