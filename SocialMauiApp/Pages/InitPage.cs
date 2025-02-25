using SocialMauiApp.Services;

namespace SocialMauiApp.Pages;

public class InitPage : ContentPage
{
	public const string FirstRunKey = " first-run";
	private readonly AuthService _authService;
	public InitPage(AuthService authService)
	{
		Content = new VerticalStackLayout
		{
			Children = {
				new Label { HorizontalOptions = LayoutOptions.Center, VerticalOptions = LayoutOptions.Center, Text = "Initialing"
				}
			}
		};
		_authService = authService;
	}
	protected override async void OnAppearing()
	{
		if (!Preferences.Default.ContainsKey(FirstRunKey))
		{
			await Shell.Current.GoToAsync($"//{nameof(OnboardingPage)}");
			return;

        }
		if (_authService.IsLoggedIn)
		{
            await Shell.Current.GoToAsync($"//{nameof(HomePage)}");
            return;
        }

        await Shell.Current.GoToAsync($"//{nameof(LoginPage)}");
    }
}
