using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace SocialMediaMaui.Shared.Dtos
{
    public class CommentDto : INotifyPropertyChanged
    {
        private string? _content;
        private string? _photoUrl;
        private string? _userPhotoUrl;
        private bool _isOwnComment;

        public Guid PostId { get; set; }
        public Guid CommentId { get; set; }
        public Guid? ParentCommentId { get; set; }

        public string? Content
        {
            get => _content;
            set => SetProperty(ref _content, value);
        }

        public Guid UserId { get; set; }
        public string UserName { get; set; }

        public string? UserPhotoUrl
        {
            get => _userPhotoUrl;
            set => SetProperty(ref _userPhotoUrl, value);
        }

        public string? PhotoUrl
        {
            get => _photoUrl;
            set => SetProperty(ref _photoUrl, value);
        }

        public DateTime AddedOn { get; set; }

        public string UserPhoto => string.IsNullOrWhiteSpace(UserPhotoUrl) ? "personal.png" : UserPhotoUrl;

        public bool IsOwnComment
        {
            get => _isOwnComment;
            set => SetProperty(ref _isOwnComment, value);
        }

        public List<CommentDto> Replies { get; set; } = new List<CommentDto>();

        public event PropertyChangedEventHandler? PropertyChanged;

        protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            if (propertyName == nameof(UserPhotoUrl))
            {
                OnPropertyChanged(nameof(UserPhoto)); // Đảm bảo UserPhoto cũng được cập nhật khi UserPhotoUrl thay đổi
            }
        }

        protected bool SetProperty<T>(ref T storage, T value, [CallerMemberName] string? propertyName = null)
        {
            if (Equals(storage, value)) return false;
            storage = value;
            OnPropertyChanged(propertyName);
            return true;
        }
    }
}