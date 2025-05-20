using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Maui.Controls;

namespace SocialMauiApp.ViewModel
{
    public partial class PostManageViewModel : BaseViewModel
    {
        private readonly AuthService _authService;
        private readonly IAdminApi _adminApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        [ObservableProperty]
        private int _postCount;

        [ObservableProperty]
        private int _commentCount;

        [ObservableProperty]
        private bool _isLoading;

        [ObservableProperty]
        private bool _isRefreshingComments;

        [ObservableProperty]
        private ObservableCollection<PostDto> _posts = new();

        [ObservableProperty]
        private ObservableCollection<CommentDto> _comments = new();

        [ObservableProperty]
        private PostDto? _selectedPost;

        [ObservableProperty]
        private CommentDto? _selectedComment;

        [ObservableProperty]
        private ObservableCollection<CommentDto> _selectedPostComments = new();

        [ObservableProperty]
        private bool _isCommentsVisible;

        private int _currentCommentPage;
        private const int _pageSize = 2;
        private bool _isLoadingMoreComments;

        public PostManageViewModel(AuthService authService, IAdminApi adminApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            _authService = authService ?? throw new ArgumentNullException(nameof(authService));
            _adminApi = adminApi ?? throw new ArgumentNullException(nameof(adminApi));
            _realtimeUpdatesService = realtimeUpdatesService ?? throw new ArgumentNullException(nameof(realtimeUpdatesService));

            // Initialize commands
            LoadDashboardCommand = new AsyncRelayCommand(LoadDashboardAsync);
            DeletePostCommand = new AsyncRelayCommand<Guid>(DeletePostAsync);
            DeleteCommentCommand = new AsyncRelayCommand<Guid>(DeleteCommentAsync);
        }

        public IAsyncRelayCommand LoadDashboardCommand { get; }
        public IAsyncRelayCommand<Guid> DeletePostCommand { get; }
        public IAsyncRelayCommand<Guid> DeleteCommentCommand { get; }

        public async Task InitializeAsync()
        {
            await LoadDashboardCommand.ExecuteAsync(null);
            ConfigureRealtimeUpdates();
        }

