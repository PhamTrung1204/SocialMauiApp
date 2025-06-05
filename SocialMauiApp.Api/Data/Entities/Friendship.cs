namespace SocialMauiApp.Api.Data.Entities
{
    public class Friendship
    {
        public Guid UserId { get; set; }
        public Guid FriendId { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Status { get; set; }
        public User User { get; set; }
        public User Friend { get; set; }
    }
}
