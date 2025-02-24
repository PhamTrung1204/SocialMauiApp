namespace SocialMediaMaui.Shared.Dtos
{
    public record LoggedInUser(Guid Id, string Name, string Email, string? PhotoUrl);
}
