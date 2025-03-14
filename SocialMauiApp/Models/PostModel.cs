using CommunityToolkit.Mvvm.ComponentModel;
using SocialMauiApp.Apis;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using System;

namespace SocialMauiApp.Models
{
    public partial class PostModel : BasePostViewModel
    {
        public Guid PostId { get; set; }
        public Guid UserId { get; set; }

        // Khi thay đổi, UI sẽ tự động nhận thông báo nhờ [ObservableProperty]
        [ObservableProperty]
        private string _userName = string.Empty;

        [ObservableProperty]
        private string? _userPhotoUrl;

        // Computed property dùng để hiển thị ảnh đại diện (mặc định nếu UserPhotoUrl rỗng)
        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;

        [ObservableProperty]
        private string? _content;

        [ObservableProperty]
        private string? _photoUrl;

        public DateTime PostedOnDisplay { get; set; }

        public string PostTemplateContentViewName =>
            string.IsNullOrWhiteSpace(PhotoUrl) ? "WithNoImage" :
            string.IsNullOrWhiteSpace(Content) ? "ImageOnly" : "WithImage";

        [ObservableProperty]
        private bool _isLiked;

        [ObservableProperty]
        private bool _isBookmarked;

        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";

        // Constructor bắt buộc có IPostApi để khởi tạo đối tượng
        public PostModel(IPostApi postApi) : base(postApi)
        {
        }

        // Phương thức khởi tạo từ DTO, đảm bảo mapping đầy đủ các property
        public static PostModel FromDto(PostDto dto, IPostApi postApi) =>
            new PostModel(postApi)
            {
                PostId = dto.PostId,
                Content = dto.Content,
                IsBookmarked = dto.IsBookmarked,
                IsLiked = dto.IsLiked,
                PhotoUrl = dto.PhotoUrl,
                PostedOnDisplay = dto.PostedOnDisplay,
                UserId = dto.UserId,
                UserName = dto.UserName,
                UserPhotoUrl = dto.UserPhotoUrl
            };
    }
}
