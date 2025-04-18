using CommunityToolkit.Mvvm.ComponentModel;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using System;

namespace SocialMauiApp.Models
{
    public partial class PostModel : BasePostViewModel
    {
        public Guid PostId { get; set; }
        public Guid UserId { get; set; }

        [ObservableProperty]
        private string _userName = string.Empty;

        [ObservableProperty]
        private string? _userPhotoUrl;

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

        [ObservableProperty]
        private int _likeCount;
      
        [ObservableProperty]
        private int _commentCount;
       

        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";

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
                Content = dto.Content,
                IsBookmarked = dto.IsBookmarked,
                IsLiked = dto.IsLiked,
                PhotoUrl = dto.PhotoUrl,
                PostedOnDisplay = dto.PostedOnDisplay,
                UserId = dto.UserId,
                UserName = dto.UserName,
                UserPhotoUrl = dto.UserPhotoUrl,

                // Bổ sung dữ liệu lượt tương tác
                LikeCount = dto.LikeCount,
                CommentCount = dto.CommentCount,
               
            };
    }

}
