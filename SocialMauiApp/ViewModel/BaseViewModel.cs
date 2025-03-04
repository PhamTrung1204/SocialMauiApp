
using CommunityToolkit.Maui.Alerts;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;


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
        protected async Task NavigateAsync(string url, Dictionary<string, object> parameters) =>
            await Shell.Current.GoToAsync(url, animate: true, parameters);
        protected async Task NavigateBackAsync() => await NavigateAsync("..");
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
        protected async Task<string?> ChoosePhotoAsync()
        {
            if (MediaPicker.Default.IsCaptureSupported)
            {
                const string PickFromDevice = "Pick From Device";
                const string CapturePhoto = "Capture Photo";

                var result = await Shell.Current.DisplayActionSheet("Choose photo", "Cancel", null, PickFromDevice, CapturePhoto);
                Console.WriteLine("User selected: " + result);

                if (string.IsNullOrWhiteSpace(result)) return null;

                switch (result)
                {
                    case PickFromDevice:
                        return await PickFromDeviceAsync();
                    case CapturePhoto:
                        return await CapturePhotoAsync();
                }
                async Task<string?> PickFromDeviceAsync()
                {
                    Console.WriteLine("Picking photo from device...");
                    FileResult? fileResult = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions
                    {
                        Title = "Select Photo"
                    });

                    if (fileResult is null)
                    {
                        Console.WriteLine("No photo selected.");
                        await ToastAsync("No photo selected");
                        return null;
                    }

                   return fileResult.FullPath;
                }

                async Task<string?> CapturePhotoAsync()
                {
                    Console.WriteLine("Capturing photo...");

                    FileResult? fileResult = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions
                    {
                        Title = "Take Photo"
                    });

                    if (fileResult is null)
                    {
                        Console.WriteLine("No photo captured.");
                        await ToastAsync("No photo captured");
                        return null;
                    }
                    return fileResult.FullPath;
                }
            }
            await ToastAsync("Capture is not supported");
            return null;
        }
    }
}