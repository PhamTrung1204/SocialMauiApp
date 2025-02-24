using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class RegisterPage : ContentPage
{
    public RegisterPage(RegisterViewModel registerViewModel)
    {
        InitializeComponent();
    
        BindingContext = registerViewModel;
    }    

    private async void btnLogin_Clicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync($"//{nameof(LoginPage)}");
    }
}