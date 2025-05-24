using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Refit;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class ResetPasswordViewModel : BaseViewModel
    {
        private readonly IAuthApi _authApi;

        public ResetPasswordViewModel(IAuthApi authApi)
        {
            _authApi = authApi;
            CheckNavigationParameters(); // Kiểm tra tham số khi khởi tạo
            IsRequestResetVisible = true; // Mặc định hiển thị phần 1
            IsResetPasswordVisible = false;
        }

        [ObservableProperty] private string _email;
        [ObservableProperty] private string _newPassword;
        [ObservableProperty] private string _confirmPassword;
        [ObservableProperty] private string _resetToken;
        [ObservableProperty] private bool _isRequestResetVisible;
        [ObservableProperty] private bool _isResetPasswordVisible;

        public void CheckNavigationParameters()
        {
            if (Parameters != null && Parameters.TryGetValue("resetToken", out object value) && value is string token)
            {
                ResetToken = token;
                IsRequestResetVisible = false;
                IsResetPasswordVisible = true;
            }
        }

        [RelayCommand]
        private async Task RequestResetAsync()
        {
            if (string.IsNullOrWhiteSpace(Email) || !IsValidGmail(Email))
            {
                await ShowErrorAlertAsync("Please enter a valid Gmail address");
                return;
            }

            await MakeApiCall(async () =>
            {
                var dto = new PasswordResetRequestDto { Email = Email };
                var result = await _authApi.RequestPasswordResetAsync(dto);
                if (result.IsSuccess)
                {
                    await ToastAsync($"A password reset link has been sent to {Email}. Please check your inbox (or spam folder).");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Failed to send reset link");
                }
            });
        }

        [RelayCommand]
        private async Task ResetPasswordAsync()
        {
            if (string.IsNullOrWhiteSpace(NewPassword) || string.IsNullOrWhiteSpace(ConfirmPassword) || string.IsNullOrWhiteSpace(ResetToken))
            {
                await ShowErrorAlertAsync("All fields are required");
                return;
            }

            if (NewPassword != ConfirmPassword)
            {
                await ShowErrorAlertAsync("Passwords do not match");
                return;
            }

            await MakeApiCall(async () =>
            {
                var dto = new ResetPasswordDto { Token = ResetToken, NewPassword = NewPassword };
                var result = await _authApi.ResetPasswordAsync(dto);
                if (result.IsSuccess)
                {
                    await ToastAsync("Password reset successfully. Please log in with your new password.");
                    await NavigateAsync($"//{nameof(LoginPage)}");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Failed to reset password");
                }
            });
        }

        private bool IsValidGmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;
            return email.ToLower().EndsWith("@gmail.com") && new System.Net.Mail.MailAddress(email).Address == email;
        }
    }
}