using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class LoginPage : ContentPage
{
    public LoginPage(LoginViewModel loginViewModel)
    {
        InitializeComponent();
        BindingContext = loginViewModel;
    }
    private async void ForgotPassword_Clicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync(nameof(ResetPasswordPage));
    }
 
    private async void Register_Clicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync(nameof(RegisterPage));
    }
}