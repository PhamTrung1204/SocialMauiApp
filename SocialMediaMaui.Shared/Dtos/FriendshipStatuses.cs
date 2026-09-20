namespace SocialMediaMaui.Shared.Dtos
{
    // Giá trị dùng chung giữa API và client - tránh gõ sai chuỗi ở hai phía.
    public static class FriendshipStatuses
    {
        public const string NotFriends = "NotFriends";
        public const string Pending = "Pending";
        public const string RequestReceived = "RequestReceived";
        public const string Friends = "Friends";
        public const string Self = "Self";
    }
}
