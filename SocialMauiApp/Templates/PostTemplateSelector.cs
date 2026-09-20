using SocialMauiApp.Models;

namespace SocialMauiApp.Templates
{
    public class PostTemplateSelector : DataTemplateSelector
    {
        public DataTemplate WithImage { get; set; }
        public DataTemplate WithNoImage { get; set; }
        public DataTemplate ImageOnly { get; set; }

        protected override DataTemplate OnSelectTemplate(object item, BindableObject container)
        {
            if (item is not PostModel post)
            {
                return null;
            }

            // Ảnh và video dùng chung template: bên trong template tự chọn
            // hiển thị Image hay MediaElement theo HasPhoto / HasVideo.
            if (!post.HasPhoto && !post.HasVideo)
            {
                return WithNoImage;
            }
            if (string.IsNullOrWhiteSpace(post.Content))
            {
                return ImageOnly;
            }
            return WithImage;
        }
    }
}
