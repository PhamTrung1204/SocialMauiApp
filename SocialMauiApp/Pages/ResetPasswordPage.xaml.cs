using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class ResetPasswordPage : ContentPage
{
    public Dictionary<string, object> Parameters { get; set; }
    public ResetPasswordPage(ResetPasswordViewModel resetPasswordViewModel)
    {
        InitializeComponent();
        BindingContext = resetPasswordViewModel;
    }
    private void ResetPasswordPage_Loaded(object sender, EventArgs e)
    {
        if (Parameters != null && BindingContext is ResetPasswordViewModel viewModel)
        {
            viewModel.Parameters = Parameters;
            viewModel.CheckNavigationParameters();
            Loaded += ResetPasswordPage_Loaded;
        }
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        if (BindingContext is ResetPasswordViewModel viewModel)
        {
            viewModel.CheckNavigationParameters();
        }
    }
    private async void btnLogin_Clicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync($"//{nameof(LoginPage)}");
    }
}