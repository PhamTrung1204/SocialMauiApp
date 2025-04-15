using CommunityToolkit.Mvvm.ComponentModel;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using System;

namespace SocialMauiApp.Models
{
    public partial class CommentModel : ObservableObject
    {
        public Guid CommentId { get; set; }
        public Guid PostId { get; set; }
        public Guid UserId { get; set; }

        [ObservableProperty]
        private string _userName = string.Empty;

        [ObservableProperty]
        private string? _userPhotoUrl;

        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;

        [ObservableProperty]
        private string? _content;

        public DateTime AddedOn { get; set; }

        [ObservableProperty]
        private bool _isEditing;

        public static CommentModel FromDto(CommentDto dto)
        {
            return new CommentModel
            {
                CommentId = dto.CommentId,
                PostId = dto.PostId,
                UserId = dto.UserId,
                UserName = dto.UserName,
                UserPhotoUrl = dto.UserPhotoUrl,
                Content = dto.Content,
                AddedOn = dto.AddedOn
            };
        }

        public CommentDto ToDto()
        {
            return new CommentDto
            {
                CommentId = CommentId,
                PostId = PostId,
                UserId = UserId,
                UserName = UserName,
                UserPhotoUrl = UserPhotoUrl,
                Content = Content,
                AddedOn = AddedOn
            };
        }
    }
}
