using CommunityToolkit.Maui.Alerts;
using Syncfusion.Maui.ImageEditor;
using System.Diagnostics;

namespace SocialMauiApp.Pages;

[QueryProperty(nameof(PhotoSource), nameof(PhotoSource))]
public partial class CropPhotoPage : ContentPage, IQueryAttributable
{
    public CropPhotoPage()
    {
        InitializeComponent();
    }

    // Thuộc tính nhận giá trị từ Query (đường dẫn ảnh)
    public string PhotoSource { get; set; }

    // Triển khai IQueryAttributable: bắt buộc dùng chữ ký (signature) void
    public void ApplyQueryAttributes(IDictionary<string, object> query)
    {
        // Gọi hàm async để xử lý bất đồng bộ
        _ = ApplyQueryAttributesAsync(query);
    }

    // Xử lý bất đồng bộ trong hàm riêng
    private async Task ApplyQueryAttributesAsync(IDictionary<string, object> query)
    {
        // 1. Lấy giá trị PhotoSource từ query
        if (!query.TryGetValue(nameof(PhotoSource), out var photoSourceObject)
            || photoSourceObject is not string photoSource)
        {
            await Toast.Make("Invalid photo source provided").Show();
            await Shell.Current.GoToAsync("..");
            return;
        }

        // 2. Kiểm tra xem chuỗi có rỗng không
        if (string.IsNullOrWhiteSpace(photoSource))
        {
            await Toast.Make("No photo provided for cropping").Show();
            await Shell.Current.GoToAsync("..");
            return;
        }

        // 3. Nếu đường dẫn chưa tuyệt đối, ghép với CacheDirectory
        if (!Path.IsPathRooted(photoSource))
        {
            photoSource = Path.Combine(FileSystem.CacheDirectory, photoSource);
        }

        // 4. Kiểm tra file tồn tại
        if (!File.Exists(photoSource))
        {
            await Toast.Make($"File not found: {photoSource}").Show();
            await Shell.Current.GoToAsync("..");
            return;
        }

        // 5. Gán PhotoSource đã chuẩn hoá
        PhotoSource = photoSource;
        Debug.WriteLine($"Loading image from: {PhotoSource}");

        // 6. Gán cho ImageEditor
        imageEditor.Source = ImageSource.FromFile(PhotoSource);
        imageEditor.ImageLoaded += ImageEditor_ImageLoaded;
    }

    private void ImageEditor_ImageLoaded(object? sender, EventArgs e)
    {
        // Khi ảnh load xong, thực hiện crop
        imageEditor.Crop(ImageCropType.Circle);
        imageEditor.ImageLoaded -= ImageEditor_ImageLoaded;
    }

    private async void Cancel_Clicked(object? sender, EventArgs e)
    {
        if (imageEditor.HasUnsavedEdits)
        {
            bool confirmCancel = await Shell.Current.DisplayAlert(
                "Cancel Cropping",
                "Do you really want to cancel this action?",
                "Yes",
                "No"
            );
            if (confirmCancel)
            {
                imageEditor.CancelEdits();
                await Shell.Current.GoToAsync("..");
            }
            else
            {
                bool secondConfirm = await Shell.Current.DisplayAlert("Cancel", "Are you sure?", "Yes", "No");
                if (secondConfirm)
                {
                    await Shell.Current.GoToAsync("..");
                }
            }
        }
        else
        {
            await Shell.Current.GoToAsync("..");
        }
    }

    private async void AcceptChanges_Clicked(object? sender, EventArgs e)
    {
        if (!imageEditor.HasUnsavedEdits)
        {
            await Shell.Current.DisplayAlert("Alert", "There are no changes", "Ok");
            return;
        }

        try
        {
            // Lưu các chỉnh sửa
            imageEditor.SaveEdits();
            var newPhotoStream = await imageEditor.GetImageStream();

            // Tạo tên file mới trong CacheDirectory
            var extension = Path.GetExtension(PhotoSource);
            var tempPath = Path.Combine(FileSystem.CacheDirectory, $"{Guid.NewGuid()}{extension}");

            // Ghi stream vào file mới
            using (var fileStream = File.OpenWrite(tempPath))
            {
                await newPhotoStream.CopyToAsync(fileStream);
            }

            Debug.WriteLine($"Saved cropped image to: {tempPath}");

            // Điều hướng quay lại kèm query string chứa đường dẫn ảnh đã crop
            await Shell.Current.GoToAsync("..?new-src=" + tempPath);
        }
        catch (Exception ex)
        {
            Debug.WriteLine("Error saving cropped image: " + ex.Message);
            await Shell.Current.DisplayAlert("Error", "Failed to save cropped image", "Ok");
        }
    }
}
