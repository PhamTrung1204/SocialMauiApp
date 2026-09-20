using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Globalization;

namespace SocialMauiApp.Converters
{
    public class FriendshipStatusToTextConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture) =>
            LocalizationService.Instance.Get(value as string switch
            {
                FriendshipStatuses.Pending => "Friends_CancelRequest",
                FriendshipStatuses.RequestReceived => "Friends_Accept",
                FriendshipStatuses.Friends => "Friends_StatusFriends",
                FriendshipStatuses.Self => "Friends_YourProfile",
                _ => "Friends_Add"
            });

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) =>
            throw new NotSupportedException();
    }
}
