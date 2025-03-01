namespace SocialMediaMaui.Shared.Dtos
{
    public record LoggedInUser(Guid Id, string Name, string Email, string? PhotoUrl)
    {
        public string Photo => string.IsNullOrWhiteSpace(PhotoUrl)?"personal.png": PhotoUrl;
    }
}
