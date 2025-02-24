namespace SocialMauiApp.Pages;

public partial class PostDetailsPage : ContentPage
{
	public PostDetailsPage()
	{
		InitializeComponent();
	}
    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        await Shell.Current.GoToAsync("..", animate: true);
    }
}