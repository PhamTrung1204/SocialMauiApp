using SocialMediaMaui.Shared.Dtos;
using System;
using System.Text.Json;
using Microsoft.Maui.Storage;

namespace SocialMauiApp.Services
{
    public class AuthService
    {
        private const string UserDataKey = "udata";

        public AuthService()
        {
            Initialize();
        }

        public string? Token { get; private set; }
        public string? RefreshToken { get; private set; }
        public LoggedInUser? User { get; private set; }
        public bool IsLoggedIn => User is not null && User.Id != default && !string.IsNullOrWhiteSpace(Token);

        /// <summary>
        /// Thực hiện đăng nhập, lưu thông tin người dùng, JWT và refresh token vào Preferences và SecureStorage.
        /// </summary>
        /// <param name="loginResponseDto">Đối tượng chứa thông tin người dùng, JWT và refresh token.</param>
        public void Login(LoginResponseDto loginResponseDto)
        {
            User = loginResponseDto.User;
            Token = loginResponseDto.Token;
            RefreshToken = loginResponseDto.RefreshToken;

            var serializedData = JsonSerializer.Serialize(loginResponseDto);
            Preferences.Default.Set(UserDataKey, serializedData);
        }

        /// <summary>
        /// Thực hiện đăng xuất, xóa thông tin người dùng, JWT và refresh token.
        /// </summary>
        public void Logout()
        {
            User = null;
            Token = null;
            RefreshToken = null;
            Preferences.Default.Remove(UserDataKey);
            SecureStorage.Remove("AuthToken");
            SecureStorage.Remove("RefreshToken");
        }

        /// <summary>
        /// Khởi tạo AuthService bằng cách đọc dữ liệu đã lưu trong Preferences (nếu có).
        /// </summary>
        public void Initialize()
        {
            var serializedData = Preferences.Default.Get<string?>(UserDataKey, null);
            if (!string.IsNullOrWhiteSpace(serializedData))
            {
                try
                {
                    var loginResponse = JsonSerializer.Deserialize<LoginResponseDto>(serializedData);
                    if (loginResponse != null && loginResponse.User is not null && loginResponse.User.Id != default)
                    {
                        User = loginResponse.User;
                        Token = loginResponse.Token;
                        RefreshToken = loginResponse.RefreshToken;
                    }
                    else
                    {
                        Preferences.Default.Remove(UserDataKey);
                    }
                }
                catch (Exception)
                {
                    Preferences.Default.Remove(UserDataKey);
                }
            }
        }
    }
}