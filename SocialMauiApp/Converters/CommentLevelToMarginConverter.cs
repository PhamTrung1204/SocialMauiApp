using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Converters
{
    public class CommentLevelToMarginConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            int level = (int)value;
            string param = parameter?.ToString();
            int baseMargin = 10;
            int indent = level == 0 ? 0 : (level == 1 ? 16 : 32);
            int leftMargin = baseMargin + indent;

            if (param == "Action")
                return new Thickness(leftMargin + 16, 0, 10, 0); // Align actions under content
            if (param == "Reply")
                return new Thickness(leftMargin + 16, 4, 10, 0); // Align reply input under content
            return new Thickness(leftMargin, 0, 10, 0); // Comment margin
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
