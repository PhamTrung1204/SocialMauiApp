namespace SocialMauiApp.Pages
{
    public partial class OnboardingPage : ContentPage
    {
        public OnboardingPage()
        {
            InitializeComponent();
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();

            await MainContent.FadeTo(1, 1000, Easing.CubicIn);
            await Task.Delay(500);

            Preferences.Default.Set(InitPage.FirstRunKey, true);
            await Shell.Current.GoToAsync($"//{nameof(LoginPage)}");
        }
    }
}
