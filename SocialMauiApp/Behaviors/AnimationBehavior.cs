using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Behaviors
{
    public class AnimationBehavior : Behavior<VisualElement>
    {
        public static readonly BindableProperty AnimationTypeProperty =
            BindableProperty.Create(nameof(AnimationType), typeof(string), typeof(AnimationBehavior), "Fade");

        public static readonly BindableProperty DurationProperty =
            BindableProperty.Create(nameof(Duration), typeof(int), typeof(AnimationBehavior), 300);

        public static readonly BindableProperty EasingTypeProperty =
            BindableProperty.Create(nameof(EasingType), typeof(string), typeof(AnimationBehavior), "SinInOut");

        public string AnimationType
        {
            get => (string)GetValue(AnimationTypeProperty);
            set => SetValue(AnimationTypeProperty, value);
        }

        public int Duration
        {
            get => (int)GetValue(DurationProperty);
            set => SetValue(DurationProperty, value);
        }

        public string EasingType
        {
            get => (string)GetValue(EasingTypeProperty);
            set => SetValue(EasingTypeProperty, value);
        }

        protected override void OnAttachedTo(VisualElement bindable)
        {
            base.OnAttachedTo(bindable);
            bindable.PropertyChanged += async (sender, e) =>
            {
                if (e.PropertyName == VisualElement.IsVisibleProperty.PropertyName && bindable.IsVisible)
                {
                    await AnimateIn(bindable);
                }
            };
        }

        private async Task AnimateIn(VisualElement element)
        {
            if (AnimationType == "Fade")
            {
                element.Opacity = 0;
                await element.FadeTo(1, (uint)Duration, GetEasingFunction());
            }
        }

        private Easing GetEasingFunction()
        {
            return EasingType switch
            {
                "Linear" => Easing.Linear,
                "SinInOut" => Easing.SinInOut,
                "CubicInOut" => Easing.CubicInOut,
                _ => Easing.SinInOut
            };
        }
    }
}
