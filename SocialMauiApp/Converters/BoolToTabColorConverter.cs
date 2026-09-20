using System.Globalization;

namespace SocialMauiApp.Converters
{
    public class BoolToTabColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture) =>
            value is true ? Resource("Primary", "#2563EB") : Resource("Gray100", "#F3F4F6");

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) =>
            throw new NotSupportedException();

        internal static Color Resource(string key, string fallback) =>
            Application.Current?.Resources.TryGetValue(key, out var value) == true && value is Color color
                ? color
                : Color.FromArgb(fallback);
    }

    public class BoolToTabTextColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture) =>
            value is true
                ? BoolToTabColorConverter.Resource("White", "#FFFFFF")
                : BoolToTabColorConverter.Resource("TextSecondaryLight", "#6B7280");

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) =>
            throw new NotSupportedException();
    }
}
