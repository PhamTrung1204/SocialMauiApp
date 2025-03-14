using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class NotificationViewModel : BasePostViewModel
    {
        private readonly IUserApi _userApi;
        private readonly AuthService _authService;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        public NotificationViewModel(IUserApi userApi, AuthService authService, RealtimeUpdatesService realtimeUpdatesService, IPostApi postsApi): base(postsApi)
        {
            _userApi = userApi;
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            FetchNotificationAsync();
        }
        public ObservableCollection<NotificationDto> Notifications { get; set; } = [];
        private const int PageSize = 50;
        private int _startIndex = 0;
        [RelayCommand]
        private async Task FetchNotificationAsync()
        {
            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var notifications = await _userApi.GetNotificationAsync(token,_startIndex, PageSize);
                if(notifications.Length > 0)
                {
                    if(_startIndex == 0 && Notifications.Count > 0)
                    {
                        Notifications.Clear();
                    }
                    _startIndex += notifications.Length;
                    foreach(var notification in Notifications)
                    {
                        Notifications.Add(notification);
                    }
                }
            });
        }
        [ObservableProperty]
        private bool _isRefreshing;
        [RelayCommand]
        private async Task RefreshNotificationsAsync()
        {
            _startIndex = 0;
            await FetchNotificationAsync();
            IsRefreshing = true;
        }
        private async void OnNotificationGenerated(NotificationDto dto)
        {
            if (dto.ForUserId == _authService.User.Id)
            {
                await Shell.Current.Dispatcher.DispatchAsync(() => ToastAsync("New Notification"));
                Notifications = [dto, ..Notifications];
                OnPropertyChanged(nameof(Notifications));
            }
        }
        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddNotificationGeneratedHandler(nameof(NotificationViewModel), OnNotificationGenerated);
        }
        [RelayCommand]
        private async Task OpenPostAsync(Guid? postId)
        {
            if (postId.HasValue && postId != default)
            {
                await MakeApiCall(async () =>
                {
                    var post = await PostsApi.GetPostAsync(postId.Value);
                    if (post == null)
                    {
                        await ToastAsync("Post no longer exists");
                        return;
                    }
                    GoToDetailsPageCommand.Execute(PostModel.FromDto(post, PostsApi));
                });
            }
        }

    }
}
