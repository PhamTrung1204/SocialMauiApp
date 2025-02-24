using CommunityToolkit.Maui.Behaviors;
using Microsoft.Maui.Controls; // Đảm bảo namespace này có mặt
using Microsoft.Maui.Graphics;

namespace SocialMauiApp.Controls
{
    public class WhiteImage : Image
    {
        public WhiteImage()
        {
            var tintColorBehavior = new IconTintColorBehavior
            {
                TintColor = Colors.White
            };
            Behaviors.Add(tintColorBehavior); 
        }
    }
}
