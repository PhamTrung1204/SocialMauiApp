using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Pages;

public partial class PostDetailsPage : ContentPage
{
    private readonly DetailsViewModel _detailsViewModel;
    private readonly RealtimeUpdatesService _realtimeUpdatesService;
	public PostDetailsPage(DetailsViewModel detailsViewModel, RealtimeUpdatesService realtimeUpdatesService)
	{
		InitializeComponent();
        BindingContext = detailsViewModel;
        _detailsViewModel = detailsViewModel;
        _realtimeUpdatesService = realtimeUpdatesService;
	}
   

    protected override void OnAppearing()
    {
        base.OnAppearing();
        _detailsViewModel.ConfigureRealtimeUpdates();
    }
    protected override void OnDisappearing()
    {
        base.OnDisappearing();
        _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
        _detailsViewModel.Cleanup();
    }
    private async void TapGestureRecognizer_Tapped(object sender, TappedEventArgs e)
    {
        await Shell.Current.GoToAsync("..", animate: true);
    }
    private void CollectionView_RemainingItemsThresholdReached(object sender, EventArgs e)
    {
        _detailsViewModel.FetchCommentsCommand.Execute(null);
    }
    private async void OnMoreOptionsTapped(object sender, EventArgs e)
    {
        // Hiển thị ActionSheet với các tùy chọn Edit và Delete
        string action = await Shell.Current.DisplayActionSheet("Chọn thao tác", "Cancel", null, "Sửa", "Xóa");

        // Lấy đối tượng comment từ BindingContext của sender (tùy thuộc cách bạn tổ chức DataTemplate)
        // Ví dụ, nếu sender là Image, bạn có thể lấy Parent rồi BindingContext.
        // Trong trường hợp đơn giản, nếu bạn đã bind CommandParameter vào comment, có thể tổ chức lại code theo MVVM.

        if (action == "Sửa")
        {
            // Gọi command Edit (bạn có thể truyền thông qua EventToCommandBehavior hoặc 
            // gán xử lý trực tiếp ở đây nếu đã lấy được comment được chọn)
            // Giả sử bạn có phương thức EditComment được truyền commentDto:
            if (sender is VisualElement element && element.BindingContext is CommentDto commentDto)
            {
                // Giả sử _detailsViewModel là ViewModel đã được khởi tạo và set BindingContext cho trang
                await _detailsViewModel.EditCommentCommand.ExecuteAsync(commentDto);
            }
        }
        else if (action == "Xóa")
        {
            if (sender is VisualElement element && element.BindingContext is CommentDto commentDto)
            {
                await _detailsViewModel.DeleteCommentCommand.ExecuteAsync(commentDto);
            }
        }
    }

}