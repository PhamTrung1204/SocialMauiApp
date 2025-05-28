using Microsoft.Maui.Controls;
using SocialMauiApp.Models;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Templates;

public partial class PostWithImage : ContentView
{
    public PostWithImage()
    {
        InitializeComponent();
    }

    private async void OnMoreOptionsTapped(object sender, TappedEventArgs e)
    {
        if (sender is VisualElement element && element.BindingContext is CommentDto comment && BindingContext is PostModel viewModel)
        {
            // Hiển thị menu ngữ cảnh bằng DisplayActionSheet
            string action = await Shell.Current.DisplayActionSheet("Comment Options", "Cancel",
                comment.IsOwnComment ? "Edit" : null,
                comment.IsOwnComment ? "Delete" : null
              );

            if (action == "Edit")
            {
                viewModel.EditCommentCommand.Execute(comment);
            }
            else if (action == "Delete")
            {
                viewModel.DeleteCommentCommand.Execute(comment);
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