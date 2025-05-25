using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Net.Mail;
using System.Threading.Tasks;

namespace SocialMauiApp.Api.Services
{
    public class AuthService
    {
        private readonly DataContext _context;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly PhotoUploadService _photoUploadService;
        private readonly IConfiguration _configuration;
        private readonly ILogger<AuthService> _logger;

        public AuthService(
            DataContext context,
            IPasswordHasher<User> passwordHasher,
            PhotoUploadService photoUploadService,
            IConfiguration configuration,
            ILogger<AuthService> logger)
        {
            _context = context;
            _passwordHasher = passwordHasher;
            _photoUploadService = photoUploadService;
            _configuration = configuration;
            _logger = logger;
        }

        public async Task<ApiResult<Guid>> RegisterAsync(RegisterDto dto)
        {
            _logger.LogInformation("Attempting to register user with email: {Email}", dto.Email);

            var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (existingUser != null)
            {
                if (existingUser.EmailConfirmed)
                {
                    _logger.LogWarning("Registration failed: Email {Email} already exists and is confirmed.", dto.Email);
                    return ApiResult<Guid>.Fail("Email đã tồn tại và đã xác thực. Vui lòng đăng nhập hoặc dùng email khác.");
                }

                _logger.LogInformation("Email {Email} exists but not confirmed. Resending verification email.", dto.Email);
                var verificationToken = Guid.NewGuid().ToString();
                existingUser.VerificationToken = verificationToken;
                existingUser.VerificationTokenExpiry = DateTime.UtcNow.AddHours(48);
                await _context.SaveChangesAsync();

                _logger.LogDebug("Generated verification token for unconfirmed email {Email}: {Token}", dto.Email, verificationToken);
                await SendVerificationEmail(existingUser.Email, verificationToken);
                return ApiResult<Guid>.Fail($"Email đã tồn tại nhưng chưa xác thực. Email xác minh mới đã được gửi đến {dto.Email}.");
            }

            if (!dto.Email.ToLower().EndsWith("@gmail.com"))
            {
                _logger.LogWarning("Registration failed: Email {Email} is not a Gmail address.", dto.Email);
                return ApiResult<Guid>.Fail("Vui lòng sử dụng địa chỉ Gmail.");
            }

            try
            {
                var user = new User
                {
                    Email = dto.Email,
                    Name = dto.Name,
                    Role = "Client",
                    EmailConfirmed = false
                };
                user.PasswordHash = _passwordHasher.HashPassword(user, dto.Password);
                _context.Users.Add(user);
                await _context.SaveChangesAsync();

                var verificationToken = Guid.NewGuid().ToString();
                user.VerificationToken = verificationToken;
                user.VerificationTokenExpiry = DateTime.UtcNow.AddHours(48);
                await _context.SaveChangesAsync();

                _logger.LogDebug("Generated verification token for new user {Email}: {Token}", user.Email, verificationToken);
                await SendVerificationEmail(user.Email, verificationToken);

                _logger.LogInformation("User {Email} registered successfully with ID: {UserId}", user.Email, user.Id);
                return ApiResult<Guid>.Success(user.Id);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Registration failed for email {Email}.", dto.Email);
                return ApiResult<Guid>.Fail($"Đăng ký thất bại: {ex.Message}");
            }
        }

        public async Task<ApiResult> UploadPhotoAsync(Guid userId, IFormFile photo)
        {
            _logger.LogInformation("Attempting to upload photo for user ID: {UserId}", userId);

            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                _logger.LogWarning("Photo upload failed: User ID {UserId} not found.", userId);
                return ApiResult.Fail("User not found.");
            }

            try
            {
                var (photoPath, photoUrl) = await _photoUploadService.SavePhotoAsync(photo, "uploads", "images", "users");
                user.PhotoPath = photoPath;
                user.PhotoUrl = photoUrl;
                _context.Users.Update(user);
                await _context.SaveChangesAsync();

                _logger.LogInformation("Photo uploaded successfully for user ID: {UserId}", userId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Photo upload failed for user ID {UserId}.", userId);
                return ApiResult.Fail($"Photo upload failed: {ex.Message}");
            }
        }

