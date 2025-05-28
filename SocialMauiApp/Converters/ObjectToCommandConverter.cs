using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace SocialMauiApp.Converters
{
    public class ObjectToCommandConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is CommentDto comment && parameter is ICommand replyCommand)
            {
                return replyCommand;
            }
            return parameter is ICommand fallbackCommand ? fallbackCommand : Binding.DoNothing;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
