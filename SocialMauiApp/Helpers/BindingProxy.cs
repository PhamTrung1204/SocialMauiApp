using Microsoft.Maui.Controls;

namespace SocialMauiApp.Helpers
{
    public class BindingProxy : BindableObject
    {
        public object Data
        {
            get => GetValue(DataProperty);
            set => SetValue(DataProperty, value);
        }

        public static readonly BindableProperty DataProperty =
            BindableProperty.Create(nameof(Data), typeof(object), typeof(BindingProxy), null);
    }
}
