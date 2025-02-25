using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class PostDetailsPage : ContentPage
{
	public PostDetailsPage(DetailsViewModel detailsViewModel)
	{
		InitializeComponent();
        BindingContext = detailsViewModel;
	}
    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        await Shell.Current.GoToAsync("..", animate: true);
    }
}