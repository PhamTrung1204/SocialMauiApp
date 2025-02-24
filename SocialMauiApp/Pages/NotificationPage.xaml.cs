namespace SocialMauiApp.Pages;

public partial class NotificationPage : ContentPage
{
    public NotificationPage()
    {
        InitializeComponent();
        List<NotificationModel> notification = [
            new NotificationModel(DateTime.Now,"This person liked your post"),
            new NotificationModel(DateTime.Now.AddDays(-1),"This person commented your post"),
            new NotificationModel(DateTime.Now,"This person bookmarked your post"),
            new NotificationModel(DateTime.Now.AddMinutes(50),"This person liked your post"),
            new NotificationModel(DateTime.Now,"This person liked your post"),
            new NotificationModel(DateTime.Now.AddMonths(-5),"This person liked your post"),
            new NotificationModel(DateTime.Now,"This person liked your post"),
            new NotificationModel(DateTime.Now,"This person liked your post"),
            ];
        collection.ItemsSource = notification;
    }
    public record NotificationModel(DateTime On, string Text);
}