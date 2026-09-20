using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Services;

namespace SocialMauiApp.ViewModel
{
    public partial class SettingsViewModel : BaseViewModel
    {
        private readonly IPreferencesService _preferencesService;

        [ObservableProperty]
        private LanguageOption? _selectedLanguage;

        public IReadOnlyList<LanguageOption> Languages => LocalizationService.Instance.Languages;

        public LocalizationService Localization => LocalizationService.Instance;

        public SettingsViewModel(IPreferencesService preferencesService)
        {
            _preferencesService = preferencesService;

            var current = LocalizationService.Instance.Culture.TwoLetterISOLanguageName;
            _selectedLanguage = Languages.FirstOrDefault(l => l.Code == current) ?? Languages[0];
        }

        partial void OnSelectedLanguageChanged(LanguageOption? value)
        {
            if (value is null)
            {
                return;
            }

            LocalizationService.Instance.SetLanguage(value.Code);
            _preferencesService.SetString(LocalizationService.PreferenceKey, value.Code);
        }

        [RelayCommand]
        private async Task ApplyAsync()
        {
            await ToastAsync(LocalizationService.Instance.Get("Settings_LanguageChanged"));
        }
    }
}
