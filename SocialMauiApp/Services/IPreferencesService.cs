using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Services
{
    public interface IPreferencesService
    {
        bool GetBool(string key, bool defaultValue = false);
        void SetBool(string key, bool value);
        string GetString(string key, string defaultValue = "");
        void SetString(string key, string value);
        void Remove(string key);
        bool ContainsKey(string key);
        int GetInt(string key, int defaultValue = 0);
        void SetInt(string key, int value);
    }
}
