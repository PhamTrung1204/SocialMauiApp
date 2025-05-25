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
            IsRequestResetVisible = true;
            IsEnterCodeVisible = false;
            IsResetPasswordVisible = false;
            Console.WriteLine("ResetPasswordViewModel initialized with default visibility: IsRequestResetVisible=true, IsEnterCodeVisible=false, IsResetPasswordVisible=false");
        }

        [ObservableProperty] private string _email;
        [ObservableProperty] private string _newPassword;
        [ObservableProperty] private string _confirmPassword;
        [ObservableProperty] private string _resetToken;
        [ObservableProperty] private string _resetCode;
        partial void OnResetTokenChanged(string value)
        {
            Console.WriteLine($"ResetToken changed to: {value}");
            CheckNavigationParameters();
        }

        [ObservableProperty] private bool _isRequestResetVisible;
        [ObservableProperty] private bool _isEnterCodeVisible;
        [ObservableProperty] private bool _isResetPasswordVisible;

        public void CheckNavigationParameters()
        {
            if (!string.IsNullOrEmpty(ResetToken))
            {
                IsRequestResetVisible = false;
                IsEnterCodeVisible = false;
                IsResetPasswordVisible = true;
                Console.WriteLine($"ResetPasswordViewModel: ResetToken set: {ResetToken}, IsResetPasswordVisible: {IsResetPasswordVisible}");
            }
            else if (IsEnterCodeVisible)
            {
                IsRequestResetVisible = false;
                IsEnterCodeVisible = true;
                IsResetPasswordVisible = false;
                Console.WriteLine("ResetPasswordViewModel: Showing enter code form.");
            }
            else
            {
                IsRequestResetVisible = true;
                IsEnterCodeVisible = false;
                IsResetPasswordVisible = false;
                Console.WriteLine("ResetPasswordViewModel: Showing request reset form.");
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
                    IsRequestResetVisible = false;
                    IsEnterCodeVisible = true;
                    IsResetPasswordVisible = false;
                    await ToastAsync($"A reset code has been sent to {Email}. Please check your inbox (or spam folder).");
                    Email = string.Empty;
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Failed to send reset code");
                }
            });
        }

        [RelayCommand]
        private async Task VerifyCodeAsync()
        {
            if (string.IsNullOrWhiteSpace(ResetCode) || ResetCode.Length != 6)
            {
                await ShowErrorAlertAsync("Please enter a valid 6-character code");
                return;
            }

            await MakeApiCall(async () =>
            {
                Console.WriteLine($"Calling VerifyResetTokenAsync with code: {ResetCode}");
                var result = await _authApi.VerifyResetTokenAsync(ResetCode);
                Console.WriteLine($"VerifyResetTokenAsync result: IsSuccess={result.IsSuccess}, Data={result.Data}, Error={result.Error}");
                if (result.IsSuccess)
                {
                    ResetToken = ResetCode;
                    IsEnterCodeVisible = false;
                    IsResetPasswordVisible = true;
                    await ToastAsync("Code verified successfully. Please enter your new password.");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? "Invalid or expired code");
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
                    await Shell.Current.GoToAsync("//LoginPage");
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