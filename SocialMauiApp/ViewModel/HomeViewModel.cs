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
        public ObservableCollection<PostModel> Posts { get; set; }

        [ObservableProperty]
        private PostModel? newPost;

        partial void OnNewPostChanged(PostModel? oldValue, PostModel? newValue)
        {
            if (newValue != null)
            {
                var existing = Posts.FirstOrDefault(p => p.PostId == newValue.PostId);
                if (existing == null)
                {
                    // Chèn bài đăng mới nhất vào đầu danh sách
                    Posts.Insert(0, newValue);
                }
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
                    if (_startIndex == 0)
                    {
                        // Nếu đang làm mới, xoá danh sách cũ để tránh trùng lặp
                        Posts.Clear();
                    }
                    _startIndex += posts.Length;
                    foreach (var p in posts.OrderByDescending(p=>p.PostedOn))
                    {
                        var postModel = PostModel.FromDto(p, PostsApi, _realtimeUpdatesService);
                        // Kiểm tra nếu bài đã có trong danh sách thì bỏ qua
                        if (!Posts.Any(existing => existing.PostId == postModel.PostId))
                        {
                            Posts.Add(postModel);
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

        private void OnPostChanged(PostDto updatedPost)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                var post = Posts.FirstOrDefault(p => p.PostId == updatedPost.PostId);
                if (post != null)
                {
                    post.IsLiked = updatedPost.IsLiked;
                    post.Content = updatedPost.Content;
                    post.PhotoUrl = updatedPost.PhotoUrl;
                    post.IsBookmarked = updatedPost.IsBookmarked;
                    _realtimeUpdatesService.NotifyPostChanged(post.PostId);
                }
                else
                {
                    Posts.Insert(0, PostModel.FromDto(updatedPost, PostsApi, _realtimeUpdatesService));
                }
            });
        }     

        private void OnPostDeleted(Guid postId)
        {
            MainThread.InvokeOnMainThreadAsync(() =>
            {
                var currentPost = Posts.FirstOrDefault(p => p.PostId == postId);
                if (currentPost != null)
                {
                    Posts.Remove(currentPost);
                    _startIndex--;
                }
            });
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            MainThread.InvokeOnMainThreadAsync(() =>
            {
                foreach (var post in Posts.Where(p => p.UserId == dto.UserId))
                {
                    post.UserPhotoUrl = dto.PhotoUrl;
                }
            });
        }

        private void OnNotificationGenerated(NotificationDto dto)
        {
            MainThread.InvokeOnMainThreadAsync(() =>
            {
                if (dto.ForUserId == _authService.User.Id)
                {
                    IsThereNewNotification = true;
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddPostChangedHandler(nameof(HomeViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(HomeViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(HomeViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddNotificationGeneratedHandler(nameof(HomeViewModel), OnNotificationGenerated);
        }
    }
}
