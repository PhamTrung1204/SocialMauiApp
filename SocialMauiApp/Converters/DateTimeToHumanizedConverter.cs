using System;
using System.Globalization;
using Microsoft.Maui.Controls;
using Humanizer;

namespace SocialMauiApp.Converters
{
    public class DateTimeToHumanizedConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is DateTime dateTime)
            {
                return dateTime.Humanize(false, culture: new CultureInfo("en-US"));
            }
            return value;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
