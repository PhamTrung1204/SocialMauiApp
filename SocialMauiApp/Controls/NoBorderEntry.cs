using Microsoft.Maui.Handlers;
using Microsoft.Maui.Platform;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Controls
{
    public class NoBorderEntry:Entry
    {
        protected override void OnHandlerChanged()
        {
            base.OnHandlerChanged();
            SetBorderlessBackground();
        }
        protected override void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            base.OnPropertyChanged(propertyName);
#if ANDROID
            if (propertyName == nameof(BackgroundColor))
                SetBorderlessBackground();
#endif
        }
        private void SetBorderlessBackground()
        {
#if ANDROID
            if (Handler is IEntryHandler entryHandler && entryHandler.PlatformView != null)
            {
                var androidEntry = entryHandler.PlatformView;
                androidEntry.BackgroundTintList = Android.Content.Res.ColorStateList.ValueOf(
                    (BackgroundColor?.ToPlatform() ?? Colors.LightGoldenrodYellow.ToPlatform())
                );
            }
#endif
        }

    }
}
