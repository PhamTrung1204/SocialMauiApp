using SocialMauiApp.Services;

namespace SocialMauiApp.Extensions
{
    // Dùng trong XAML:  Text="{ext:Translate Login_SignIn}"
    // Trả về Binding tới indexer của LocalizationService nên chuỗi tự đổi
    // ngay khi người dùng chọn ngôn ngữ khác, không cần khởi động lại app.
    [ContentProperty(nameof(Key))]
    public class TranslateExtension : IMarkupExtension<BindingBase>
    {
        public string Key { get; set; } = string.Empty;

        public BindingBase ProvideValue(IServiceProvider serviceProvider) =>
            new Binding
            {
                Mode = BindingMode.OneWay,
                Path = $"[{Key}]",
                Source = LocalizationService.Instance
            };

        object IMarkupExtension.ProvideValue(IServiceProvider serviceProvider) =>
            ProvideValue(serviceProvider);
    }
}
