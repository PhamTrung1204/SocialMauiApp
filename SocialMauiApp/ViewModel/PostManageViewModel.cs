using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Text.Json;
using System.Threading.Tasks;

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
        private ObservableCollection<PostDto> _posts = new ObservableCollection<PostDto>();

        [ObservableProperty]
        private ObservableCollection<CommentDto> _comments = new ObservableCollection<CommentDto>();

        [ObservableProperty]
        private PostDto? _selectedPost;

        [ObservableProperty]
        private CommentDto? _selectedComment;

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
        }

        private async Task LoadDashboardAsync()
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
                await LoadPostsAsync();
                await LoadCommentsAsync();
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

        private async Task LoadPostsAsync()
        {
            try
            {
                var posts = await _adminApi.GetPostsAsync(0, 10);
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
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadPostsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load posts: {ex.Message}");
            }
        }

        private async Task LoadCommentsAsync()
        {
            try
            {
                var comments = await _adminApi.GetCommentsAsync(0, 10);
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
            catch (Exception ex)
            {
                Debug.WriteLine($"LoadCommentsAsync error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ShowErrorAlertAsync($"Failed to load comments: {ex.Message}");
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
                if (PostCount > 0)
                {
                    PostCount--;
                    var post = Posts.FirstOrDefault(p => p.PostId == postId);
                    if (post != null) Posts.Remove(post);
                    OnPropertyChanged(nameof(PostCount));
                    Debug.WriteLine($"Post deleted (realtime), new PostCount: {PostCount}");
                }
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (CommentCount > 0)
                {
                    CommentCount--;
                    var comment = Comments.FirstOrDefault(c => c.CommentId == commentId);
                    if (comment != null) Comments.Remove(comment);
                    OnPropertyChanged(nameof(CommentCount));
                    Debug.WriteLine($"Comment deleted (realtime), new CommentCount: {CommentCount}");
                }
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
                await Application.Current.MainPage.DisplayAlert("Error", message, "OK");
            });
        }

        private async Task ToastAsync(string message)
        {
            await CommunityToolkit.Maui.Alerts.Toast.Make(message, CommunityToolkit.Maui.Core.ToastDuration.Short).Show();
        }
    }

   
}