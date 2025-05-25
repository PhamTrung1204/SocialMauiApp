using Microsoft.Maui.Controls;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages
{
    public partial class ResetPasswordPage : ContentPage
    {
        private readonly ResetPasswordViewModel _viewModel;

        public ResetPasswordPage(ResetPasswordViewModel resetPasswordViewModel)
        {
            Console.WriteLine("ResetPasswordPage instantiated.");
            InitializeComponent();
            _viewModel = resetPasswordViewModel;
            BindingContext = _viewModel;
        }

        private async void btnLogin_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync($"//{nameof(LoginPage)}");
        }
    }
}