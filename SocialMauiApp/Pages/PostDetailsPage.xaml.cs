using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class PostDetailsPage : ContentPage
{
    private readonly DetailsViewModel _detailsViewModel;
    private readonly RealtimeUpdatesService _realtimeUpdatesService;
	public PostDetailsPage(DetailsViewModel detailsViewModel, RealtimeUpdatesService realtimeUpdatesService)
	{
		InitializeComponent();
        BindingContext = detailsViewModel;
        _detailsViewModel = detailsViewModel;
        _realtimeUpdatesService = realtimeUpdatesService;
	}
    protected override void OnAppearing()
    {
        base.OnAppearing();
        _detailsViewModel.ConfigureRealtimeUpdates();
    }
    protected override void OnDisappearing()
    {
        base.OnDisappearing();
        _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
    }
    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        await Shell.Current.GoToAsync("..", animate: true);
    }
}