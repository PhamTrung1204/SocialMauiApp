using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.ObjectModel;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Maui.ApplicationModel;

namespace SocialMauiApp.ViewModel
{
    public partial class NotificationViewModel : BasePostViewModel
    {
        private readonly IUserApi _userApi;
        private readonly AuthService _authService;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private int _startIndex = 0;
        private const int PageSize = 50;

        public NotificationViewModel(IUserApi userApi, AuthService authService, RealtimeUpdatesService realtimeUpdatesService, IPostApi postsApi)
            : base(postsApi, realtimeUpdatesService)
        {
            _userApi = userApi;
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            Notifications = new ObservableCollection<NotificationDto>();

            // Loại bỏ việc tự động gọi fetch notifications trong constructor.
        }

        public ObservableCollection<NotificationDto> Notifications { get; set; }

        [RelayCommand]
        private async Task FetchNotificationAsync()
        {
            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var notifications = await _userApi.GetNotificationAsync(token, _startIndex, PageSize);
                if (notifications.Length > 0)
                {
                    if (_startIndex == 0 && Notifications.Count > 0)
                    {
                        Notifications.Clear();
                    }
                    _startIndex += notifications.Length;
                    foreach (var notification in notifications)
                    {
                        Notifications.Add(notification);
                    }
                }
            });
        }

        [ObservableProperty]
        private bool isRefreshing;

        [RelayCommand]
        private async Task RefreshNotificationsAsync()
        {
            _startIndex = 0;
            await FetchNotificationAsync();
            IsRefreshing = false;
        }

        // Cập nhật UI trên main thread khi có thông báo mới từ SignalR
        private void OnNotificationGenerated(NotificationDto dto)
        {
            MainThread.InvokeOnMainThreadAsync(() =>
            {
                if (dto.ForUserId == _authService.User.Id)
                {
                    Notifications.Insert(0, dto);
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddNotificationGeneratedHandler(nameof(NotificationViewModel), OnNotificationGenerated);
        }

        [RelayCommand]
        private async Task OpenPostAsync(Guid? postId)
        {
            if (postId == null || postId == Guid.Empty)
            {
                await ToastAsync("Post not available");
                return;
            }
            await MakeApiCall(async () =>
            {
                var post = await PostsApi.GetPostAsync(postId.Value);
                if (post == null)
                {
                    await ToastAsync("Post no longer exists");
                    return;
                }
                // Sửa lại: truyền thêm realtimeUpdatesService cho PostModel.FromDto để hỗ trợ realtime toggle cập nhật icon ngay lập tức
                await NavigateAsync(nameof(PostDetailsPage), new Dictionary<string, object>
                {
                    [nameof(DetailsViewModel.Post)] = PostModel.FromDto(post, PostsApi, _realtimeUpdatesService, _authService)
                });
            });
        }
    }
}
