using SocialMauiApp.Models;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Templates;

public partial class PostWithOnlyImage : ContentView
{
	public PostWithOnlyImage()
	{
		InitializeComponent();
	}
    private async void OnMoreOptionsTapped(object sender, TappedEventArgs e)
    {
        if (sender is VisualElement element && element.BindingContext is CommentDto comment && BindingContext is PostModel viewModel)
        {
            string action = await Shell.Current.DisplayActionSheet("Comment Options", "Cancel",
                comment.IsOwnComment ? "Edit" : null,
                comment.IsOwnComment ? "Delete" : null,
                "Reply"
            );

            if (action == "Edit")
            {
                await viewModel.EditCommentCommand.ExecuteAsync(comment);
            }
            else if (action == "Delete")
            {
                await viewModel.DeleteCommentCommand.ExecuteAsync(comment);
            }
            else if (action == "Reply")
            {
                await viewModel.ReplyCommentCommand.ExecuteAsync(comment);
            }
        }
    }

    private void OnRemovePhotoTapped(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine("RemovePhotoTapped: Tap event triggered on '✕' button.");
        if (sender is BindableObject bindable && bindable.BindingContext is ImagePreview preview)
        {
            var viewModel = BindingContext as PostModel;
            viewModel?.RemovePhotoCommand.Execute(preview.Id);
        }
    }

    private void OnReplyTapped(object sender, TappedEventArgs e)
    {
        if (sender is VisualElement element && element.BindingContext is CommentDto comment && BindingContext is PostModel viewModel)
        {
            viewModel.ReplyCommentCommand.Execute(comment);
        }
    }
}