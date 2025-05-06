using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;

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
        _detailsViewModel.Cleanup();
    }
    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        await Shell.Current.GoToAsync("..", animate: true);
    }
    private void CollectionView_RemainingItemsThresholdReached(object sender, EventArgs e)
    {
        _detailsViewModel.FetchCommentsCommand.Execute(null);
    }
    private async void OnMoreOptionsTapped(object sender, EventArgs e)
    {
        string action = await Shell.Current.DisplayActionSheet("Select action", "Cancel", null, "Edit", "Delete");

        if (action == "Edit")
        {
            if (sender is VisualElement element && element.BindingContext is CommentDto commentDto)
            {
               await _detailsViewModel.EditAndUpdateCommentCommand.ExecuteAsync(commentDto);
            }
        }
        else if (action == "Delete")
        {
            if (sender is VisualElement element && element.BindingContext is CommentDto commentDto)
            {
                await _detailsViewModel.DeleteCommentCommand.ExecuteAsync(commentDto);
            }
        }
    }

}