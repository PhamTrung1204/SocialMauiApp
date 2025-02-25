using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class AddPostPage : ContentPage
{
    public AddPostPage(SavePostViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
    }
}