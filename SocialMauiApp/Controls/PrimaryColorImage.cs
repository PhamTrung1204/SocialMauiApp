using CommunityToolkit.Maui.Behaviors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Controls
{
    public class PrimaryColorImage : Image
    {
        public PrimaryColorImage() 
        {
            if (App.Current.Resources.TryGetValue("Primary", out object color) && color is Color primaryColor)
            {
                var tintColorBehavior = new IconTintColorBehavior
                {
                    TintColor = primaryColor
                };
                Behaviors.Add(tintColorBehavior);
            }
        }
    }
}
