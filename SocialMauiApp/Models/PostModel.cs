using CommunityToolkit.Mvvm.ComponentModel;
using SocialMauiApp.Apis;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using System;

namespace SocialMauiApp.Models
{
    // Lớp PostModel kế thừa từ BasePostViewModel
    public partial class PostModel : BasePostViewModel
    {
        // Các thuộc tính dữ liệu của PostModel
        public Guid PostId { get; set; }
        public Guid UserId { get; set; }
        public string UserName { get; set; }

        [ObservableProperty]
        private string? _userPhotoUrl;
        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;
        [ObservableProperty]
        public string? _content;
        [ObservableProperty]
        public string? _photoUrl;
        public DateTime PostedOnDisplay { get; set; }

        public string PostTemplateContentViewName
        {
            get
            {
                if (string.IsNullOrWhiteSpace(PhotoUrl))
                    return "WithNoImage";
                if (string.IsNullOrWhiteSpace(Content))
                    return "ImageOnly";
                return "WithImage";
            }
        }

        [ObservableProperty]
        private bool _isLiked;
        [ObservableProperty]
        private bool _isBookmarked;

        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";

        // Constructor bắt buộc phải có IPostApi để truyền cho base constructor
        public PostModel(IPostApi postApi) : base(postApi)
        {
        }

        // Phương thức khởi tạo từ DTO, cần truyền IPostApi vào để khởi tạo PostModel
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
