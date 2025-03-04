using CommunityToolkit.Maui.Alerts;
using Syncfusion.Maui.ImageEditor;

namespace SocialMauiApp.Pages;
[QueryProperty(nameof(PhotoSource), nameof(PhotoSource))]
public partial class CropPhotoPage : ContentPage, IQueryAttributable
{
    public CropPhotoPage()
    {
        InitializeComponent();
        
    }
    public string PhotoSource { get; set; }
    public async void ApplyQueryAttributes(IDictionary<string, object> query)
    {
        if (query.TryGetValue(nameof(PhotoSource), out var photoSourceObject) && photoSourceObject is string photoSource)
        {
            if (string.IsNullOrWhiteSpace(photoSource))
            {
                await Toast.Make("No photo provided for cropping").Show();
                await Shell.Current.GoToAsync("..");
                return;
            }
            PhotoSource = photoSource;
            imageEditor.Source = PhotoSource;
            imageEditor.ImageLoaded += ImageEditor_ImageLoaded;
        }
    }
    private void ImageEditor_ImageLoaded(object? sender, EventArgs e)
    {
        imageEditor.Crop(Syncfusion.Maui.ImageEditor.ImageCropType.Circle);
        imageEditor.ImageLoaded -= ImageEditor_ImageLoaded;
    }
    private async void Cancel_Clicked(object? sender, EventArgs e)
    {
        if (imageEditor.HasUnsavedEdits)
        {
            if(await Shell.Current.DisplayAlert("Cancel Cropping","Do you really want to cancel this action?", "Yes", "No"))
            {  
                imageEditor.CancelEdits();
                await Shell.Current.GoToAsync("..");
            }
            else if(await Shell.Current.DisplayAlert("Cancel","Are you sure?","Yes","No")) {
                await Shell.Current.GoToAsync("..");
            }
        }
    }
    private async void AcceptChanges_Clicked(object? sender, EventArgs e)
    {
        if (imageEditor.HasUnsavedEdits)
        {
            await Shell.Current.DisplayAlert("Alert", "There are no changes", "Ok");
            return;
        }
        imageEditor.SaveEdits();
        var newPhotoStream = await imageEditor.GetImageStream();
        var extension = Path.GetExtension(PhotoSource);
        var tempPath = Path.Combine(FileSystem.CacheDirectory, $"{Guid.NewGuid()}{extension}");
        using (var fileStream = File.OpenWrite(tempPath))
        {
            await newPhotoStream.CopyToAsync(fileStream);
        };
       
        await Shell.Current.GoToAsync("..?new-src="+tempPath);
    }
}