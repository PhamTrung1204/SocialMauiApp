using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel; // Đảm bảo có MainThread
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
        private readonly IDispatcherTimer _syncTimer; // Timer để tự động đồng bộ
        private DateTime _lastSyncTime; // Lưu thời gian đồng bộ cuối
        private bool _isPageActive = false;
        public HomeViewModel(IPostApi postApi, ISyncApi syncApi, IDispatcher dispatcher, RealtimeUpdatesService realtimeUpdatesService, AuthService authService, LocalDatabase localDatabase)
            : base(postApi, realtimeUpdatesService)
        {
            _realtimeUpdatesService = realtimeUpdatesService;
            _authService = authService;
            User = authService.User!;
            Posts = new ObservableCollection<PostModel>();
            _syncApi = syncApi;
            _localDatabase = localDatabase;
            _ = FetchPostsAsync();
            _syncTimer = dispatcher.CreateTimer();
            _syncTimer.Interval = TimeSpan.FromMinutes(5); // Đồng bộ mỗi 5 phút
            _syncTimer.Tick += async (s, e) => await AutoSynchronizeDataAsync();
            _lastSyncTime = DateTime.UtcNow; // 06:45 AM UTC (01:45 PM +07, 20/05/2025)
            ConfigureRealtimeUpdates();
        }
        [ObservableProperty]
        private LoggedInUser _user;
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
        private async Task SynchronizeDataAsync()
        {
            if (IsBusy || !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet)) return;

            IsBusy = true;
            try
            {
                var result = await _syncApi.SynchronizeAsync();
                Console.WriteLine("Đồng bộ thành công: " + result.ToString());
                // Sau khi đồng bộ, làm mới danh sách bài đăng
                _startIndex = 0;
                await FetchPostsAsync();

                // Lưu SyncMetadata
                var syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = DateTime.UtcNow };
                await _localDatabase.SaveSyncMetadataAsync(syncMetadata);
            }
            catch (ApiException ex)
            {
                await ShowErrorAlertAsync($"Lỗi đồng bộ: {ex.Message}");
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
                // Kiểm tra dữ liệu trong SQLite trước
                var localPosts = await _localDatabase.GetPostsAsync();
                if (localPosts.Any() && !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet))
                {
                    if (_startIndex == 0) Posts.Clear();
                    var newPosts = localPosts.OrderByDescending(p => p.PostedOnDisplay)
                                           .Skip(_startIndex)
                                           .Take(PageSize)
                                           .Select(p => p.ToPostModel(PostsApi, _realtimeUpdatesService))
                                           .Where(p => !Posts.Any(x => x.PostId == p.PostId));
                    foreach (var post in newPosts)
                    {
                        Posts.Add(post);
                    }
                    _startIndex += newPosts.Count();
                }
                else
                {
                    // Nếu có mạng, lấy từ server và lưu vào SQLite
                    var posts = await PostsApi.GetPostsAsync(_startIndex, PageSize);
                    if (posts.Length > 0)
                    {
                        if (_startIndex == 0) Posts.Clear();
                        _startIndex += posts.Length;
                        foreach (var dto in posts.OrderByDescending(p => p.PostedOn))
                        {
                            if (!Posts.Any(p => p.PostId == dto.PostId))
                            {
                                var postModel = PostModel.FromDto(dto, PostsApi, _realtimeUpdatesService);
                                Posts.Add(postModel);

                                // Lưu vào SQLite
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
        private async Task AutoSynchronizeDataAsync()
        {
            if (!_isPageActive || IsBusy || !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet)) return;

            IsBusy = true;
            try
            {
                var newPosts = await _syncApi.GetPostsSinceAsync(_lastSyncTime);
                _lastSyncTime = DateTime.UtcNow; // 06:45 AM UTC (01:45 PM +07, 20/05/2025)

                foreach (var dto in newPosts.OrderByDescending(p => p.PostedOn))
                {
                    if (!Posts.Any(p => p.PostId == dto.PostId))
                    {
                        var postModel = PostModel.FromDto(dto, PostsApi, _realtimeUpdatesService);
                        Posts.Insert(0, postModel);
                        _startIndex++;

                        // Lưu vào SQLite
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
                await ShowErrorAlertAsync($"Lỗi đồng bộ tự động: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }
        public void OnAppearing()
        {
            _isPageActive = true;
            ConfigureRealtimeUpdates();
            Connectivity.ConnectivityChanged += OnConnectivityChanged;
            // Bắt đầu timer khi trang hiển thị
            _syncTimer.Start();
            // Đồng bộ ngay lập tức nếu có mạng
            if (Connectivity.NetworkAccess == NetworkAccess.Internet)
            {
                Task.Run(() => SynchronizeDataAsync());
            }
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
