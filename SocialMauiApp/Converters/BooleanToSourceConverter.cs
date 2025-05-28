using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Converters
{
    public class BooleanToSourceConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isEditing && parameter is string paramString)
            {
                var parts = paramString.Split(',');
                if (parts.Length == 2)
                {
                    return isEditing ? parts[1].Trim() : parts[0].Trim(); // e.g., save.png khi chỉnh sửa, send.png otherwise
                }
            }
            return "send.png"; // Fallback
        }

        public object ConvertBack(object? value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotSupportedException();
        }
    }

}
