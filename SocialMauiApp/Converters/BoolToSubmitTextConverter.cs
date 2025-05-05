using Microsoft.Maui.Controls;
using System;
using System.Globalization;

namespace SocialMauiApp.Converters
{
    public class BoolToSubmitTextConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isEditing)
            {
                return isEditing ? "Update" : "Submit";
            }
            return "Submit";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}