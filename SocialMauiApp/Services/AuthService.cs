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
        public LoggedInUser? User { get; private set; }
        public bool IsLoggedIn => User is not null && User.Id != default && !string.IsNullOrWhiteSpace(Token);

        /// <summary>
        /// Thực hiện đăng nhập, lưu thông tin người dùng và token vào Preferences.
        /// </summary>
        /// <param name="loginResponseDto">Đối tượng chứa thông tin người dùng và token.</param>
        public void Login(LoginResponseDto loginResponseDto)
        {
            // Gán các giá trị từ loginResponseDto
            User = loginResponseDto.User;
            Token = loginResponseDto.Token;

            // Lưu dữ liệu dưới dạng JSON
            var serializedData = JsonSerializer.Serialize(loginResponseDto);
            Preferences.Default.Set(UserDataKey, serializedData);
        }

        /// <summary>
        /// Thực hiện đăng xuất, xóa thông tin người dùng và token.
        /// </summary>
        public void Logout()
        {
            User = null;
            Token = null;
            Preferences.Default.Remove(UserDataKey);
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
                    }
                    else
                    {
                        // Dữ liệu không hợp lệ, xóa Preferences
                        Preferences.Default.Remove(UserDataKey);
                    }
                }
                catch (Exception)
                {
                    // Nếu có lỗi khi deserialize, xóa dữ liệu đã lưu
                    Preferences.Default.Remove(UserDataKey);
                }
            }
        }
    }
}
