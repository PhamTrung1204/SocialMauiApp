using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel; // Đảm bảo có MainThread
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(NewPost), "newPost")]
    public partial class HomeViewModel : BasePostViewModel
    {
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly AuthService _authService;
        private int _startIndex = 0;
        private const int PageSize = 7;

        public HomeViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService)
            : base(postApi, realtimeUpdatesService)
        {
            _realtimeUpdatesService = realtimeUpdatesService;
            _authService = authService;

            Posts = new ObservableCollection<PostModel>();

            _ = FetchPostsAsync();

            ConfigureRealtimeUpdates();
        }

        public ObservableCollection<PostModel> Posts { get; }

        [ObservableProperty]
        private PostModel? newPost;

        partial void OnNewPostChanged(PostModel? oldValue, PostModel? value)
        {
            if (value != null && Posts.All(p => p.PostId != value.PostId))
            {
                // Chèn bài đăng mới nhất vào đầu danh sách
                Posts.Insert(0, value);
                _startIndex++;
            }
        }

        [RelayCommand]
        private async Task FetchPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var posts = await PostsApi.GetPostsAsync(_startIndex, PageSize);
                if (posts.Length > 0)
                {
                    if (_startIndex == 0) Posts.Clear();
                    _startIndex += posts.Length;
                    foreach (var dto in posts.OrderByDescending(p => p.PostedOn))
                    {
                        if (!Posts.Any(p => p.PostId == dto.PostId))
                        {
                            Posts.Add(PostModel.FromDto(dto, PostsApi, _realtimeUpdatesService));
                        }
                    }
                }
            });
        }

        [ObservableProperty]
        private bool isRefreshing;

        [ObservableProperty]
        private bool isThereNewNotification;

        [RelayCommand]
        private async Task RefreshPostsAsync()
        {
            _startIndex = 0;
            await FetchPostsAsync();
            IsRefreshing = false;
        }

        [RelayCommand]
        private async Task GoToAddPostAsync() => await NavigateAsync(nameof(AddPostPage));

        private void OnPostChanged(PostDto updated)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var postModel = Posts.FirstOrDefault(p => p.PostId == updated.PostId);
                if (postModel != null)
                {
                    // Cập nhật tất cả trạng thái tương tác
                    postModel.IsLiked = updated.IsLiked;
                    postModel.NotifyIsLikeIconChanged();

                    postModel.IsBookmarked = updated.IsBookmarked;
                    postModel.NotifyIsBookmarkIconChanged();

                    postModel.Content = updated.Content;
                    postModel.PhotoUrl = updated.PhotoUrl;
                }
                else
                {
                    // Nếu chưa tồn tại, thêm mới vào đầu danh sách
                    Posts.Insert(0, PostModel.FromDto(updated, PostsApi, _realtimeUpdatesService));
                    _startIndex++;
                }
            });
        }

        // Xử lý khi Post bị xóa
        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var removed = Posts.FirstOrDefault(p => p.PostId == postId);
                if (removed != null)
                {
                    Posts.Remove(removed);
                    _startIndex--;
                }
            });
        }

        // Xử lý khi số counts cập nhật
        private void OnPostCountsUpdated(PostDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var model = Posts.FirstOrDefault(p => p.PostId == dto.PostId);
                if (model != null)
                {
                    model.LikeCount = dto.LikeCount;
                    model.CommentCount = dto.CommentCount;
                }
            });
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                foreach (var p in Posts.Where(p => p.UserId == dto.UserId))
                {
                    p.UserPhotoUrl = dto.PhotoUrl;
                }
            });
        }

        private void OnNotificationGenerated(NotificationDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (dto.ForUserId == _authService.User.Id)
                    IsThereNewNotification = true;
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddPostChangedHandler(nameof(HomeViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(HomeViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddPostCountsUpdatedHandler(nameof(HomeViewModel), OnPostCountsUpdated);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(HomeViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddNotificationGeneratedHandler(nameof(HomeViewModel), OnNotificationGenerated);
        }
    }
}
