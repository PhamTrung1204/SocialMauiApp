namespace SocialMauiApp.Converters
{
    public class LevelToMarginConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value is int level)
            {
                return new Thickness(level * 20, 0, 0, 0); // 20 units indent per level
            }
            return new Thickness(0);
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
