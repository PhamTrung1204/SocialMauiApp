using System.ComponentModel;
using System.Globalization;
using System.Resources;

namespace SocialMauiApp.Services
{
    public class LocalizationService : INotifyPropertyChanged
    {
        public const string PreferenceKey = "AppLanguage";
        public const string DefaultLanguage = "en";

        private static readonly ResourceManager Resources =
            new("SocialMauiApp.Resources.Strings.AppResources", typeof(LocalizationService).Assembly);

        public static LocalizationService Instance { get; } = new();

        public event PropertyChangedEventHandler? PropertyChanged;

        private CultureInfo _culture = new(DefaultLanguage);

        public CultureInfo Culture => _culture;

        public IReadOnlyList<LanguageOption> Languages { get; } =
        [
            new LanguageOption("en", "English"),
            new LanguageOption("vi", "Tiếng Việt")
        ];

        // Indexer cho phép XAML bind {Binding [Key]} và cập nhật ngay khi đổi ngôn ngữ.
        public string this[string key] => Resources.GetString(key, _culture) ?? key;

        public string Get(string key) => this[key];

        public string Format(string key, params object?[] args) =>
            string.Format(_culture, this[key], args);

        public void SetLanguage(string languageCode)
        {
            if (string.IsNullOrWhiteSpace(languageCode) || languageCode == _culture.TwoLetterISOLanguageName)
            {
                return;
            }

            try
            {
                _culture = new CultureInfo(languageCode);
            }
            catch (CultureNotFoundException)
            {
                _culture = new CultureInfo(DefaultLanguage);
            }

            CultureInfo.DefaultThreadCurrentCulture = _culture;
            CultureInfo.DefaultThreadCurrentUICulture = _culture;
            Thread.CurrentThread.CurrentCulture = _culture;
            Thread.CurrentThread.CurrentUICulture = _culture;

            // Indexer rỗng => mọi binding tới indexer đều được làm mới.
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Item[]"));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Culture)));
        }
    }

    public record LanguageOption(string Code, string DisplayName);
}
