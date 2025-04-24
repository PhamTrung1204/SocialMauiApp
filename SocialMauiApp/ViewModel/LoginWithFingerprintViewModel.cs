using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Plugin.Fingerprint.Abstractions;
using Plugin.Fingerprint;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SocialMauiApp.Services;
using SocialMauiApp.Apis;

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
            AvatarUrl = _prefs.GetString("AvatarUrl", "default_avatar.png");
        }

        private async Task CheckBiometricAsync()
        {
            IsBiometricAvailable = await _fingerprint.IsAvailableAsync();
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
            var dto = new LoginDto(email, Password);

            await MakeApiCall(async () =>
            {
                var resp = await _authApi.LoginAsync(dto);
                if (resp.IsSuccess)
                {
                    _authService.Login(resp.Data);
                    await NavigateAsync($"//{nameof(HomePage)}");
                }
                else
                {
                    await ShowErrorAlertAsync("Password incorrect.");
                }
            });
        }

        [RelayCommand]
        private async Task LoginWithFingerprintAsync()
        {
            var auth = await _fingerprint.AuthenticateAsync(new AuthenticationRequestConfiguration(
                "Login", "Authenticate to login"));
            if (!auth.Authenticated) return;

            var token = _prefs.GetString("AuthToken", "");
            if (string.IsNullOrEmpty(token))
            {
                await ShowErrorAlertAsync("Session expired. Please login again.");
                return;
            }

            await MakeApiCall(async () =>
            {
                var resp = await _authApi.ValidateTokenAsync($"Bearer {token}");
                if (resp.IsSuccess && resp.Data != null)
                {
                    _authService.Login(new LoginResponseDto(resp.Data, token));
                    await NavigateAsync($"//{nameof(HomePage)}");
                }
                else
                {
                    await ShowErrorAlertAsync("Session expired. Please login again.");
                }
            });
        }

        [RelayCommand]
        private async Task LoginWithAnotherAsync()
            => await NavigateAsync(nameof(LoginPage));
    }
}
