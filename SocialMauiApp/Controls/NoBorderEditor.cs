using Microsoft.Maui.Handlers;
using Microsoft.Maui.Platform;
using System.Runtime.CompilerServices;

namespace SocialMauiApp.Controls
{
    public class NoBorderEditor : Editor
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
            {
                SetBorderlessBackground();
            }
#endif
        }

        private void SetBorderlessBackground()
        {
#if ANDROID
            if (Handler is IEditorHandler entryHandler && entryHandler.PlatformView != null)
            {
                // Loại bỏ đường viền
                entryHandler.PlatformView.BackgroundTintList = null;

                // Giữ màu nền nếu được đặt, nếu không thì đặt Transparent
                var color = BackgroundColor?.ToPlatform() ?? Colors.Transparent.ToPlatform();
                entryHandler.PlatformView.SetBackgroundColor(color);
            }
#endif
        }
    }
}
