using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Converters
{
    public class FriendshipStatusToTextConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value switch
            {
                "NotFriends" => "Thêm bạn",
                "Pending" => "Hủy lời mời",
                "Friends" => "Bạn bè",
                _ => "Thêm bạn"
            };
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
