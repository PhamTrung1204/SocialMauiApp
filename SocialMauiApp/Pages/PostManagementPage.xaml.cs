using SocialMauiApp.ViewModel;
using System.Threading;
using System.Threading.Tasks;

namespace SocialMauiApp.Pages
{
    public partial class PostManagementPage : ContentPage
    {
        private readonly PostManageViewModel _viewModel;
        private CancellationTokenSource _cts;

        public PostManagementPage(PostManageViewModel viewModel)
        {
            InitializeComponent();
            BindingContext = _viewModel = viewModel;
            _cts = new CancellationTokenSource();
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            await _viewModel.InitializeAsync();
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();
            _cts?.Cancel();
            _cts?.Dispose();
            _cts = new CancellationTokenSource();
        }
    }
}