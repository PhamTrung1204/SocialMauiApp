using Microsoft.Maui.Controls;
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
                    UpdatePhotoSource();
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
            UpdatePhotoSource();
        }

        private void UpdatePhotoSource()
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(_imagePath) && File.Exists(_imagePath))
                {
                    // Sử dụng FromFile để load ảnh từ đường dẫn trên thiết bị thật
                    PhotoImage.Source = ImageSource.FromFile(_imagePath);
                }
                else
                {
                    // Nếu file không tồn tại, có thể hiển thị ảnh placeholder
                    PhotoImage.Source = "placeholder.png";
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error updating photo source: " + ex.ToString());
            }
        }

        private async void OnCropPhotoClicked(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_imagePath))
            {
                await DisplayAlert("Lỗi", "Không tìm thấy ảnh để cắt", "OK");
                return;
            }

            if (!File.Exists(_imagePath))
            {
                await DisplayAlert("Lỗi", "Ảnh gốc không tồn tại", "OK");
                return;
            }

            try
            {
                // Giả lập crop ảnh: copy file gốc sang file mới trong thư mục CacheDirectory
                var croppedFileName = $"{Guid.NewGuid()}_cropped.jpg";
                var croppedPath = Path.Combine(FileSystem.CacheDirectory, croppedFileName);
                File.Copy(_imagePath, croppedPath, true);

                // Điều hướng quay lại trang đăng ký với query parameter chứa đường dẫn ảnh đã cắt
                await Shell.Current.GoToAsync($"..?new-src={Uri.EscapeDataString(croppedPath)}");
            }
            catch (Exception ex)
            {
                await DisplayAlert("Lỗi", $"Không thể cắt ảnh: {ex.Message}", "OK");
            }
        }
    }
}
