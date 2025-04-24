using System;

namespace SocialMauiApp.Services
{
    public class PreferencesService : IPreferencesService
    {
        public bool GetBool(string key, bool defaultValue = false)
        {
            return Preferences.Default.Get(key, defaultValue);
        }

        public void SetBool(string key, bool value)
        {
            Preferences.Default.Set(key, value);
        }

        public string GetString(string key, string defaultValue = "")
        {
            return Preferences.Default.Get(key, defaultValue);
        }

        public void SetString(string key, string value)
        {
            Preferences.Default.Set(key, value);
        }

        public void Remove(string key)
        {
            Preferences.Default.Remove(key);
        }

        public bool ContainsKey(string key)
        {
            return Preferences.Default.ContainsKey(key);
        }
    }
}