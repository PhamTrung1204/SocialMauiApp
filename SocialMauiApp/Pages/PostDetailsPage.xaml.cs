using Microsoft.Maui.Controls;
using SocialMauiApp.Models;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Pages
{
    public partial class PostDetailsPage : ContentPage
    {
        public PostDetailsPage(DetailsViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = viewModel;
        }

        private async void TapGestureRecognizer_Tapped(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync("//HomePage");
        }

        private async void OnMoreOptionsTapped(object sender, TappedEventArgs e)
        {
            if (sender is VisualElement element && element.BindingContext is CommentDto comment && BindingContext is DetailsViewModel viewModel)
            {
                // Define options based on whether the comment belongs to the current user
                string[] options = comment.IsOwnComment
                    ? new[] { "Edit", "Delete"}
                    : new[] { "Cancel" };

                string action = await DisplayActionSheet("Comment Options", "Cancel", null, options);
                switch (action)
                {
                    case "Edit":
                        await viewModel.EditAndUpdateCommentAsync(comment);
                        break;
                    case "Delete":
                        await viewModel.DeleteCommentAsync(comment);
                        break;
                }
            }
        }

        private void OnReplyTapped(object sender, TappedEventArgs e)
        {
            if (sender is VisualElement element && element.BindingContext is CommentDto comment)
            {
                var viewModel = (DetailsViewModel)BindingContext;
                viewModel.ReplyCommentCommand.Execute(comment);
            }
        }
        private void OnRemovePhotoTapped(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("RemovePhotoTapped: Tap event triggered on '✕' button.");
            if (sender is BindableObject bindable && bindable.BindingContext is ImagePreview preview)
            {
                var viewModel = BindingContext as DetailsViewModel;
                viewModel?.RemovePhotoCommand.Execute(preview.Id);
            }
        }
        private void CollectionView_RemainingItemsThresholdReached(object sender, EventArgs e)
        {
            var viewModel = (DetailsViewModel)BindingContext;
            viewModel.FetchCommentsCommand.Execute(null);
        }
    }
}