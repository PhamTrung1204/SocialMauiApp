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
                    LoadImage();
                }
            }
        }

        public CropPhotoPage()
        {
            InitializeComponent();
            BindingContext = this;

            // Register the image saving completed event handler
            PhotoEditor.ImageSaved += PhotoEditor_ImageSaved;
        }

        private void LoadImage()
        {
            if (!string.IsNullOrWhiteSpace(_imagePath) && File.Exists(_imagePath))
            {
                try
                {
                    // Load the image from path into the editor
                    PhotoEditor.Source = ImageSource.FromFile(_imagePath);
                }
                catch (Exception ex)
                {
                    DisplayAlert("Error", $"Failed to load image: {ex.Message}", "OK");
                }
            }
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();

            // If ImagePath is invalid, use placeholder image
            if (string.IsNullOrWhiteSpace(ImagePath) || !File.Exists(ImagePath))
            {
                ImagePath = "placeholder.png";
            }
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();

            // Unregister event handlers to prevent memory leaks
            PhotoEditor.ImageSaved -= PhotoEditor_ImageSaved;
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
                

                // Create a path for the cropped image
                var croppedFileName = $"{Guid.NewGuid()}_cropped.jpg";
                var croppedPath = Path.Combine(FileSystem.CacheDirectory, croppedFileName);

                // Save the image to the specified path
                PhotoEditor.Save(ImageFileType.Jpeg, croppedPath);

                // Note: The actual navigation will happen in the ImageSaved event handler
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Unable to crop image: {ex.Message}", "OK");
            }
        }

        private async void PhotoEditor_ImageSaved(object sender, ImageSavedEventArgs e)
        {

            // When image saving is successful, navigate back with the cropped image path
            string croppedPath = e.Location;
            await Shell.Current.GoToAsync($"..?new-src={Uri.EscapeDataString(croppedPath)}");
        }
    }
}