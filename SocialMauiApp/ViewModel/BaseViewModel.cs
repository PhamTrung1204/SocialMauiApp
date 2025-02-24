
using CommunityToolkit.Maui.Alerts;
using CommunityToolkit.Mvvm.ComponentModel;
using Refit;


namespace SocialMauiApp.ViewModel
{
    public partial class BaseViewModel : ObservableObject
    {
        [ObservableProperty]
        private bool _isBusy;
        protected async Task ShowErrorAlertAsync(string message) =>
            await Shell.Current.DisplayAlert("Error", message, "Ok");
        protected async Task NavigateAsync(string url) =>
            await Shell.Current.GoToAsync(url, animate: true);
        protected async Task ToastAsync(string message) =>
            await Toast.Make(message).Show();
        protected async Task MakeApiCall(Func<Task> apiCall)
        {
            IsBusy = true;
            try
            {
                await apiCall.Invoke();
            }
            catch (ApiException ex)
            {
                if (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    if (await Shell.Current.DisplayAlert("Login Expired",
                                                          "Login has expired. Do you want to go to login page?",
                                                          "Yes, Go to login page",
                                                          "No, keep me here"))
                    {
                        await NavigateAsync($"//{nameof(LoginPage)}");
                    }
                }
                else
                {
                    await ShowErrorAlertAsync(ex.Message);
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

    }
}