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
        private readonly Dictionary<string, Action<CommentDto>> _commentUpdatedActions = new Dictionary<string, Action<CommentDto>>();
        private readonly Dictionary<string, Action<Guid>> _commentDeletedActions = new Dictionary<string, Action<Guid>>();
        private readonly Dictionary<string, Action<PostDto>> _postCountsUpdatedActions = new();

        public RealtimeUpdatesService()
        {
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

        public void AddCommentUpdatedHandler(string key, Action<CommentDto> handler) =>
            _commentUpdatedActions[key] = handler;

        public void AddCommentDeletedHandler(string key, Action<Guid> handler) =>
            _commentDeletedActions[key] = handler;
        public void AddPostCountsUpdatedHandler(string key, Action<PostDto> handler) =>
            _postCountsUpdatedActions[key] = handler;
        private async Task ConfigureRealtimeUpdates()
        {
            try
            {
                _hubConnection = new HubConnectionBuilder()
                    .WithUrl(AppConstants.HubFullUrl)
                    .WithAutomaticReconnect()  // Add automatic reconnection
                    .Build();

                // Log connection state changes for debugging
                _hubConnection.Closed += error =>
                {
                    System.Diagnostics.Debug.WriteLine($"SignalR connection closed: {error?.Message}");
                    return Task.CompletedTask;
                };

                _hubConnection.Reconnecting += error =>
                {
                    System.Diagnostics.Debug.WriteLine($"SignalR reconnecting: {error?.Message}");
                    return Task.CompletedTask;
                };

                _hubConnection.Reconnected += connectionId =>
                {
                    System.Diagnostics.Debug.WriteLine($"SignalR reconnected with ID: {connectionId}");
                    return Task.CompletedTask;
                };

                // Đăng ký các sự kiện từ hub
                _hubConnection.On<PostDto>(nameof(ISocialHubClient.PostChanged), post =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received PostChanged event for post {post.PostId}");
                    foreach (var action in _postChangedActions.Values)
                    {
                        try { action.Invoke(post); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in PostChanged handler: {ex.Message}"); }
                    }
                });

                _hubConnection.On<Guid>(nameof(ISocialHubClient.PostDeleted), postId =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received PostDeleted event for post {postId}");
                    foreach (var action in _postDeletedActions.Values)
                    {
                        try { action.Invoke(postId); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in PostDeleted handler: {ex.Message}"); }
                    }
                });

                _hubConnection.On<CommentDto>(nameof(ISocialHubClient.CommentAddedToThePost), comment =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received CommentAddedToThePost event for comment {comment.CommentId}");
                    foreach (var action in _commentAddedActions.Values)
                    {
                        try { action.Invoke(comment); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in CommentAdded handler: {ex.Message}"); }
                    }
                });

                _hubConnection.On<UserPhotoChangedDto>(nameof(ISocialHubClient.UserPhotoChanged), userPhotoDto =>
                {
                    foreach (var action in _userPhotoChangedActions.Values)
                    {
                        try { action.Invoke(userPhotoDto); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in UserPhotoChanged handler: {ex.Message}"); }
                    }
                });

                _hubConnection.On<NotificationDto>(nameof(ISocialHubClient.NotificationGenerated), notificationDto =>
                {
                    foreach (var action in _notificationGeneratedActions.Values)
                    {
                        try { action.Invoke(notificationDto); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in NotificationGenerated handler: {ex.Message}"); }
                    }
                });
                _hubConnection.On<PostDto>(nameof(ISocialHubClient.PostCountsUpdated), counts =>
                {
                    foreach (var action in _postCountsUpdatedActions.Values)
                        try { action.Invoke(counts); } catch { }
                });

                // Try different possible method names for comment updates
                RegisterCommentUpdateHandler("CommentUpdated");
                RegisterCommentUpdateHandler("CommentChanged");
                RegisterCommentUpdateHandler("CommentEdited");

                // Try different possible method names for comment deletion
                RegisterCommentDeleteHandler("CommentDeleted");
                RegisterCommentDeleteHandler("CommentRemoved");

                await _hubConnection.StartAsync();
                System.Diagnostics.Debug.WriteLine("SignalR connection started successfully");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"SignalR connection error: {ex.Message}");
            }
        }

        private void RegisterCommentUpdateHandler(string methodName)
        {
            _hubConnection.On<CommentDto>(methodName, comment =>
            {
                System.Diagnostics.Debug.WriteLine($"Received {methodName} event for comment {comment.CommentId}");
                foreach (var action in _commentUpdatedActions.Values)
                {
                    try { action.Invoke(comment); }
                    catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in {methodName} handler: {ex.Message}"); }
                }
            });
        }

        private void RegisterCommentDeleteHandler(string methodName)
        {
            _hubConnection.On<Guid>(methodName, commentId =>
            {
                System.Diagnostics.Debug.WriteLine($"Received {methodName} event for comment {commentId}");
                foreach (var action in _commentDeletedActions.Values)
                {
                    try { action.Invoke(commentId); }
                    catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in {methodName} handler: {ex.Message}"); }
                }
            });
        }

        public void NotifyPostChanged(Guid postId)
        {
            if (_hubConnection != null && _hubConnection.State == HubConnectionState.Connected)
            {
                try
                {
                    _hubConnection.SendAsync("UpdatePostStatus", postId);
                    System.Diagnostics.Debug.WriteLine($"Sent UpdatePostStatus for post {postId}");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error sending UpdatePostStatus: {ex.Message}");
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Cannot send UpdatePostStatus: hub not connected");
            }
        }

        public void NotifyCommentUpdated(CommentDto comment)
        {
            if (_hubConnection != null && _hubConnection.State == HubConnectionState.Connected)
            {
                try
                {
                    // Try different possible server method names
                    _hubConnection.SendAsync("UpdateComment", comment);
                    System.Diagnostics.Debug.WriteLine($"Sent UpdateComment for comment {comment.CommentId}");

                    _hubConnection.SendAsync("CommentUpdated", comment);
                    System.Diagnostics.Debug.WriteLine($"Sent CommentUpdated for comment {comment.CommentId}");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error sending comment update: {ex.Message}");
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Cannot send comment update: hub not connected");
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

            // Handler cho comment cập nhật/sửa
            if (_commentUpdatedActions.ContainsKey(key))
                _commentUpdatedActions.Remove(key);

            // Handler cho comment xoá
            if (_commentDeletedActions.ContainsKey(key))
                _commentDeletedActions.Remove(key);

            if (_userPhotoChangedActions.ContainsKey(key))
                _userPhotoChangedActions.Remove(key);

            if (_notificationGeneratedActions.ContainsKey(key))
                _notificationGeneratedActions.Remove(key);

            System.Diagnostics.Debug.WriteLine($"Removed handlers for key: {key}");
        }

        public bool IsConnected => _hubConnection?.State == HubConnectionState.Connected;

        public async Task EnsureConnectedAsync()
        {
            if (_hubConnection?.State != HubConnectionState.Connected)
            {
                try
                {
                    await _hubConnection.StartAsync();
                    System.Diagnostics.Debug.WriteLine("SignalR connection reestablished");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Failed to reconnect SignalR: {ex.Message}");
                }
            }
        }
    }
}