using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Extensions
{
    public static class VisualElementExtensions
    {
        public static T FindParentOfType<T>(this VisualElement element) where T : VisualElement
        {
            var parent = element?.Parent;
            while (parent != null)
            {
                if (parent is T matchingParent)
                {
                    return matchingParent;
                }
                parent = parent.Parent;
            }
            return null;
        }
    }
}
