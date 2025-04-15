namespace SocialMediaMaui.Shared.Dtos
{
    public class CommentDto
    {
        public Guid PostId { get; set; }
        public Guid CommentId { get; set; }
        public string? Content { get; set; }
        public Guid UserId { get; set; }
        public string UserName { get; set; }
        public string? UserPhotoUrl { get; set; }
        public DateTime AddedOn { get; set; }
        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;
        // ➕ Thêm thuộc tính này
        public bool IsOwnComment { get; set; }
    }
}
