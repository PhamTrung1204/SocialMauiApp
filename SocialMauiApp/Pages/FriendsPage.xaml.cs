using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages
{
    public partial class FriendsPage : ContentPage
    {
        private readonly FriendsViewModel _viewModel;

        public FriendsPage(FriendsViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = _viewModel = viewModel;
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
            if (_viewModel.AppearingCommand.CanExecute(null))
            {
                _viewModel.AppearingCommand.Execute(null);
            }
        }
    }
}
