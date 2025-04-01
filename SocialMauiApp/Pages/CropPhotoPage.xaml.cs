using Microsoft.Maui.Controls;
using Syncfusion.Maui.ImageEditor;
using System;
using System.IO;
using System.Threading.Tasks;

namespace SocialMauiApp.Pages
{
    [QueryProperty(nameof(ImagePath), "new-src")]
    public partial class CropPhotoPage : ContentPage
    {
        private string _imagePath;
        public string ImagePath
        {
            get => _imagePath;
            set
            {
                if (!string.IsNullOrWhiteSpace(value))
                {
                    _imagePath = value;
                    OnPropertyChanged(nameof(ImagePath));
                }
            }
        }

        public CropPhotoPage()
        {
            InitializeComponent();
            BindingContext = this; // Đảm bảo BindingContext được đặt chính xác
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();
            // Nếu ImagePath không hợp lệ, sử dụng ảnh placeholder
            if (string.IsNullOrWhiteSpace(ImagePath) || !File.Exists(ImagePath))
            {
                ImagePath = "placeholder.png";
            }
        }

        private async void OnCropPhotoClicked(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_imagePath) || !File.Exists(_imagePath))
            {
                await DisplayAlert("Error", "Original image not found.", "OK");
                return;
            }

            try
            {
                

                // Tạo tên file và đường dẫn cho ảnh đã crop
                var croppedFileName = $"{Guid.NewGuid()}_cropped.jpg";
                var croppedPath = Path.Combine(FileSystem.CacheDirectory, croppedFileName);
                // Áp dụng crop theo kiểu Square (vuông)
                PhotoEditor.Crop(ImageCropType.Square);

                // Gọi Save() với kiểu file Jpeg và đường dẫn file
                PhotoEditor.Save(ImageFileType.Jpeg, croppedPath);

                // Điều hướng về trang trước với query parameter chứa đường dẫn ảnh đã crop
                await Shell.Current.GoToAsync($"..?new-src={Uri.EscapeDataString(croppedPath)}");
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Unable to crop image: {ex.Message}", "OK");
            }
        }
    }
}
