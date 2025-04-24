using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class LoginWithFingerprintPage : ContentPage
{
	public LoginWithFingerprintPage(LoginWithFingerprintViewModel vm)
	{
		InitializeComponent();
		BindingContext = vm;
	}
}