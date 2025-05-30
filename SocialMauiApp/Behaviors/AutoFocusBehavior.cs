using SocialMauiApp.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Behaviors
{
    public class AutoFocusBehavior : Behavior<Entry>
    {
        public static readonly BindableProperty ShouldFocusProperty =
            BindableProperty.Create(nameof(ShouldFocus), typeof(bool), typeof(AutoFocusBehavior), false,
                propertyChanged: OnShouldFocusChanged);

        public bool ShouldFocus
        {
            get => (bool)GetValue(ShouldFocusProperty);
            set => SetValue(ShouldFocusProperty, value);
        }

        private static void OnShouldFocusChanged(BindableObject bindable, object oldValue, object newValue)
        {
            if (bindable is AutoFocusBehavior behavior && behavior._associatedEntry != null)
            {
                if ((bool)newValue)
                {
                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        behavior._associatedEntry.Focus();
                        // Tùy chọn: Cuộn ScrollView đến ô nhập liệu
                        if (behavior._associatedEntry.FindParentOfType<ScrollView>() is ScrollView scrollView)
                        {
                            scrollView.ScrollToAsync(behavior._associatedEntry, ScrollToPosition.End, true);
                        }
                    });
                }
            }
        }

        private Entry _associatedEntry;

        protected override void OnAttachedTo(Entry entry)
        {
            base.OnAttachedTo(entry);
            _associatedEntry = entry;
        }

        protected override void OnDetachingFrom(Entry entry)
        {
            base.OnDetachingFrom(entry);
            _associatedEntry = null;
        }
    }
}
