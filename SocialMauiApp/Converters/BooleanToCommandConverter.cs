using SocialMauiApp.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Converters
{
    public class BooleanToCommandConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isEditing && parameter is PostModel postModel)
            {
                return isEditing ? postModel.SaveEditedCommentCommand : postModel.AddCommentCommand;
            }
            return null; // Fallback to avoid runtime errors
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotSupportedException();
        }
    }
}
