using CommunityToolkit.Mvvm.ComponentModel;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace SocialMauiApp.Models
{
    public partial class PostModel : ObservableObject
    {
        public Guid PostId { get; set; }
        public Guid UserId { get; set; }
        public string UserName { get; set; }
        [ObservableProperty, NotifyPropertyChangedFor(nameof(UserPhoto))]
        private string? _userPhotoUrl;
        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;
      
        public string? Content { get; set; }
        public string? PhotoUrl { get; set; }

       
        public DateTime PostedOnDisplay {  get; set; }
       
        [JsonIgnore]
        public string PostTemplateContentViewName
        {
            get
            {
                if (string.IsNullOrWhiteSpace(PhotoUrl))
                {
                    return "WithNoImage";
                }
                if (string.IsNullOrWhiteSpace(Content))
                {
                    return "ImageOnly";
                }
                return "WithImage";
            }
        }
        [ObservableProperty]
        [NotifyPropertyChangedFor(nameof(IsLikeIcon))]
        private bool _isLiked;
        [ObservableProperty, NotifyPropertyChangedFor(nameof(IsBookmarkIcon))]
        private bool _isBookmarked;

       
        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";
       
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";
        public static PostModel FromDto(PostDto dto) =>
            new()
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
