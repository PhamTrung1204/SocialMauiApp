using Microsoft.AspNetCore.SignalR.Client;
using SocialMediaMaui.Shared;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SocialMauiApp.Services
{
    public partial class RealtimeUpdatesService
    {
        private HubConnection _hubConnection;

        private readonly Dictionary<string, Action<PostDto>> _postChangedActions = new();
        private readonly Dictionary<string, Action<Guid>> _postDeletedActions = new();
        private readonly Dictionary<string, Action<CommentDto>> _commentAddedActions = new();
        private readonly Dictionary<string, Action<UserPhotoChangedDto>> _userPhotoChangedActions = new();
        private readonly Dictionary<string, Action<NotificationDto>> _notificationGeneratedActions = new();
        private readonly Dictionary<string, Action<CommentDto>> _commentUpdatedActions = new();
        private readonly Dictionary<string, Action<Guid>> _commentDeletedActions = new();
        private readonly Dictionary<string, Action<PostDto>> _postCountsUpdatedActions = new();
        private readonly Dictionary<string, Action<PostDto>> _postAddedActions = new();

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

        public void AddPostAddedHandler(string key, Action<PostDto> handler) =>
            _postAddedActions[key] = handler;

        private async Task ConfigureRealtimeUpdates()
        {
            try
            {
                _hubConnection = new HubConnectionBuilder()
                    .WithUrl(AppConstants.HubFullUrl)
                    .WithAutomaticReconnect()
                    .Build();

                _hubConnection.Closed += error =>
                {
                    System.Diagnostics.Debug.WriteLine($"SignalR connection closed: {error?.Message} at 04:04 PM +07, 28/05/2025.");
                    return Task.CompletedTask;
                };

                _hubConnection.Reconnecting += error =>
                {
                    System.Diagnostics.Debug.WriteLine($"SignalR reconnecting: {error?.Message} at 04:04 PM +07, 28/05/2025.");
                    return Task.CompletedTask;
                };

                _hubConnection.Reconnected += connectionId =>
                {
                    System.Diagnostics.Debug.WriteLine($"SignalR reconnected with ID: {connectionId} at 04:04 PM +07, 28/05/2025.");
                    return Task.CompletedTask;
                };

                _hubConnection.On<PostDto>(nameof(ISocialHubClient.PostChanged), post =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received PostChanged event for post {post.PostId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _postChangedActions.Values)
                    {
                        try { action.Invoke(post); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in PostChanged handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                _hubConnection.On<Guid>(nameof(ISocialHubClient.PostDeleted), postId =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received PostDeleted event for post {postId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _postDeletedActions.Values)
                    {
                        try { action.Invoke(postId); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in PostDeleted handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                _hubConnection.On<CommentDto>(nameof(ISocialHubClient.CommentAddedToThePost), comment =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received CommentAddedToThePost event for comment {comment.CommentId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _commentAddedActions.Values)
                    {
                        try { action.Invoke(comment); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in CommentAdded handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                _hubConnection.On<UserPhotoChangedDto>(nameof(ISocialHubClient.UserPhotoChanged), userPhotoDto =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received UserPhotoChanged event for user {userPhotoDto.UserId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _userPhotoChangedActions.Values)
                    {
                        try { action.Invoke(userPhotoDto); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in UserPhotoChanged handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                _hubConnection.On<NotificationDto>(nameof(ISocialHubClient.NotificationGenerated), notificationDto =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received NotificationGenerated event for notification {notificationDto.ForUserId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _notificationGeneratedActions.Values)
                    {
                        try { action.Invoke(notificationDto); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in NotificationGenerated handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                _hubConnection.On<PostDto>(nameof(ISocialHubClient.PostCountsUpdated), counts =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received PostCountsUpdated event for post {counts.PostId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _postCountsUpdatedActions.Values)
                    {
                        try { action.Invoke(counts); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in PostCountsUpdated handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                _hubConnection.On<PostDto>("PostAdded", post =>
                {
                    System.Diagnostics.Debug.WriteLine($"Received PostAdded event for post {post.PostId} at 04:04 PM +07, 28/05/2025.");
                    foreach (var action in _postAddedActions.Values)
                    {
                        try { action.Invoke(post); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in PostAdded handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                    }
                });

                RegisterCommentUpdateHandler("CommentUpdated");
                RegisterCommentUpdateHandler("CommentChanged");
                RegisterCommentUpdateHandler("CommentEdited");

                RegisterCommentDeleteHandler("CommentDeleted");
                RegisterCommentDeleteHandler("CommentRemoved");

                await _hubConnection.StartAsync();
                System.Diagnostics.Debug.WriteLine("SignalR connection started successfully at 04:04 PM +07, 28/05/2025.");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"SignalR connection error: {ex.Message} at 04:04 PM +07, 28/05/2025.");
            }
        }

        private void RegisterCommentUpdateHandler(string methodName)
        {
            _hubConnection.On<CommentDto>(methodName, comment =>
            {
                System.Diagnostics.Debug.WriteLine($"Received {methodName} event for comment {comment.CommentId} at 04:04 PM +07, 28/05/2025.");
                foreach (var action in _commentUpdatedActions.Values)
                {
                    try { action.Invoke(comment); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in {methodName} handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                }
            });
        }

        private void RegisterCommentDeleteHandler(string methodName)
        {
            _hubConnection.On<Guid>(methodName, commentId =>
            {
                System.Diagnostics.Debug.WriteLine($"Received {methodName} event for comment {commentId} at 04:04 PM +07, 28/05/2025.");
                foreach (var action in _commentDeletedActions.Values)
                {
                    try { action.Invoke(commentId); } catch (Exception ex) { System.Diagnostics.Debug.WriteLine($"Error in {methodName} handler: {ex.Message} at 04:04 PM +07, 28/05/2025."); }
                }
            });
        }

        public async Task NotifyPostChangedAsync(PostDto postDto)
        {
            try
            {
                await EnsureConnectedAsync();
                await _hubConnection.InvokeAsync("PostChanged", postDto);
                Console.WriteLine($"Notified PostChanged for post {postDto.PostId} at 04:04 PM +07, 28/05/2025.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error notifying PostChanged: {ex.Message} at 04:04 PM +07, 28/05/2025.");
            }
        }

        public async Task NotifyPostAddedAsync(PostDto postDto)
        {
            try
            {
                await EnsureConnectedAsync();
                await _hubConnection.InvokeAsync("PostAdded", postDto);
                Console.WriteLine($"Notified PostAdded for post {postDto.PostId} at 04:04 PM +07, 28/05/2025.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error notifying PostAdded: {ex.Message} at 04:04 PM +07, 28/05/2025.");
            }
        }

        public async Task NotifyUserPhotoChangedAsync(UserPhotoChangedDto userPhotoDto)
        {
            try
            {
                await EnsureConnectedAsync();
                await _hubConnection.InvokeAsync("UserPhotoChanged", userPhotoDto);
                Console.WriteLine($"Notified UserPhotoChanged for user {userPhotoDto.UserId} at 04:04 PM +07, 28/05/2025.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error notifying UserPhotoChanged: {ex.Message} at 04:04 PM +07, 28/05/2025.");
            }
        }

        public async Task NotifyCommentAddedAsync(CommentDto comment)
        {
            try
            {
                await EnsureConnectedAsync();
                await _hubConnection.InvokeAsync("CommentAddedToThePost", comment);
                Console.WriteLine($"Notified CommentAdded for comment {comment.CommentId} at 04:04 PM +07, 28/05/2025.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error notifying CommentAdded: {ex.Message} at 04:04 PM +07, 28/05/2025.");
            }
        }

        public void NotifyPostChanged(Guid postId)
        {
            if (_hubConnection != null && _hubConnection.State == HubConnectionState.Connected)
            {
                try
                {
                    _hubConnection.SendAsync("UpdatePostStatus", postId);
                    System.Diagnostics.Debug.WriteLine($"Sent UpdatePostStatus for post {postId} at 04:04 PM +07, 28/05/2025.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error sending UpdatePostStatus: {ex.Message} at 04:04 PM +07, 28/05/2025.");
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Cannot send UpdatePostStatus: hub not connected at 04:04 PM +07, 28/05/2025.");
            }
        }

        public void NotifyCommentUpdated(CommentDto comment)
        {
            if (_hubConnection != null && _hubConnection.State == HubConnectionState.Connected)
            {
                try
                {
                    _hubConnection.SendAsync("UpdateComment", comment);
                    System.Diagnostics.Debug.WriteLine($"Sent UpdateComment for comment {comment.CommentId} at 04:04 PM +07, 28/05/2025.");
                    _hubConnection.SendAsync("CommentUpdated", comment);
                    System.Diagnostics.Debug.WriteLine($"Sent CommentUpdated for comment {comment.CommentId} at 04:04 PM +07, 28/05/2025.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error sending comment update: {ex.Message} at 04:04 PM +07, 28/05/2025.");
                }
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Cannot send comment update: hub not connected at 04:04 PM +07, 28/05/2025.");
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

            if (_commentUpdatedActions.ContainsKey(key))
                _commentUpdatedActions.Remove(key);

            if (_commentDeletedActions.ContainsKey(key))
                _commentDeletedActions.Remove(key);

            if (_userPhotoChangedActions.ContainsKey(key))
                _userPhotoChangedActions.Remove(key);

            if (_notificationGeneratedActions.ContainsKey(key))
                _notificationGeneratedActions.Remove(key);

            if (_postCountsUpdatedActions.ContainsKey(key))
                _postCountsUpdatedActions.Remove(key);

            if (_postAddedActions.ContainsKey(key))
                _postAddedActions.Remove(key);

            System.Diagnostics.Debug.WriteLine($"Removed handlers for key: {key} at 04:04 PM +07, 28/05/2025.");
        }

        public bool IsConnected => _hubConnection?.State == HubConnectionState.Connected;

        public async Task EnsureConnectedAsync()
        {
            if (_hubConnection?.State != HubConnectionState.Connected)
            {
                try
                {
                    await _hubConnection.StartAsync();
                    System.Diagnostics.Debug.WriteLine("SignalR connection reestablished at 04:04 PM +07, 28/05/2025.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Failed to reconnect SignalR: {ex.Message} at 04:04 PM +07, 28/05/2025.");
                }
            }
        }
    }
}