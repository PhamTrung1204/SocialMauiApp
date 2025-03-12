using Microsoft.AspNetCore.SignalR.Client;
using SocialMediaMaui.Shared;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Services
{
    public class RealtimeUpdatesService
    {
        public RealtimeUpdatesService() 
        {
            ConfigureRealtimeUpdates();
        }
        private readonly Dictionary<string, Action<PostDto>> _postChangedActions = [];
        public void AddPostChangedHandler(string key, Action<PostDto> handler) =>
            _postChangedActions[key] = handler;
        private readonly Dictionary<string, Action<Guid>> _postDeletedActions = [];
        public void AddPostDeletedHandler(string key, Action<Guid> handler) =>
            _postDeletedActions[key] = handler;
        private readonly Dictionary<string, Action<CommentDto>> _commentAddedActions = [];
        public void AddCommentAddedHandler(string key, Action<CommentDto> handler) =>
            _commentAddedActions[key] = handler;
        private readonly Dictionary<string, Action<UserPhotoChangedDto>> _userPhotoChangedActions = [];
        public void AddUserPhotoChangedHandler(string key, Action<UserPhotoChangedDto> handler) =>
            _userPhotoChangedActions[key] = handler;
        private readonly Dictionary<string, Action<NotificationDto>> _notificationGeneratedActions = [];
        public void AddNotificationGeneratedHandler(string key, Action<NotificationDto> handler) =>
            _notificationGeneratedActions[key] = handler;
        private async Task ConfigureRealtimeUpdates()
        {
            try
            {
                var hubConnection = new HubConnectionBuilder().WithUrl(AppConstants.HubFullUrl).Build();
                hubConnection.On<PostDto>(nameof(ISocialHubClient.PostChanged), post =>
                {
                    foreach (var (key, action) in _postChangedActions)
                    {
                        try
                        {
                            action.Invoke(post);
                        }
                        catch (Exception ex)
                        { }
                    }
                });
                hubConnection.On<Guid>(nameof(ISocialHubClient.PostDeleted), postId =>
                {
                    foreach (var (key, action) in _postDeletedActions)
                    {
                        try
                        {
                            action.Invoke(postId);
                        }
                        catch (Exception ex)
                        { }
                    }
                });
                hubConnection.On<CommentDto>(nameof(ISocialHubClient.CommentAddedToThePost), comment =>
                {
                    foreach (var (key, action) in _commentAddedActions)
                    {
                        try
                        {
                            action.Invoke(comment);
                        }
                        catch (Exception ex)
                        { }
                    }
                });
                hubConnection.On<UserPhotoChangedDto>(nameof(ISocialHubClient.UserPhotoChanged), userPhotoDto =>
                {
                    foreach (var (key, action) in _userPhotoChangedActions)
                    {
                        try
                        {
                            action.Invoke(userPhotoDto);
                        }
                        catch (Exception ex)
                        { }
                    }
                });
                hubConnection.On<NotificationDto>(nameof(ISocialHubClient.NotificationGenerated), notificationDto =>
                {
                    foreach (var (key, action) in _notificationGeneratedActions)
                    {
                        try
                        {
                            action.Invoke(notificationDto);
                        }
                        catch (Exception ex)
                        { }
                    }
                });
                await hubConnection.StartAsync();
            }
            catch(Exception ex)
            {

            }
        }
        public void RemoveHandlers(string key)
        {
            if(_postChangedActions.ContainsKey(key))
                _postChangedActions.Remove(key);
            if(_postDeletedActions.ContainsKey(key))
                _postDeletedActions.Remove(key);
            if(_commentAddedActions.ContainsKey(key))
                _commentAddedActions.Remove(key);
            if(_userPhotoChangedActions.ContainsKey(key))
                _userPhotoChangedActions.Remove(key);
            if(_notificationGeneratedActions.ContainsKey(key))
                _notificationGeneratedActions.Remove(key);

        }
    }
}
