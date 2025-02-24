using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.ViewModel
{
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
                await ToastAsync($"{userId} successfully registered");
                await NavigateAsync($"//{nameof(LoginPage)}");
            }
            );

        }

    }
}