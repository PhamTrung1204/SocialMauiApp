using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Data;
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
        private readonly ISyncApi _syncApi;
        private int _startIndex = 0;
        private readonly LocalDatabase _localDatabase;
        private const int PageSize = 7;
        private readonly IDispatcherTimer _syncTimer;
        private DateTime _lastSyncTime;
        private bool _isPageActive = false;

        public HomeViewModel(IPostApi postApi, ISyncApi syncApi, IDispatcher dispatcher, RealtimeUpdatesService realtimeUpdatesService, AuthService authService, LocalDatabase localDatabase)
            : base(postApi, realtimeUpdatesService)
        {
            _realtimeUpdatesService = realtimeUpdatesService;
            _authService = authService;
            _syncApi = syncApi;
            _localDatabase = localDatabase;
            User = authService.User!;
            Posts = new ObservableCollection<PostModel>();
            _syncTimer = dispatcher.CreateTimer();
            _syncTimer.Interval = TimeSpan.FromMinutes(5);
            _syncTimer.Tick += async (s, e) => await AutoSynchronizeDataAsync();
            _lastSyncTime = DateTime.UtcNow;
            ConfigureRealtimeUpdates();
            _ = FetchPostsAsync();
        }

        [ObservableProperty]
        private LoggedInUser _user;

        public ObservableCollection<PostModel> Posts { get; }

        [ObservableProperty]
        private PostModel? newPost;

        [ObservableProperty]
        private bool isRefreshing;

        [ObservableProperty]
        private bool isThereNewNotification;

        partial void OnNewPostChanged(PostModel? oldValue, PostModel? value)
        {
            if (value != null)
            {
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    var existingPost = Posts.FirstOrDefault(p => p.PostId == value.PostId);
                    if (existingPost != null)
                    {
                        Posts.Remove(existingPost);
                        Posts.Insert(0, value);
                        Console.WriteLine($"Updated existing post {value.PostId} on HomePage at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                    }
                    else
                    {
                        Posts.Insert(0, value);
                        _startIndex++;
                        Console.WriteLine($"Added new post {value.PostId} to HomePage at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                    }

                    var postEntity = new PostEntity
                    {
                        PostId = value.PostId,
                        UserId = value.UserId,
                        UserName = value.UserName,
                        UserPhotoUrl = value.UserPhotoUrl,
                        Content = value.Content,
                        PhotoUrl = value.PhotoUrl,
                        PostedOnDisplay = value.PostedOnDisplay,
                        IsLiked = value.IsLiked,
                        IsBookmarked = value.IsBookmarked,
                        LikeCount = value.LikeCount,
                        CommentCount = value.CommentCount,
                        IsSync = 1
                    };
                    Task.Run(() => _localDatabase.SavePostAsync(postEntity));
                    Console.WriteLine($"Saved post {value.PostId} to SQLite at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                });
            }
            else
            {
                Console.WriteLine($"OnNewPostChanged called with null value at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
            }
        }

        [RelayCommand]
        private async Task SynchronizeDataAsync()
        {
            if (IsBusy || !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet)) return;

            IsBusy = true;
            try
            {
                var result = await _syncApi.SynchronizeAsync();
                Console.WriteLine($"Synchronization successful: {result} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                _startIndex = 0;
                await FetchPostsAsync();
                var syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = DateTime.UtcNow };
                await _localDatabase.SaveSyncMetadataAsync(syncMetadata);
            }
            catch (ApiException ex)
            {
                await ShowErrorAlertAsync($"Synchronization error: {ex.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task FetchPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var localPosts = await _localDatabase.GetPostsAsync();
                if (localPosts.Any() && !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet))
                {
                    if (_startIndex == 0) Posts.Clear();
                    var newPosts = localPosts.OrderByDescending(p => p.PostedOnDisplay)
                                             .Skip(_startIndex)
                                             .Take(PageSize)
                                             .Select(p => p.ToPostModel(PostsApi, _realtimeUpdatesService, _authService))
                                             .Where(p => !Posts.Any(x => x.PostId == p.PostId));
                    foreach (var post in newPosts)
                    {
                        Posts.Add(post);
                    }
                    _startIndex += newPosts.Count();
                }
                else
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
                                var postModel = PostModel.FromDto(dto, PostsApi, _realtimeUpdatesService, _authService);
                                Posts.Add(postModel);
                                var postEntity = new PostEntity
                                {
                                    PostId = postModel.PostId,
                                    UserId = postModel.UserId,
                                    UserName = postModel.UserName,
                                    UserPhotoUrl = postModel.UserPhotoUrl,
                                    Content = postModel.Content,
                                    PhotoUrl = postModel.PhotoUrl,
                                    PostedOnDisplay = postModel.PostedOnDisplay,
                                    IsLiked = postModel.IsLiked,
                                    IsBookmarked = postModel.IsBookmarked,
                                    LikeCount = postModel.LikeCount,
                                    CommentCount = postModel.CommentCount,
                                    IsSync = 1
                                };
                                await _localDatabase.SavePostAsync(postEntity);
                            }
                        }
                    }
                }
            });
        }

        [RelayCommand]
        private async Task RefreshPostsAsync()
        {
            _startIndex = 0;
            await FetchPostsAsync();
            IsRefreshing = false;
        }

        [RelayCommand]
        private async Task GoToAddPostAsync() => await NavigateAsync(nameof(AddPostPage));

        private async Task AutoSynchronizeDataAsync()
        {
            if (!_isPageActive || IsBusy || !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet)) return;

            IsBusy = true;
            try
            {
                var newPosts = await _syncApi.GetPostsSinceAsync(_lastSyncTime);
                _lastSyncTime = DateTime.UtcNow;
                foreach (var dto in newPosts.OrderByDescending(p => p.PostedOn))
                {
                    if (!Posts.Any(p => p.PostId == dto.PostId))
                    {
                        var postModel = PostModel.FromDto(dto, PostsApi, _realtimeUpdatesService, _authService);
                        Posts.Insert(0, postModel);
                        _startIndex++;
                        var postEntity = new PostEntity
                        {
                            PostId = postModel.PostId,
                            UserId = postModel.UserId,
                            UserName = postModel.UserName,
                            UserPhotoUrl = postModel.UserPhotoUrl,
                            Content = postModel.Content,
                            PhotoUrl = postModel.PhotoUrl,
                            PostedOnDisplay = postModel.PostedOnDisplay,
                            IsLiked = postModel.IsLiked,
                            IsBookmarked = postModel.IsBookmarked,
                            LikeCount = postModel.LikeCount,
                            CommentCount = postModel.CommentCount,
                            IsSync = 1
                        };
                        await _localDatabase.SavePostAsync(postEntity);
                    }
                }
                var syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = _lastSyncTime };
                await _localDatabase.SaveSyncMetadataAsync(syncMetadata);
            }
            catch (ApiException ex)
            {
                await ShowErrorAlertAsync($"Auto-sync error: {ex.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
            }
            finally
            {
                IsBusy = false;
            }
        }

        public void OnAppearing()
        {
            _isPageActive = true;
            Task.Run(async () =>
            {
                try
                {
                    await _realtimeUpdatesService.EnsureConnectedAsync();
                    System.Diagnostics.Debug.WriteLine($"SignalR connection ensured at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                    if (Connectivity.NetworkAccess == NetworkAccess.Internet)
                    {
                        await SynchronizeDataAsync();
                        Console.WriteLine($"Synchronized data on HomePage appearing at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error ensuring SignalR connection: {ex.Message} at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                }
            });
            ConfigureRealtimeUpdates();
            Connectivity.ConnectivityChanged += OnConnectivityChanged;
            _syncTimer.Start();
        }

        private async void OnConnectivityChanged(object sender, ConnectivityChangedEventArgs e)
        {
            if (e.NetworkAccess == NetworkAccess.Internet && _isPageActive)
            {
                await SynchronizeDataAsync();
                if (!_syncTimer.IsRunning)
                {
                    _syncTimer.Start();
                }
            }
            else
            {
                _syncTimer.Stop();
            }
        }

        public void OnDisappearing()
        {
            _isPageActive = false;
            _syncTimer.Stop();
            Connectivity.ConnectivityChanged -= OnConnectivityChanged;
            _realtimeUpdatesService.RemoveHandlers(nameof(HomeViewModel));
        }

        private void OnPostChanged(PostDto updated)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var postModel = Posts.FirstOrDefault(p => p.PostId == updated.PostId);
                if (postModel != null)
                {
                    postModel.IsLiked = updated.IsLiked;
                    postModel.NotifyIsLikeIconChanged();
                    postModel.IsBookmarked = updated.IsBookmarked;
                    postModel.NotifyIsBookmarkIconChanged();
                    postModel.Content = updated.Content;
                    postModel.PhotoUrl = updated.PhotoUrl;
                }
                else
                {
                    Posts.Insert(0, PostModel.FromDto(updated, PostsApi, _realtimeUpdatesService, _authService));
                    _startIndex++;
                }
            });
        }

        private void OnPostAdded(PostDto newPost)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (!Posts.Any(p => p.PostId == newPost.PostId))
                {
                    var postModel = PostModel.FromDto(newPost, PostsApi, _realtimeUpdatesService, _authService);
                    Posts.Insert(0, postModel);
                    _startIndex++;
                    var postEntity = new PostEntity
                    {
                        PostId = postModel.PostId,
                        UserId = postModel.UserId,
                        UserName = postModel.UserName,
                        UserPhotoUrl = postModel.UserPhotoUrl,
                        Content = postModel.Content,
                        PhotoUrl = postModel.PhotoUrl,
                        PostedOnDisplay = postModel.PostedOnDisplay,
                        IsLiked = postModel.IsLiked,
                        IsBookmarked = postModel.IsBookmarked,
                        LikeCount = postModel.LikeCount,
                        CommentCount = postModel.CommentCount,
                        IsSync = 1
                    };
                    Task.Run(() => _localDatabase.SavePostAsync(postEntity));
                    Console.WriteLine($"Added new post {postModel.PostId} via SignalR at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                }
                else
                {
                    Console.WriteLine($"Post {newPost.PostId} already exists, skipping addition via SignalR at {DateTime.Now:HH:mm:ss} +07, 31/05/2025.");
                }
            });
        }

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
            _realtimeUpdatesService.AddPostAddedHandler(nameof(HomeViewModel), OnPostAdded);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(HomeViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddPostCountsUpdatedHandler(nameof(HomeViewModel), OnPostCountsUpdated);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(HomeViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddNotificationGeneratedHandler(nameof(HomeViewModel), OnNotificationGenerated);
        }
    }
}