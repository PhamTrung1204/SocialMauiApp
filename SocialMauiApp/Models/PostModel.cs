using CommunityToolkit.Mvvm.ComponentModel;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using SQLite;
using System;

namespace SocialMauiApp.Models
{
    public partial class PostModel : BasePostViewModel
    {
        [PrimaryKey]
        public Guid PostId { get; set; }

        [ObservableProperty]
        private Guid _userId;

        [ObservableProperty]
        private string _userName = string.Empty;

        [ObservableProperty]
        private string? _userPhotoUrl;

        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;

        [ObservableProperty]
        private string? _content;

        [ObservableProperty]
        private string? _photoUrl;

        [ObservableProperty]
        private string _postedOnDisplay;

        public string PostTemplateContentViewName =>
            string.IsNullOrWhiteSpace(PhotoUrl) ? "WithNoImage" :
            string.IsNullOrWhiteSpace(Content) ? "ImageOnly" : "WithImage";

        [ObservableProperty]
        private bool _isLiked;

        [ObservableProperty]
        private bool _isBookmarked;

        [ObservableProperty]
        private int _likeCount;

        [ObservableProperty]
        private int _commentCount;

        [Ignore] // Không lưu vào SQLite vì tính toán động
        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";

        [Ignore] // Không lưu vào SQLite vì tính toán động
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";

        // Thêm thuộc tính IsSync để đánh dấu trạng thái đồng bộ
        [ObservableProperty]
        private int _isSync;

        public PostModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
            : base(postApi, realtimeUpdatesService)
        {
        }

        partial void OnIsLikedChanged(bool oldValue, bool newValue)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                OnPropertyChanged(nameof(IsLikeIcon));
            });
        }

        public void NotifyIsLikeIconChanged()
        {
            OnPropertyChanged(nameof(IsLikeIcon));
        }

        partial void OnIsBookmarkedChanged(bool oldValue, bool newValue)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                OnPropertyChanged(nameof(IsBookmarkIcon));
            });
        }

        public void NotifyIsBookmarkIconChanged()
        {
            OnPropertyChanged(nameof(IsBookmarkIcon));
        }

        public static PostModel FromDto(PostDto dto, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService) =>
            new PostModel(postApi, realtimeUpdatesService)
            {
                PostId = dto.PostId,
                UserId = dto.UserId,
                UserName = dto.UserName ?? string.Empty,
                UserPhotoUrl = dto.UserPhotoUrl,
                Content = dto.Content,
                PhotoUrl = dto.PhotoUrl,
                PostedOnDisplay = dto.PostedOnDisplay,
                IsLiked = dto.IsLiked,
                IsBookmarked = dto.IsBookmarked,
                LikeCount = dto.LikeCount,
                CommentCount = dto.CommentCount,
                IsSync = 0 // Mặc định chưa đồng bộ
            };
    }
}