using SocialMauiApp.ViewModel;


namespace SocialMauiApp.Pages;

public partial class AdminDashboardPage : ContentPage
{
    private readonly AdminViewModel _viewModel;

    public AdminDashboardPage(AdminViewModel viewModel)
    {
        InitializeComponent();
        BindingContext = _viewModel = viewModel;
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();
        await _viewModel.InitializeAsync();
    }
}