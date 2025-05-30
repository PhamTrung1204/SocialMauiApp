namespace SocialMauiApp.Api.Data.Entities
{
    public class User
    {
        public Guid Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string PasswordHash { get; set; }
        public string Role { get; set; }
        public bool EmailConfirmed { get; set; }
        public string? VerificationToken { get; set; }
        public DateTime? VerificationTokenExpiry { get; set; }
        public string? ResetToken { get; set; }
        public DateTime? ResetTokenExpiry { get; set; }
        public string? PhotoPath { get; set; }
        public string? PhotoUrl { get; set; }
        public bool IsLocked { get; set; }
        public string? RefreshToken { get; set; }
        public DateTime? RefreshTokenExpiry { get; set; }
    }
}