        public void Cleanup()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(PostManageViewModel));
            Debug.WriteLine("Cleaned up real-time handlers for PostManageViewModel.");
        }

        private async Task LoadDashboardAsync(CancellationToken cancellationToken)
        {
            if (IsLoading) return;
            IsLoading = true;

            try
            {
                // Verify admin access
                if (_authService.User == null || _authService.User.Role != "Admin")
                {
                    await ShowErrorAlertAsync("You do not have permission to access post management.");
                    await Shell.Current.GoToAsync("..");
                    return;
                }

                // Fetch dashboard data
                var dashboardData = await _adminApi.GetDashboardAsync();
                cancellationToken.ThrowIfCancellationRequested();
                Debug.WriteLine($"Dashboard data received: {JsonSerializer.Serialize(dashboardData)}");

                if (dashboardData == null)
                {
                    await ShowErrorAlertAsync("Received null dashboard data from server.");
                    return;
                }

                // Update UI properties on main thread
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    PostCount = dashboardData.PostCount;
                    CommentCount = dashboardData.CommentCount;
                    Debug.WriteLine($"UI updated - PostCount: {PostCount}, CommentCount: {CommentCount}");
                });

                // Load posts and comments
                await LoadPostsAsync(cancellationToken);
                await LoadCommentsAsync(cancellationToken);
            }
            catch (OperationCanceledException)
            {
                Debug.WriteLine("LoadDashboardAsync was canceled.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadDashboardAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load dashboard: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private async Task LoadPostsAsync(CancellationToken cancellationToken)
        {
            try
            {
                var posts = await _adminApi.GetPostsAsync(0, 10);
                cancellationToken.ThrowIfCancellationRequested();
                Debug.WriteLine($"Posts fetched: {JsonSerializer.Serialize(posts)}");

                if (posts == null)
                {
                    await ShowErrorAlertAsync("Received null post data from server.");
                    return;
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    Posts.Clear();
                    foreach (var post in posts)
                    {
                        Posts.Add(post);
                    }
                    Debug.WriteLine($"Posts collection updated: {Posts.Count} items");
                });
            }
            catch (OperationCanceledException)
            {
                Debug.WriteLine("LoadPostsAsync was canceled.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadPostsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load posts: {ex.Message}");
            }
        }

        private async Task LoadCommentsAsync(CancellationToken cancellationToken)
        {
            try
            {
                var comments = await _adminApi.GetCommentsAsync(0, 10);
                cancellationToken.ThrowIfCancellationRequested();
                Debug.WriteLine($"Comments fetched: {JsonSerializer.Serialize(comments)}");

                if (comments == null)
                {
                    await ShowErrorAlertAsync("Received null comment data from server.");
                    return;
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    Comments.Clear();
                    foreach (var comment in comments)
                    {
                        Comments.Add(comment);
                    }
                    Debug.WriteLine($"Comments collection updated: {Comments.Count} items");
                });
            }
            catch (OperationCanceledException)
            {
                Debug.WriteLine("LoadCommentsAsync was canceled.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadCommentsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load comments: {ex.Message}");
            }
        }

        private async Task LoadCommentsForPostAsync(Guid postId, int page, CancellationToken cancellationToken)
        {
            try
            {
                var comments = await _adminApi.GetCommentsForPostAsync(postId, page * _pageSize, _pageSize);
                cancellationToken.ThrowIfCancellationRequested();
                Debug.WriteLine($"Comments for post {postId}, page {page} fetched: {JsonSerializer.Serialize(comments)}");

                if (comments == null || comments.Length == 0)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        if (page == 0) SelectedPostComments.Clear();
                        Debug.WriteLine($"No more comments for post {postId} on page {page}.");
                    });
                    return;
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    if (page == 0) SelectedPostComments.Clear();
                    foreach (var comment in comments)
                    {
                        SelectedPostComments.Add(comment);
                    }
                    Debug.WriteLine($"SelectedPostComments updated: {SelectedPostComments.Count} items for post {postId}, page {page}");
                });
            }
            catch (OperationCanceledException)
            {
                Debug.WriteLine("LoadCommentsForPostAsync was canceled.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadCommentsForPostAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load comments for post: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task SelectPostAsync(PostDto? post)
        {
            if (IsLoading || post == null) return;
            IsLoading = true;

            try
            {
                if (SelectedPost?.PostId == post.PostId)
                {
                    // Toggle comments visibility
                    IsCommentsVisible = !IsCommentsVisible;
                    if (!IsCommentsVisible)
                    {
                        SelectedPostComments.Clear();
                        _currentCommentPage = 0;
                        Debug.WriteLine($"Comments hidden for post {post.PostId}.");
                    }
                }
                else
                {
                    // Select new post and load initial comments
                    SelectedPost = post;
                    IsCommentsVisible = true;
                    _currentCommentPage = 0;
                    await LoadCommentsForPostAsync(post.PostId, _currentCommentPage, CancellationToken.None);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"SelectPostAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to select post: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        [RelayCommand]
        private async Task LoadMoreCommentsAsync()
        {
            if (_isLoadingMoreComments || !IsCommentsVisible || SelectedPost == null) return;
            _isLoadingMoreComments = true;

            try
            {
                _currentCommentPage++;
                await LoadCommentsForPostAsync(SelectedPost.PostId, _currentCommentPage, CancellationToken.None);
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadMoreCommentsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load more comments: {ex.Message}");
            }
            finally
            {
                _isLoadingMoreComments = false;
            }
        }

        [RelayCommand]
        private async Task RefreshPostsAsync(CancellationToken cancellationToken)
        {
            if (IsLoading) return;
            IsLoading = true;

            try
            {
                await LoadPostsAsync(cancellationToken);
                await ToastAsync("Posts refreshed successfully.");
            }
            catch (OperationCanceledException)
            {
                Debug.WriteLine("RefreshPostsAsync was canceled.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"RefreshPostsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to refresh posts: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        [RelayCommand]
        private async Task RefreshCommentsAsync(CancellationToken cancellationToken)
        {
            if (IsRefreshingComments || !IsCommentsVisible || SelectedPost == null) return;
            IsRefreshingComments = true;

            try
            {
                _currentCommentPage = 0;
                await LoadCommentsForPostAsync(SelectedPost.PostId, _currentCommentPage, cancellationToken);
                await ToastAsync("Comments refreshed successfully.");
            }
            catch (OperationCanceledException)
            {
                Debug.WriteLine("RefreshCommentsAsync was canceled.");
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"RefreshCommentsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to refresh comments: {ex.Message}");
            }
            finally
            {
                IsRefreshingComments = false;
            }
        }

        private async Task DeletePostAsync(Guid postId)
        {
            if (IsLoading) return;
            IsLoading = true;

            try
            {
                var confirm = await Application.Current.MainPage.DisplayAlert(
                    "Confirm Delete",
                    "Are you sure you want to delete this post?",
                    "Yes", "No");

                if (!confirm) return;

                var result = await _adminApi.DeletePostAsync(postId);
                Debug.WriteLine($"DeletePost result: {JsonSerializer.Serialize(result)}");

                if (result.IsSuccess)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        var post = Posts.FirstOrDefault(p => p.PostId == postId);
                        if (post != null)
                        {
                            Posts.Remove(post);
                            PostCount--;
                        }
                        if (SelectedPost?.PostId == postId)
                        {
                            SelectedPost = null;
                            IsCommentsVisible = false;
                            SelectedPostComments.Clear();
                            _currentCommentPage = 0;
                        }
                        Debug.WriteLine($"Post deleted, new PostCount: {PostCount}");
                    });
                    await ToastAsync("Post deleted successfully.");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"DeletePostAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to delete post: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private async Task DeleteCommentAsync(Guid commentId)
        {
            if (IsLoading) return;
            IsLoading = true;

            try
            {
                var confirm = await Application.Current.MainPage.DisplayAlert(
                    "Confirm Delete",
                    "Are you sure you want to delete this comment?",
                    "Yes", "No");

                if (!confirm) return;

                var result = await _adminApi.DeleteCommentAsync(commentId);
                Debug.WriteLine($"DeleteComment result: {JsonSerializer.Serialize(result)}");

                if (result.IsSuccess)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        var comment = Comments.FirstOrDefault(c => c.CommentId == commentId);
                        if (comment != null)
                        {
                            Comments.Remove(comment);
                            CommentCount--;
                        }
                        var selectedComment = SelectedPostComments.FirstOrDefault(c => c.CommentId == commentId);
                        if (selectedComment != null)
                        {
                            SelectedPostComments.Remove(selectedComment);
                        }
                        if (SelectedComment?.CommentId == commentId)
                        {
                            SelectedComment = null;
                        }
                        Debug.WriteLine($"Comment deleted, new CommentCount: {CommentCount}");
                    });
                    await ToastAsync("Comment deleted successfully.");
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"DeleteCommentAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to delete comment: {ex.Message}");
            }
            finally
            {
                IsLoading = false;
            }
        }

        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (PostCount <= 0) return;

                PostCount--;
                var post = Posts.FirstOrDefault(p => p.PostId == postId);
                if (post != null) Posts.Remove(post);
                if (SelectedPost?.PostId == postId)
                {
                    SelectedPost = null;
                    IsCommentsVisible = false;
                    SelectedPostComments.Clear();
                    _currentCommentPage = 0;
                }
                OnPropertyChanged(nameof(PostCount));
                Debug.WriteLine($"Post deleted (realtime), new PostCount: {PostCount}");
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (CommentCount <= 0) return;

                CommentCount--;
                var comment = Comments.FirstOrDefault(c => c.CommentId == commentId);
                if (comment != null) Comments.Remove(comment);
                var selectedComment = SelectedPostComments.FirstOrDefault(c => c.CommentId == commentId);
                if (selectedComment != null) SelectedPostComments.Remove(selectedComment);
                if (SelectedComment?.CommentId == commentId) SelectedComment = null;
                OnPropertyChanged(nameof(CommentCount));
                Debug.WriteLine($"Comment deleted (realtime), new CommentCount: {CommentCount}");
            });
        }

        private void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(PostManageViewModel));
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(PostManageViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddCommentDeletedHandler(nameof(PostManageViewModel), OnCommentDeleted);
            Debug.WriteLine("Realtime updates configured for PostManageViewModel.");
        }

        private async Task ShowErrorAlertAsync(string message)
        {
            await MainThread.InvokeOnMainThreadAsync(async () =>
            {
                await Application.Current?.MainPage?.DisplayAlert("Error", message, "OK")!;
            });
        }

        private async Task ToastAsync(string message)
        {
            await CommunityToolkit.Maui.Alerts.Toast.Make(message, CommunityToolkit.Maui.Core.ToastDuration.Short).Show();
        }
    }
}
