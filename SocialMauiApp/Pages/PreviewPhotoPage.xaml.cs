using Microsoft.Maui.Controls;
using SocialMauiApp.ViewModel;
using System;
using System.IO;

namespace SocialMauiApp.Pages
{
    [QueryProperty(nameof(PhotoUrl), "photo-url")]
    public partial class PreviewPhotoPage : ContentPage
    {
        private string _photoUrl;

        public string PhotoUrl
        {
            get => _photoUrl;
            set
            {
                _photoUrl = value;
                OnPropertyChanged();

                if (!string.IsNullOrEmpty(_photoUrl))
                {
                    LoadProfileImageAsync();
                }
            }
        }

        public PreviewPhotoPage()
        {
            InitializeComponent();
        }

        private async void LoadProfileImageAsync()
        {
            try
            {
                LoadingIndicator.IsRunning = true;
                LoadingIndicator.IsVisible = true;

                // Tải ảnh từ URL
                ProfileImage.Source = ImageSource.FromUri(new Uri(_photoUrl));

                // Đảm bảo có đủ thời gian để tải ảnh
                await Task.Delay(300);
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Could not load profile image: {ex.Message}", "OK");
            }
            finally
            {
                LoadingIndicator.IsRunning = false;
                LoadingIndicator.IsVisible = false;
            }
        }

        private async void OnCloseClicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync("..");
        }

        private async void OnUpdatePhotoClicked(object sender, EventArgs e)
        {
            // Quay lại và kích hoạt quy trình thay đổi ảnh
            await Shell.Current.GoToAsync("..");

            // Truy cập ProfileViewModel để bắt đầu luồng thay đổi ảnh
            if (Shell.Current.CurrentPage.BindingContext is ProfileViewModel viewModel)
            {
                await viewModel.ChangePhotoAsync();
            }
        }

        private async void OnImageTapped(object sender, EventArgs e)
        {
            // Bật hiển thị các điều khiển nếu đang ẩn hoặc ẩn nếu đang hiển thị
            ControlsOverlay.IsVisible = !ControlsOverlay.IsVisible;
        }
    }

}
