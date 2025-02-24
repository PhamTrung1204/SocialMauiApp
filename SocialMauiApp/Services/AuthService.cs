using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace SocialMauiApp.Services
{
    public class AuthService
    {
        private const string UserDataKey = "udata";
        public string? Token { get; set; }
        public LoggedInUser? User { get; set; }
        public bool IsLoggedIn => User is not null && User.Id != default && !string.IsNullOrWhiteSpace(Token);
        public void Login(LoginResponseDto loginResponseDto)
        {
            (User, Token) = loginResponseDto;
            Preferences.Default.Set(UserDataKey, JsonSerializer.Serialize(loginResponseDto));
        }
        public void Logout()
        {
            (User, Token) = (null, null);   
            Preferences.Default.Remove(UserDataKey);
        }
        public void Initialize()
        {
            var udata = Preferences.Default.Get<string?>(UserDataKey, null);
            if(!string.IsNullOrWhiteSpace(udata))
            {
                var loginResponse = JsonSerializer.Deserialize<LoginResponseDto>(udata);
                if(loginResponse != null && loginResponse.User is not null && loginResponse.User.Id != default)
                {
                    (User, Token) = loginResponse;
                }
                else
                {
                    Preferences.Default.Remove(UserDataKey);
                }
            }
        }
    }
}
