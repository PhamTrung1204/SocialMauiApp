using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SocialMauiApp.Api.Services
{
    public class AuthService
    {
        private readonly DataContext _context;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly PhotoUploadService _photoUploadService;
        private readonly IConfiguration _configuration;
        private readonly ILogger<AuthService> _logger;

        public AuthService(DataContext context,
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
            if (await _context.Users.AnyAsync(u => u.Email == dto.Email))
            {
                return ApiResult<Guid>.Fail("User exists");
            }
            try
            {
                var user = new User
                {
                    Email = dto.Email,
                    Name = dto.Name,
                    Role = "Client" // Mặc định là "User", có thể thay bằng "Admin" nếu cần
                };
                user.PasswordHash = _passwordHasher.HashPassword(user, dto.Password);
                _context.Users.Add(user);
                await _context.SaveChangesAsync();
                return ApiResult<Guid>.Success(user.Id);
            }
            catch (Exception ex)
            {
                return ApiResult<Guid>.Fail(ex.Message);
            }
        }

        public async Task<ApiResult> UploadPhotoAsync(Guid userId, IFormFile photo)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user is null)
                return ApiResult.Fail("User does not exists");
            try
            {
                var (photoPath, photoUrl) = await _photoUploadService.SavePhotoAsync(photo, "uploads", "images", "users");
                user.PhotoPath = photoPath;
                user.PhotoUrl = photoUrl;
                _context.Users.Update(user);
                await _context.SaveChangesAsync();
                return ApiResult.Success();
            }
            catch (Exception e)
            {
                return ApiResult.Fail(e.Message);
            }
        }

        public async Task<ApiResult<LoginResponseDto>> LoginAsync(LoginDto dto)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == dto.Email);
            if (user is null)
            {
                return ApiResult<LoginResponseDto>.Fail("User does not exists");
            }
            if (user == null || user.IsLocked)
                return ApiResult<LoginResponseDto>.Fail("Invalid credentials or account locked.");
            var passwordVerificationResult = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.Password);
            if (passwordVerificationResult != PasswordVerificationResult.Success)
                return ApiResult<LoginResponseDto>.Fail("Invalid credentials");
            var jwt = GenerateJwtToken(user);
            var loggedInuser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);
            var loginResponse = new LoginResponseDto(loggedInuser, jwt);
            return ApiResult<LoginResponseDto>.Success(loginResponse);
        }

        public async Task<ApiResult<LoggedInUser>> ValidateTokenAsync(string token)
        {
            try
            {
                var secretKey = _configuration.GetValue<string>("Jwt:SecretKey");
                if (string.IsNullOrEmpty(secretKey))
                    return ApiResult<LoggedInUser>.Fail("JWT configuration missing");

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
                    return ApiResult<LoggedInUser>.Fail("Invalid token");

                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                    return ApiResult<LoggedInUser>.Fail("User not found");

                var loggedInUser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl, user.Role);
                return ApiResult<LoggedInUser>.Success(loggedInUser);
            }
            catch (SecurityTokenExpiredException)
            {
                return ApiResult<LoggedInUser>.Fail("Token expired");
            }
            catch (SecurityTokenValidationException)
            {
                return ApiResult<LoggedInUser>.Fail("Invalid token");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error validating token");
                return ApiResult<LoggedInUser>.Fail("Authentication error");
            }
        }

        private string GenerateJwtToken(User user)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Name, user.Name),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Role, user.Role ?? "Client") // Thêm claim Role từ user.Role
            };

            var secretKey = _configuration.GetValue<string>("Jwt:SecretKey");
            if (string.IsNullOrWhiteSpace(secretKey))
            {
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

            _logger.LogDebug("Generated JWT Token: {Token}", token);

            return token;
        }
    }
}