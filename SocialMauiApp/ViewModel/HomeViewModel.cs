using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class HomeViewModel : BasePostViewModel
    {
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly AuthService _authService;
        public HomeViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService):base(postApi) 
        {
            FetchPostsAsync();
            _realtimeUpdatesService = realtimeUpdatesService;
            _authService = authService;
           
        }
        public ObservableCollection<PostModel> Posts { get; set; } = [];
        private int _startIndex = 0;
        private const int PageSize = 7;
        [RelayCommand]
        private async Task FetchPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var posts = await PostsApi.GetPostsAsync(_startIndex, PageSize);
                if(posts.Length > 0)
                {
                    if(_startIndex == 0 && Posts.Count > 0)
                    {
                        Posts.Clear();
                    }
                    _startIndex += posts.Length;
                    foreach (var p in posts)
                    {
                        Posts.Add(PostModel.FromDto(p, PostsApi));
                    }

                }
            });
        }
        [ObservableProperty]
        private bool _isRefreshing;
        [ObservableProperty]
        private bool _isThereNewNotification;
        [RelayCommand]
        private async Task RefreshPostsAsync()
        {
            _startIndex = 0;
            await FetchPostsAsync();
            IsRefreshing = false;
        }
        [RelayCommand]
        private async Task GoToAddPostAsync()=> await NavigateAsync(nameof(AddPostPage));
        private void OnPostChanged(PostDto post)
        {
            var currentPost = Posts.FirstOrDefault(p=>p.PostId ==post.PostId);
            if(currentPost != null)
            {
                currentPost.PhotoUrl = post.PhotoUrl;
                currentPost.Content = post.Content;
            }
        }
        private void OnPostDeleted(Guid postId)
        {
            var currentPost = Posts.FirstOrDefault(p => p.PostId == postId);
            if (currentPost != null)
            {
               Posts.Remove(currentPost);
                _startIndex--;
            }
            
        }
        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            foreach (var post in Posts.Where(p => p.UserId == dto.UserId))
            {
                post.UserPhotoUrl = dto.PhotoUrl;
            }
        }
        private void OnNotificationGenerated(NotificationDto dto)
        {
            if(dto.ForUserId == _authService.User.Id)
            {
                IsThereNewNotification = true;
            }
        }
        public void ConfigureRealtimeUpdates()
        {

            _realtimeUpdatesService.AddPostChangedHandler(nameof(HomeViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(HomeViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(HomeViewModel),OnUserPhotoChanged);
           _realtimeUpdatesService.AddNotificationGeneratedHandler(nameof(HomeViewModel), OnNotificationGenerated);
        }
        
    }
}
