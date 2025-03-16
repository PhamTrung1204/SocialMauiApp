using SocialMauiApp.Apis;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages;

public partial class AddPostPage : ContentPage
{
    private readonly IPostApi _postApi;
    public AddPostPage(IPostApi postApi, SavePostViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = viewModel;
        _postApi = postApi;
    }
} 