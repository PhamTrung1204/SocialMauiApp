using System.Globalization;

namespace SocialMauiApp.Converters
{
    public class ContentLengthToFontSizeConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is string content)
            {
                return content.Length <= 100 ? 18.0 : 15.0; // Large font for short posts, smaller for longer
            }
            return 15.0; // Default font size
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
