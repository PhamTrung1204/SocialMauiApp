using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages
{
    public partial class PostManagementPage : ContentPage
    {
        private readonly PostManageViewModel _viewModel;

        public PostManagementPage(PostManageViewModel postManageViewModel)
        {
            InitializeComponent();
            _viewModel = postManageViewModel;
            BindingContext = _viewModel;
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            await _viewModel.InitializeAsync();
        }
    }
}