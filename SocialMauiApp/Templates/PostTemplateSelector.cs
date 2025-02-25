using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Templates
{
    public class PostTemplateSelector : DataTemplateSelector
    {
        public DataTemplate WithImage { get; set; }
        public DataTemplate WithNoImage { get; set; }
        public DataTemplate ImageOnly { get; set; }
        protected override DataTemplate OnSelectTemplate(object item, BindableObject container)
        {
            if(item is PostDto post)
            {
                if(!string.IsNullOrWhiteSpace(post.PhotoUrl))
                {
                    return WithNoImage;
                }
                if(!string.IsNullOrWhiteSpace(post.Content))
                {
                    return ImageOnly;   
                }
                return WithImage;
            }
            return null;
        }
    }
}
