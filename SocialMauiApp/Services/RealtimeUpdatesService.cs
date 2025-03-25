using Microsoft.AspNetCore.SignalR.Client;
using SocialMediaMaui.Shared;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SocialMauiApp.Services
{
    public class RealtimeUpdatesService
    {
        private HubConnection _hubConnection;

        // Khởi tạo các dictionary để lưu các handler
        private readonly Dictionary<string, Action<PostDto>> _postChangedActions = new Dictionary<string, Action<PostDto>>();
        private readonly Dictionary<string, Action<Guid>> _postDeletedActions = new Dictionary<string, Action<Guid>>();
        private readonly Dictionary<string, Action<CommentDto>> _commentAddedActions = new Dictionary<string, Action<CommentDto>>();
        private readonly Dictionary<string, Action<UserPhotoChangedDto>> _userPhotoChangedActions = new Dictionary<string, Action<UserPhotoChangedDto>>();
        private readonly Dictionary<string, Action<NotificationDto>> _notificationGeneratedActions = new Dictionary<string, Action<NotificationDto>>();

        public RealtimeUpdatesService()
        {
            // Gọi bất đồng bộ để cấu hình kết nối SignalR
            _ = ConfigureRealtimeUpdates();
        }

        public void AddPostChangedHandler(string key, Action<PostDto> handler) =>
            _postChangedActions[key] = handler;

        public void AddPostDeletedHandler(string key, Action<Guid> handler) =>
            _postDeletedActions[key] = handler;

        public void AddCommentAddedHandler(string key, Action<CommentDto> handler) =>
            _commentAddedActions[key] = handler;

        public void AddUserPhotoChangedHandler(string key, Action<UserPhotoChangedDto> handler) =>
            _userPhotoChangedActions[key] = handler;

        public void AddNotificationGeneratedHandler(string key, Action<NotificationDto> handler) =>
            _notificationGeneratedActions[key] = handler;

        private async Task ConfigureRealtimeUpdates()
        {
            try
            {
                _hubConnection = new HubConnectionBuilder()
                    .WithUrl(AppConstants.HubFullUrl)
                    .Build();

                // Đăng ký các sự kiện từ hub
                _hubConnection.On<PostDto>(nameof(ISocialHubClient.PostChanged), post =>
                {
                    foreach (var action in _postChangedActions.Values)
                    {
                        try { action.Invoke(post); } catch { /* Xử lý lỗi riêng nếu cần */ }
                    }
                });
                _hubConnection.On<Guid>(nameof(ISocialHubClient.PostDeleted), postId =>
                {
                    foreach (var action in _postDeletedActions.Values)
                    {
                        try { action.Invoke(postId); } catch { }
                    }
                });
                _hubConnection.On<CommentDto>(nameof(ISocialHubClient.CommentAddedToThePost), comment =>
                {
                    foreach (var action in _commentAddedActions.Values)
                    {
                        try { action.Invoke(comment); } catch { }
                    }
                });
                _hubConnection.On<UserPhotoChangedDto>(nameof(ISocialHubClient.UserPhotoChanged), userPhotoDto =>
                {
                    foreach (var action in _userPhotoChangedActions.Values)
                    {
                        try { action.Invoke(userPhotoDto); } catch { }
                    }
                });
                _hubConnection.On<NotificationDto>(nameof(ISocialHubClient.NotificationGenerated), notificationDto =>
                {
                    foreach (var action in _notificationGeneratedActions.Values)
                    {
                        try { action.Invoke(notificationDto); } catch { }
                    }
                });

                await _hubConnection.StartAsync();
            }
            catch (Exception ex)
            {
                // Có thể ghi log hoặc thiết lập lại kết nối sau một thời gian nhất định
            }
        }
        public void NotifyPostChanged(Guid postId)
        {
            if (_hubConnection != null && _hubConnection.State == HubConnectionState.Connected)
            {
                // Gửi thông báo đến phương thức "UpdatePostStatus" trên server
                _hubConnection.SendAsync("UpdatePostStatus", postId);
            }
        }

        public void RemoveHandlers(string key)
        {
            if (_postChangedActions.ContainsKey(key))
                _postChangedActions.Remove(key);
            if (_postDeletedActions.ContainsKey(key))
                _postDeletedActions.Remove(key);
            if (_commentAddedActions.ContainsKey(key))
                _commentAddedActions.Remove(key);
            if (_userPhotoChangedActions.ContainsKey(key))
                _userPhotoChangedActions.Remove(key);
            if (_notificationGeneratedActions.ContainsKey(key))
                _notificationGeneratedActions.Remove(key);
        }
    }
}
