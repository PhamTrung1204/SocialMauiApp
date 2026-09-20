namespace SocialMauiApp.Api.Data.Entities
{
    // Một quan hệ = MỘT dòng. Hướng của dòng (Requester -> Addressee) cho biết
    // ai là người gửi lời mời, nên không cần bảng FriendRequest riêng.
    public class Friendship
    {
        public Guid RequesterId { get; set; }
        public virtual User Requester { get; set; }

        public Guid AddresseeId { get; set; }
        public virtual User Addressee { get; set; }

        public FriendshipStatus Status { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? AcceptedAt { get; set; }
    }
}
