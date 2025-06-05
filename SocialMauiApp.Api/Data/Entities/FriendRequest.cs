namespace SocialMauiApp.Api.Data.Entities
{
    public class FriendRequest
    {
        public Guid Id { get; set; }
        public Guid SenderId { get; set; }
        public Guid ReceiverId { get; set; }
        public DateTime SentAt { get; set; }
        public bool IsAccepted { get; set; } // True if accepted, false if pending
        public DateTime? AcceptedAt { get; set; }

        public User Sender { get; set; }
        public User Receiver { get; set; }
    }
}
