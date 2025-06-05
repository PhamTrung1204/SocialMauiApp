namespace SocialMediaMaui.Shared.Dtos
{
    public class FriendshipDto
    {
        public Guid UserId { get; set; }
        public Guid FriendId { get; set; }
        public string FriendName { get; set; }
        public string FriendPhotoUrl { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
