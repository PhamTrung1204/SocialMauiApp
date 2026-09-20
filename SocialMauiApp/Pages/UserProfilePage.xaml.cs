using SocialMauiApp.ViewModel;

namespace SocialMauiApp.Pages
{
    public partial class UserProfilePage : ContentPage
    {
        public UserProfilePage(UserProfileViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = viewModel;
        }
    }
}
