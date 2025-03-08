using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace SocialMauiApp.Api.Services
{
    public class AuthService
    {
        private readonly DataContext _context;
        private readonly IPasswordHasher<User> _passwordHasher;

        private readonly PhotoUploadService _photoUploadService;
        private readonly IConfiguration _configuration;

        public AuthService(DataContext context,
            IPasswordHasher<User> passwordHasher,
            PhotoUploadService photoUploadService,
            IConfiguration configuration)
        {
            _context = context;
            _passwordHasher = passwordHasher;
            _photoUploadService = photoUploadService;
            _configuration = configuration;
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
                    Name = dto.Name
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
            var passwordVerificationResult = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.Password);
            if (passwordVerificationResult != PasswordVerificationResult.Success)
                return ApiResult<LoginResponseDto>.Fail("Invail credentials");
            var jwt = GenerateJwtToken(user);
            var loggedInuser = new LoggedInUser(user.Id, user.Name, user.Email, user.PhotoUrl);
            var loginResponse = new LoginResponseDto(loggedInuser, jwt);
            return ApiResult<LoginResponseDto>.Success(loginResponse);
        }
        private string GenerateJwtToken(User user)
        {
            var claims = new[]
{
    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
    new Claim(ClaimTypes.Name, user.Name),
    new Claim(ClaimTypes.Email, user.Email),
    new Claim("UserPhotoUrl", user.PhotoUrl ?? string.Empty)
};

            var secretKey = _configuration.GetValue<string>("Jwt:SecretKey");
            var securityKey = System.Text.Encoding.UTF8.GetBytes(secretKey);
            var symmetricKey = new SymmetricSecurityKey(securityKey);
            var signingCredentials = new SigningCredentials(symmetricKey, SecurityAlgorithms.HmacSha256);
            var jwtSecurityToken = new JwtSecurityToken(signingCredentials: signingCredentials,
                issuer: _configuration.GetValue<string>("Jwt:Issuer"),
                expires: DateTime.UtcNow.AddMinutes(_configuration.GetValue<int>("Jwt:ExpireInMinutes")),
                claims: claims);
            var jwt = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
            return jwt;
        }
    }
}