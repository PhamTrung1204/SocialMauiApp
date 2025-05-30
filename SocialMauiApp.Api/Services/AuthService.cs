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
            _logger.LogInformation("Đang thử đăng ký người dùng với email: {Email}", dto.Email);

            var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (existingUser != null)
            {
                if (existingUser.EmailConfirmed)
                {
                    _logger.LogWarning("Đăng ký thất bại: Email {Email} đã tồn tại và được xác thực.", dto.Email);
                    return ApiResult<Guid>.Fail("Email đã tồn tại và đã xác thực. Vui lòng đăng nhập hoặc dùng email khác.");
                }

                _logger.LogInformation("Email {Email} tồn tại nhưng chưa xác thực. Gửi lại email xác minh.", dto.Email);
                var verificationToken = Guid.NewGuid().ToString();
                existingUser.VerificationToken = verificationToken;
                existingUser.VerificationTokenExpiry = DateTime.UtcNow.AddHours(48);
                await _context.SaveChangesAsync();

                _logger.LogDebug("Tạo mã xác minh cho email chưa xác thực {Email}: {Token}", dto.Email, verificationToken);
                await SendVerificationEmail(existingUser.Email, verificationToken);
                return ApiResult<Guid>.Fail($"Email đã tồn tại nhưng chưa xác thực. Email xác minh mới đã được gửi đến {dto.Email}.");
            }

            if (!dto.Email.ToLower().EndsWith("@gmail.com"))
            {
                _logger.LogWarning("Đăng ký thất bại: Email {Email} không phải địa chỉ Gmail.", dto.Email);
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

                _logger.LogDebug("Tạo mã xác minh cho người dùng mới {Email}: {Token}", user.Email, verificationToken);
                await SendVerificationEmail(user.Email, verificationToken);

                _logger.LogInformation("Người dùng {Email} đăng ký thành công với ID: {UserId}", user.Email, user.Id);
                return ApiResult<Guid>.Success(user.Id);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Đăng ký thất bại cho email {Email}.", dto.Email);
                return ApiResult<Guid>.Fail($"Đăng ký thất bại: {ex.Message}");
            }
        }

        public async Task<ApiResult> UploadPhotoAsync(Guid userId, IFormFile photo)
        {
            _logger.LogInformation("Đang thử tải ảnh lên cho người dùng ID: {UserId}", userId);

            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                _logger.LogWarning("Tải ảnh thất bại: Không tìm thấy người dùng ID {UserId}.", userId);
                return ApiResult.Fail("Không tìm thấy người dùng.");
            }

            try
            {
                var (photoPath, photoUrl) = await _photoUploadService.SavePhotoAsync(photo, "uploads", "images", "users");
                user.PhotoPath = photoPath;
                user.PhotoUrl = photoUrl;
                _context.Users.Update(user);
                await _context.SaveChangesAsync();

                _logger.LogInformation("Tải ảnh thành công cho người dùng ID: {UserId}", userId);
                return ApiResult.Success();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Tải ảnh thất bại cho người dùng ID {UserId}.", userId);
                return ApiResult.Fail($"Tải ảnh thất bại: {ex.Message}");
            }
        }

        public async Task<ApiResult<LoginResponseDto>> LoginAsync(LoginDto dto)
        {
            _logger.LogInformation("Đang thử đăng nhập cho email: {Email}", dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (user == null || user.IsLocked)
            {
                _logger.LogWarning("Đăng nhập thất bại: Thông tin không hợp lệ hoặc tài khoản bị khóa cho email {Email}.", dto.Email);
                return ApiResult<LoginResponseDto>.Fail("Thông tin không hợp lệ hoặc tài khoản bị khóa.");
            }

            var passwordVerificationResult = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.Password);
            if (passwordVerificationResult != PasswordVerificationResult.Success)
            {
                _logger.LogWarning("Đăng nhập thất bại: Mật khẩu không hợp lệ cho email {Email}.", dto.Email);
                return ApiResult<LoginResponseDto>.Fail("Thông tin không hợp lệ.");
            }

            if (!user.EmailConfirmed)
            {
                _logger.LogWarning("Đăng nhập thất bại: Email {Email} chưa được xác thực.", dto.Email);
                return ApiResult<LoginResponseDto>.Fail("Vui lòng xác thực email trước.");
            }

            var jwt = GenerateJwtToken(user);
            var refreshToken = GenerateRefreshToken();
            user.RefreshToken = refreshToken;
            user.RefreshTokenExpiry = DateTime.UtcNow.AddDays(_configuration.GetValue<int>("Jwt:RefreshTokenExpiryInDays", 30));
            await _context.SaveChangesAsync();

            var loggedInUser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);
            _logger.LogInformation("Đăng nhập thành công cho email: {Email}", dto.Email);
            return ApiResult<LoginResponseDto>.Success(new LoginResponseDto(loggedInUser, jwt, refreshToken));
        }

        public async Task<ApiResult<LoginResponseDto>> RefreshTokenAsync(RefreshTokenDto dto)
        {
            _logger.LogInformation("Đang thử làm mới token.");

            var user = await _context.Users.FirstOrDefaultAsync(u => u.RefreshToken == dto.RefreshToken);
            if (user == null || user.RefreshTokenExpiry < DateTime.UtcNow)
            {
                _logger.LogWarning("Refresh token không hợp lệ hoặc đã hết hạn.");
                return ApiResult<LoginResponseDto>.Fail("Refresh token không hợp lệ hoặc đã hết hạn.");
            }

            var jwt = GenerateJwtToken(user);
            var newRefreshToken = GenerateRefreshToken();
            user.RefreshToken = newRefreshToken;
            user.RefreshTokenExpiry = DateTime.UtcNow.AddDays(_configuration.GetValue<int>("Jwt:RefreshTokenExpiryInDays", 30));
            await _context.SaveChangesAsync();

            var loggedInUser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);
            _logger.LogInformation("Token được làm mới thành công cho người dùng: {Email}", user.Email);
            return ApiResult<LoginResponseDto>.Success(new LoginResponseDto(loggedInUser, jwt, newRefreshToken));
        }

        public async Task<ApiResult<LoggedInUser>> ValidateTokenAsync(string token)
        {
            _logger.LogInformation("Đang xác thực JWT token.");

            try
            {
                var secretKey = _configuration.GetValue<string>("Jwt:SecretKey");
                if (string.IsNullOrEmpty(secretKey))
                {
                    _logger.LogError("Xác thực JWT thất bại: Thiếu SecretKey trong cấu hình.");
                    return ApiResult<LoggedInUser>.Fail("Thiếu cấu hình JWT.");
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
                    _logger.LogWarning("Xác thực JWT thất bại: ID người dùng trong token không hợp lệ.");
                    return ApiResult<LoggedInUser>.Fail("Token không hợp lệ.");
                }

                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                {
                    _logger.LogWarning("Xác thực JWT thất bại: Không tìm thấy người dùng ID {UserId}.", userId);
                    return ApiResult<LoggedInUser>.Fail("Không tìm thấy người dùng.");
                }

                var loggedInUser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);
                _logger.LogInformation("Xác thực JWT thành công cho người dùng ID: {UserId}", userId);
                return ApiResult<LoggedInUser>.Success(loggedInUser);
            }
            catch (SecurityTokenExpiredException)
            {
                _logger.LogWarning("Xác thực JWT thất bại: Token đã hết hạn.");
                return ApiResult<LoggedInUser>.Fail("Token đã hết hạn.");
            }
            catch (SecurityTokenValidationException ex)
            {
                _logger.LogWarning(ex, "Xác thực JWT thất bại: Token không hợp lệ.");
                return ApiResult<LoggedInUser>.Fail("Token không hợp lệ.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi bất ngờ khi xác thực JWT.");
                return ApiResult<LoggedInUser>.Fail("Lỗi xác thực.");
            }
        }

        public async Task<ApiResult<string>> SendVerificationEmailAsync(SendVerificationEmailDto dto)
        {
            _logger.LogInformation("Yêu cầu gửi lại email xác minh cho: {Email}", dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (user == null || user.EmailConfirmed || string.IsNullOrEmpty(user.VerificationToken))
            {
                _logger.LogWarning("Gửi lại email xác minh thất bại: Yêu cầu không hợp lệ cho email {Email}.", dto.Email);
                return ApiResult<string>.Fail("Yêu cầu không hợp lệ.");
            }

            try
            {
                await SendVerificationEmail(user.Email, user.VerificationToken);
                _logger.LogInformation("Email xác minh được gửi lại thành công đến: {Email}", dto.Email);
                return ApiResult<string>.Success("Email xác minh đã được gửi.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Gửi lại email xác minh thất bại cho {Email}.", dto.Email);
                return ApiResult<string>.Fail($"Gửi email xác minh thất bại: {ex.Message}");
            }
        }

        public async Task<ApiResult<string>> VerifyEmailAsync(string token)
        {
            _logger.LogInformation("Đang thử xác minh email với mã: {Token}", token);

            if (string.IsNullOrWhiteSpace(token))
            {
                _logger.LogWarning("Mã xác minh rỗng hoặc không hợp lệ.");
                return ApiResult<string>.Fail("Mã xác minh không hợp lệ.");
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.VerificationToken == token);
            if (user == null)
            {
                _logger.LogWarning("Mã {Token} không tìm thấy trong cơ sở dữ liệu.", token);
                return ApiResult<string>.Fail("Mã xác minh không hợp lệ hoặc đã hết hạn.");
            }

            _logger.LogInformation("Tìm thấy mã. Người dùng: {Email}, Hết hạn: {Expiry}, Hiện tại UTC: {UtcNow}, EmailConfirmed: {EmailConfirmed}",
                user.Email, user.VerificationTokenExpiry, DateTime.UtcNow, user.EmailConfirmed);

            if (user.VerificationTokenExpiry.HasValue && user.VerificationTokenExpiry.Value < DateTime.UtcNow)
            {
                _logger.LogWarning("Mã hết hạn cho người dùng {Email}. Tạo mã mới.", user.Email);
                var newToken = Guid.NewGuid().ToString();
                user.VerificationToken = newToken;
                user.VerificationTokenExpiry = DateTime.UtcNow.AddHours(48);

                try
                {
                    await _context.SaveChangesAsync();
                    _logger.LogInformation("Mã mới {NewToken} được lưu cho người dùng {Email}.", newToken, user.Email);
                    await SendVerificationEmail(user.Email, newToken);
                    _logger.LogInformation("Email xác minh mới được gửi đến {Email} với mã {NewToken}.", user.Email, newToken);
                    return ApiResult<string>.Fail("Mã xác minh đã hết hạn. Email xác minh mới đã được gửi.");
                }
                catch (DbUpdateException ex)
                {
                    _logger.LogError(ex, "Cập nhật cơ sở dữ liệu thất bại cho mã mới của người dùng {Email}. Lỗi chi tiết: {Inner}", user.Email, ex.InnerException?.Message);
                    return ApiResult<string>.Fail("Xử lý mã hết hạn thất bại do lỗi cơ sở dữ liệu. Vui lòng thử lại.");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Lưu mã mới hoặc gửi email thất bại cho người dùng {Email}.", user.Email);
                    return ApiResult<string>.Fail("Xử lý mã hết hạn thất bại. Vui lòng thử lại.");
                }
            }

            if (user.EmailConfirmed)
            {
                _logger.LogWarning("Email của người dùng {Email} đã được xác thực.", user.Email);
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
                    _logger.LogInformation("Xác minh email thành công cho người dùng: {Email}. EmailConfirmed được đặt thành true. Lưu thay đổi: {Changes}", user.Email, changes);
                    return ApiResult<string>.Success("socialmauiapp://RegisterPage?verified=true");
                }
                else
                {
                    _logger.LogWarning("Không có thay đổi nào được lưu vào cơ sở dữ liệu cho người dùng {Email}.", user.Email);
                    return ApiResult<string>.Fail("Xác minh email thất bại: Không có thay đổi nào được lưu.");
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.LogError(ex, "Cập nhật cơ sở dữ liệu thất bại khi xác minh email cho người dùng {Email}. Lỗi chi tiết: {Inner}", user.Email, ex.InnerException?.Message);
                return ApiResult<string>.Fail("Xác minh email thất bại do lỗi cơ sở dữ liệu. Vui lòng thử lại.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lưu xác minh email thất bại cho người dùng {Email}.", user.Email);
                return ApiResult<string>.Fail("Xác minh email thất bại. Vui lòng thử lại.");
            }
        }

        public async Task<ApiResult<string>> RequestPasswordResetAsync(PasswordResetRequestDto dto)
        {
            _logger.LogInformation("Yêu cầu đặt lại mật khẩu cho email: {Email}", dto.Email);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email && u.EmailConfirmed);
            if (user == null)
            {
                _logger.LogWarning("Đặt lại mật khẩu thất bại: Không tìm thấy người dùng hoặc email chưa xác thực cho {Email}.", dto.Email);
                return ApiResult<string>.Fail("Không tìm thấy người dùng hoặc email chưa xác thực.");
            }

            var resetCode = GenerateResetCode();
            user.ResetToken = resetCode;
            user.ResetTokenExpiry = DateTime.UtcNow.AddHours(1);
            _context.Users.Update(user);

            var saveResult = await _context.SaveChangesAsync();
            if (saveResult <= 0)
            {
                _logger.LogError("Lưu ResetCode và ResetTokenExpiry thất bại cho email {Email}.", dto.Email);
                return ApiResult<string>.Fail("Lưu yêu cầu đặt lại thất bại. Vui lòng thử lại.");
            }

            _logger.LogInformation("ResetCode {ResetCode} và ResetTokenExpiry {Expiry} được lưu cho email {Email}", resetCode, user.ResetTokenExpiry, dto.Email);

            try
            {
                await SendResetPasswordEmail(user.Email, resetCode);
                _logger.LogInformation("Mã đặt lại mật khẩu được gửi đến: {Email}", dto.Email);
                return ApiResult<string>.Success("Mã đặt lại mật khẩu đã được gửi.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Gửi mã đặt lại mật khẩu thất bại cho {Email}.", dto.Email);
                return ApiResult<string>.Fail($"Gửi mã đặt lại thất bại: {ex.Message}");
            }
        }

        public async Task<ApiResult<string>> ResetPasswordAsync(ResetPasswordDto dto)
        {
            _logger.LogInformation("Đang thử đặt lại mật khẩu với mã: {Token}", dto.Token);

            var user = await _context.Users.FirstOrDefaultAsync(u => u.ResetToken == dto.Token && u.ResetTokenExpiry > DateTime.UtcNow);
            if (user == null)
            {
                _logger.LogWarning("Đặt lại mật khẩu thất bại: Mã không hợp lệ hoặc đã hết hạn {Token}.", dto.Token);
                return ApiResult<string>.Fail("Mã đặt lại không hợp lệ hoặc đã hết hạn.");
            }

            user.PasswordHash = _passwordHasher.HashPassword(user, dto.NewPassword);
            user.ResetToken = null;
            user.ResetTokenExpiry = null;

            _context.Users.Update(user);

            var saveResult = await _context.SaveChangesAsync();
            if (saveResult <= 0)
            {
                _logger.LogError("Lưu mật khẩu mới thất bại cho người dùng: {Email}. Không có thay đổi nào được lưu.", user.Email);
                return ApiResult<string>.Fail("Lưu mật khẩu mới thất bại. Vui lòng thử lại.");
            }

            _logger.LogInformation("Đặt lại mật khẩu thành công cho người dùng: {Email}", user.Email);
            return ApiResult<string>.Success("Đặt lại mật khẩu thành công.");
        }

        public async Task<ApiResult<string>> VerifyResetTokenAsync(string token)
        {
            _logger.LogInformation("Nhận yêu cầu xác minh mã đặt lại: {Token}", token);

            if (string.IsNullOrWhiteSpace(token) || token.Length != 6)
            {
                _logger.LogWarning("Định dạng mã đặt lại không hợp lệ: {Token}", token);
                return ApiResult<string>.Fail("Mã đặt lại không hợp lệ.");
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.ResetToken == token && u.ResetTokenExpiry > DateTime.UtcNow);
            if (user == null)
            {
                _logger.LogWarning("Mã đặt lại {Token} không tìm thấy hoặc đã hết hạn.", token);
                return ApiResult<string>.Fail("Mã đặt lại không hợp lệ hoặc đã hết hạn.");
            }

            _logger.LogInformation("Xác minh mã đặt lại thành công cho người dùng: {Email}.", user.Email);
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
                throw new InvalidOperationException("Thiếu cấu hình SMTP hoặc ứng dụng.");
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
                Subject = "Xác minh địa chỉ Email của bạn",
                Body = $@"<p>Chào mừng bạn đến với SocialMauiApp!</p>
                          <p>Vui lòng nhấp vào liên kết bên dưới để xác minh địa chỉ email của bạn:</p>
                          <p><a href=""{deepLink}"">Xác minh Email</a></p>
                          <p>Liên kết này sẽ hết hạn sau 48 giờ.</p>",
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

        private string GenerateRefreshToken()
        {
            var random = new Random();
            var bytes = new byte[32];
            random.NextBytes(bytes);
            return Convert.ToBase64String(bytes);
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
                _logger.LogError("Thiếu cấu hình SMTP.");
                throw new InvalidOperationException("Thiếu cấu hình SMTP.");
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
                Subject = "Đặt lại mật khẩu của bạn",
                Body = $@"<p>Bạn đã yêu cầu đặt lại mật khẩu cho SocialMauiApp!</p>
                          <p>Mã đặt lại của bạn là: <strong>{resetCode}</strong></p>
                          <p>Vui lòng sao chép mã này và nhập vào ứng dụng để đặt lại mật khẩu.</p>
                          <p>Mã này sẽ hết hạn sau 1 giờ.</p>",
                IsBodyHtml = true
            };
            mailMessage.To.Add(email);

            await smtpClient.SendMailAsync(mailMessage);
        }

        private string GenerateJwtToken(User user)
        {
            _logger.LogInformation("Tạo JWT token cho người dùng: {Email}", user.Email);

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
                _logger.LogError("Tạo JWT thất bại: SecretKey chưa được cấu hình.");
                throw new InvalidOperationException("SecretKey của JWT chưa được cấu hình.");
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
            _logger.LogDebug("Tạo JWT token thành công cho người dùng: {Email}", user.Email);
            return token;
        }
    }
}