using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;

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
        }

        [ObservableProperty]
        private string _email;
        [ObservableProperty]
        private string _password;

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
    }
}
