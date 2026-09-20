namespace SocialMediaMaui.Shared.Dtos
{
    public class FriendshipDto
    {
        public Guid UserId { get; set; }
        public Guid FriendId { get; set; }
        public string FriendName { get; set; } = string.Empty;
        public string? FriendPhotoUrl { get; set; }
        public string Status { get; set; } = FriendshipStatuses.NotFriends;
        public DateTime CreatedAt { get; set; }
    }
}