        public async Task<ApiResult<LoginResponseDto>> LoginAsync(LoginDto dto)
        {
            _logger.LogInformation("Attempting login for email: {Email}", dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (user == null || user.IsLocked)
            {
                _logger.LogWarning("Login failed: Invalid credentials or account locked for email {Email}.", dto.Email);
                return ApiResult<LoginResponseDto>.Fail("Invalid credentials or account locked.");
            }

            var passwordVerificationResult = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.Password);
            if (passwordVerificationResult != PasswordVerificationResult.Success)
            {
                _logger.LogWarning("Login failed: Invalid password for email {Email}.", dto.Email);
                return ApiResult<LoginResponseDto>.Fail("Invalid credentials.");
            }

            if (!user.EmailConfirmed)
            {
                _logger.LogWarning("Login failed: Email {Email} not confirmed.", dto.Email);
                return ApiResult<LoginResponseDto>.Fail("Please confirm your email first.");
            }

            var jwt = GenerateJwtToken(user);
            var loggedInUser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);

            _logger.LogInformation("Login successful for email: {Email}", dto.Email);
            return ApiResult<LoginResponseDto>.Success(new LoginResponseDto(loggedInUser, jwt));
        }

        public async Task<ApiResult<LoggedInUser>> ValidateTokenAsync(string token)
        {
            _logger.LogInformation("Validating JWT token.");

            try
            {
                var secretKey = _configuration.GetValue<string>("Jwt:SecretKey");
                if (string.IsNullOrEmpty(secretKey))
                {
                    _logger.LogError("JWT validation failed: SecretKey is missing in configuration.");
                    return ApiResult<LoggedInUser>.Fail("JWT configuration missing.");
                }

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.UTF8.GetBytes(secretKey);

                var validationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = true,
                    ValidIssuer = _configuration.GetValue<string>("Jwt:Issuer") ?? "default-issuer",
                    ValidateAudience = false,
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };

                var principal = tokenHandler.ValidateToken(token, validationParameters, out _);

                var userIdClaim = principal.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                if (string.IsNullOrEmpty(userIdClaim) || !Guid.TryParse(userIdClaim, out var userId))
                {
                    _logger.LogWarning("JWT validation failed: Invalid user ID in token.");
                    return ApiResult<LoggedInUser>.Fail("Invalid token.");
                }

                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                {
                    _logger.LogWarning("JWT validation failed: User ID {UserId} not found.", userId);
                    return ApiResult<LoggedInUser>.Fail("User not found.");
                }

                var loggedInUser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);
                _logger.LogInformation("JWT token validated successfully for user ID: {UserId}", userId);
                return ApiResult<LoggedInUser>.Success(loggedInUser);
            }
            catch (SecurityTokenExpiredException)
            {
                _logger.LogWarning("JWT validation failed: Token has expired.");
                return ApiResult<LoggedInUser>.Fail("Token expired.");
            }
            catch (SecurityTokenValidationException ex)
            {
                _logger.LogWarning(ex, "JWT validation failed: Invalid token.");
                return ApiResult<LoggedInUser>.Fail("Invalid token.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error during JWT validation.");
                return ApiResult<LoggedInUser>.Fail("Authentication error.");
            }
        }

        public async Task<ApiResult<string>> SendVerificationEmailAsync(SendVerificationEmailDto dto)
        {
            _logger.LogInformation("Request to resend verification email for: {Email}", dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (user == null || user.EmailConfirmed || string.IsNullOrEmpty(user.VerificationToken))
            {
                _logger.LogWarning("Resend verification email failed: Invalid request for email {Email}.", dto.Email);
                return ApiResult<string>.Fail("Invalid request.");
            }

            try
            {
                await SendVerificationEmail(user.Email, user.VerificationToken);
                _logger.LogInformation("Verification email resent successfully to: {Email}", dto.Email);
                return ApiResult<string>.Success("Verification email sent.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to resend verification email to {Email}.", dto.Email);
                return ApiResult<string>.Fail($"Failed to send verification email: {ex.Message}");
            }
        }

        public async Task<ApiResult<string>> VerifyEmailAsync(string token)
        {
            _logger.LogInformation("Attempting to verify email with token: {Token}", token);

            if (string.IsNullOrWhiteSpace(token))
            {
                _logger.LogWarning("Token is null or empty.");
                return ApiResult<string>.Fail("Invalid token.");
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.VerificationToken == token);
            if (user == null)
            {
                _logger.LogWarning("Token {Token} not found in database.", token);
                return ApiResult<string>.Fail("Invalid or expired verification token.");
            }

            _logger.LogInformation("Token found. User: {Email}, Expiry: {Expiry}, Current UTC: {UtcNow}, EmailConfirmed: {EmailConfirmed}",
                user.Email, user.VerificationTokenExpiry, DateTime.UtcNow, user.EmailConfirmed);

            if (user.VerificationTokenExpiry.HasValue && user.VerificationTokenExpiry.Value < DateTime.UtcNow)
            {
                _logger.LogWarning("Token expired for user {Email}. Generating new token.", user.Email);
                var newToken = Guid.NewGuid().ToString();
                user.VerificationToken = newToken;
                user.VerificationTokenExpiry = DateTime.UtcNow.AddHours(48);

                try
                {
                    await _context.SaveChangesAsync();
                    _logger.LogInformation("New token {NewToken} saved for user {Email}.", newToken, user.Email);
                    await SendVerificationEmail(user.Email, newToken);
                    _logger.LogInformation("New verification email sent to {Email} with token {NewToken}.", user.Email, newToken);
                    return ApiResult<string>.Fail("Verification token has expired. A new verification email has been sent.");
                }
                catch (DbUpdateException ex)
                {
                    _logger.LogError(ex, "Database update failed for new token for user {Email}. Inner Exception: {Inner}", user.Email, ex.InnerException?.Message);
                    return ApiResult<string>.Fail("Failed to process expired token due to database error. Please try again.");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Failed to save new token or send email for user {Email}.", user.Email);
                    return ApiResult<string>.Fail("Failed to process expired token. Please try again.");
                }
            }

            if (user.EmailConfirmed)
            {
                _logger.LogWarning("Email for user {Email} is already confirmed.", user.Email);
                return ApiResult<string>.Success("socialmauiapp://RegisterPage?verified=true");
            }

            user.EmailConfirmed = true;
            user.VerificationToken = null;
            user.VerificationTokenExpiry = null;

            try
            {
                _context.Users.Update(user);
                var changes = await _context.SaveChangesAsync();
                if (changes > 0)
                {
                    _logger.LogInformation("Email verified successfully for user: {Email}. EmailConfirmed set to true. Changes saved: {Changes}", user.Email, changes);
                    return ApiResult<string>.Success("socialmauiapp://RegisterPage?verified=true");
                }
                else
                {
                    _logger.LogWarning("No changes were saved to the database for user {Email}.", user.Email);
                    return ApiResult<string>.Fail("Failed to verify email: No changes were saved.");
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.LogError(ex, "Database update failed for email confirmation for user {Email}. Inner Exception: {Inner}", user.Email, ex.InnerException?.Message);
                return ApiResult<string>.Fail("Failed to verify email due to database error. Please try again.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to save email confirmation for user {Email}.", user.Email);
                return ApiResult<string>.Fail("Failed to verify email. Please try again.");
            }
        }

        public async Task<ApiResult<string>> RequestPasswordResetAsync(PasswordResetRequestDto dto)
        {
            _logger.LogInformation("Password reset requested for email: {Email}", dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email && u.EmailConfirmed);
            if (user == null)
            {
                _logger.LogWarning("Password reset failed: User not found or not confirmed for email {Email}.", dto.Email);
                return ApiResult<string>.Fail("User not found or not confirmed.");
            }

            var resetCode = GenerateResetCode();
            user.ResetToken = resetCode;
            user.ResetTokenExpiry = DateTime.UtcNow.AddHours(1);
            _context.Users.Update(user);

            var saveResult = await _context.SaveChangesAsync();
            if (saveResult <= 0)
            {
                _logger.LogError("Failed to save ResetCode and ResetTokenExpiry for email {Email}.", dto.Email);
                return ApiResult<string>.Fail("Failed to save reset request. Please try again.");
            }

            _logger.LogInformation("ResetCode {ResetCode} and ResetTokenExpiry {Expiry} saved for email {Email}", resetCode, user.ResetTokenExpiry, dto.Email);

            try
            {
                await SendResetPasswordEmail(user.Email, resetCode);
                _logger.LogInformation("Password reset code sent to: {Email}", dto.Email);
                return ApiResult<string>.Success("Password reset code sent.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send password reset code to {Email}.", dto.Email);
                return ApiResult<string>.Fail($"Failed to send reset code: {ex.Message}");
            }
        }

        public async Task<ApiResult<string>> ResetPasswordAsync(ResetPasswordDto dto)
        {
            _logger.LogInformation("Attempting to reset password with code: {Token}", dto.Token);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.ResetToken == dto.Token && u.ResetTokenExpiry > DateTime.UtcNow);
            if (user == null)
            {
                _logger.LogWarning("Password reset failed: Invalid or expired code {Token}.", dto.Token);
                return ApiResult<string>.Fail("Invalid or expired reset code.");
            }

            user.PasswordHash = _passwordHasher.HashPassword(user, dto.NewPassword);
            user.ResetToken = null;
            user.ResetTokenExpiry = null;

            // Đảm bảo EF theo dõi thay đổi
            _context.Users.Update(user);

            var saveResult = await _context.SaveChangesAsync();
            if (saveResult <= 0)
            {
                _logger.LogError("Failed to save new password for user: {Email}. No changes were saved to the database.", user.Email);
                return ApiResult<string>.Fail("Failed to save new password. Please try again.");
            }

            _logger.LogInformation("Password reset successfully for user: {Email}", user.Email);
            return ApiResult<string>.Success("Password reset successfully.");
        }
        public async Task<ApiResult<string>> VerifyResetTokenAsync(string token)
        {
            _logger.LogInformation("Received request to verify reset code: {Token}", token);

            if (string.IsNullOrWhiteSpace(token) || token.Length != 6)
            {
                _logger.LogWarning("Invalid reset code format: {Token}", token);
                return ApiResult<string>.Fail("Invalid reset code.");
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.ResetToken == token && u.ResetTokenExpiry > DateTime.UtcNow);
            if (user == null)
            {
                _logger.LogWarning("Reset code {Token} not found or expired.", token);
                return ApiResult<string>.Fail("Invalid or expired reset code.");
            }

            _logger.LogInformation("Reset code verified successfully for user: {Email}.", user.Email);
            return ApiResult<string>.Success(token);
        }

        private async Task SendVerificationEmail(string email, string token)
        {
            var senderEmail = _configuration.GetValue<string>("SmtpSettings:SenderEmail");
            var appPassword = _configuration.GetValue<string>("SmtpSettings:AppPassword");
            var host = _configuration.GetValue<string>("SmtpSettings:Host");
            var port = _configuration.GetValue<int>("SmtpSettings:Port");
            var enableSsl = _configuration.GetValue<bool>("SmtpSettings:EnableSsl");
            var baseUrl = _configuration.GetValue<string>("AppSettings:BaseUrl");

            if (string.IsNullOrEmpty(senderEmail) || string.IsNullOrEmpty(appPassword) || string.IsNullOrEmpty(baseUrl))
            {
                throw new InvalidOperationException("SMTP or application configuration is missing.");
            }

            using var smtpClient = new SmtpClient(host)
            {
                Port = port,
                Credentials = new System.Net.NetworkCredential(senderEmail, appPassword),
                EnableSsl = enableSsl
            };

            var deepLink = $"{baseUrl}/api/auth/verify-email?token={token}";
            using var mailMessage = new MailMessage
            {
                From = new MailAddress(senderEmail),
                Subject = "Confirm Your Email Address",
                Body = $@"<p>Welcome to SocialMauiApp!</p>
                          <p>Please click the link below to confirm your email address:</p>
                          <p><a href=""{deepLink}"">Verify Email</a></p>
                          <p>This link will expire in 48 hours.</p>",
                IsBodyHtml = true
            };
            mailMessage.To.Add(email);

            await smtpClient.SendMailAsync(mailMessage);
        }

        private string GenerateResetCode()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            return new string(Enumerable.Repeat(chars, 6)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        private async Task SendResetPasswordEmail(string email, string resetCode)
        {
            var senderEmail = _configuration.GetValue<string>("SmtpSettings:SenderEmail");
            var appPassword = _configuration.GetValue<string>("SmtpSettings:AppPassword");
            var host = _configuration.GetValue<string>("SmtpSettings:Host");
            var port = _configuration.GetValue<int>("SmtpSettings:Port");
            var enableSsl = _configuration.GetValue<bool>("SmtpSettings:EnableSsl");

            if (string.IsNullOrEmpty(senderEmail) || string.IsNullOrEmpty(appPassword))
            {
                _logger.LogError("SMTP configuration missing.");
                throw new InvalidOperationException("SMTP configuration is missing.");
            }

            using var smtpClient = new SmtpClient(host)
            {
                Port = port,
                Credentials = new System.Net.NetworkCredential(senderEmail, appPassword),
                EnableSsl = enableSsl
            };

            using var mailMessage = new MailMessage
            {
                From = new MailAddress(senderEmail),
                Subject = "Reset Your Password",
                Body = $@"<p>You requested a password reset for SocialMauiApp!</p>
                          <p>Your reset code is: <strong>{resetCode}</strong></p>
                          <p>Please copy this code and enter it in the app to reset your password.</p>
                          <p>This code will expire in 1 hour.</p>",
                IsBodyHtml = true
            };
            mailMessage.To.Add(email);

            await smtpClient.SendMailAsync(mailMessage);
        }


        private string GenerateJwtToken(User user)
        {
            _logger.LogInformation("Generating JWT token for user: {Email}", user.Email);

            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Name, user.Name),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Role, user.Role ?? "Client")
            };

            var secretKey = _configuration.GetValue<string>("Jwt:SecretKey");
            if (string.IsNullOrWhiteSpace(secretKey))
            {
                _logger.LogError("JWT generation failed: SecretKey is not configured.");
                throw new InvalidOperationException("JWT SecretKey is not configured.");
            }

            var securityKey = Encoding.UTF8.GetBytes(secretKey);
            var symmetricKey = new SymmetricSecurityKey(securityKey);
            var signingCredentials = new SigningCredentials(symmetricKey, SecurityAlgorithms.HmacSha256);

            var issuer = _configuration.GetValue<string>("Jwt:Issuer") ?? "default-issuer";
            var expireInMinutes = _configuration.GetValue<int>("Jwt:ExpireInMinutes", 720);

            var jwtSecurityToken = new JwtSecurityToken(
                issuer: issuer,
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(expireInMinutes),
                signingCredentials: signingCredentials);

            var token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
            _logger.LogDebug("JWT token generated successfully for user: {Email}", user.Email);
            return token;
        }
    }
}