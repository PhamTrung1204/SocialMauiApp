using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class RegisterPage : ContentPage
{
    public Dictionary<string, object> Parameters { get; set; }
    public RegisterPage(RegisterViewModel registerViewModel)
    {
        InitializeComponent();
    
        BindingContext = registerViewModel;
        Loaded += RegisterPage_Loaded;
    }
    private void RegisterPage_Loaded(object sender, EventArgs e)
    {
        if (Parameters != null && BindingContext is RegisterViewModel viewModel)
        {
            viewModel.Parameters = Parameters;
            viewModel.CheckNavigationParameters(); // Gọi ngay khi tải
        }
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        if (BindingContext is RegisterViewModel viewModel)
        {
            viewModel.CheckNavigationParameters(); // Gọi lại để đảm bảo
        }
    }
    private async void btnLogin_Clicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync($"//{nameof(LoginPage)}");
    }
}