namespace SocialMauiApp.Pages
{
    public partial class HomePage : ContentPage
    {


        public HomePage()
        {
            InitializeComponent();
        }

        private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(PostDetailsPage), animate: true);
        }

        private async void AddPost_Tapped_1(object sender, TappedEventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(AddPostPage), animate: true);
        }

        private async void GoToProfile(object sender, TappedEventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(ProfilePage), animate: true);
        }

        private async void GoToNotification(object sender, TappedEventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(NotificationPage), animate: true);
        }
    }

}
