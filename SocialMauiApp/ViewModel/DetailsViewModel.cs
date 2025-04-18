using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel;
using Microsoft.Maui.Dispatching;
using SocialMauiApp.Apis;
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
    [QueryProperty(nameof(Post), nameof(Post))]
    public partial class DetailsViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private bool _isPageActive = false;
        private int _startIndex = 0;
        private const int PageSize = 10;

        public DetailsViewModel(AuthService authService, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
            : base(postApi, realtimeUpdatesService)
        {
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            SkipGoToDetailsCommandAction = true;
            Comments = new ObservableCollection<CommentDto>();
        }

        [ObservableProperty]
        private PostModel? post;

        [ObservableProperty]
        private bool isOwnPost;

        public ObservableCollection<CommentDto> Comments { get; }

        async partial void OnPostChanged(PostModel? value)
        {
            if (value is null) return;

            IsOwnPost = value.UserId == _authService.User?.Id;
            _startIndex = 0;
            Comments.Clear();
            await FetchCommentsAsync();

            if (!_isPageActive)
            {
                _isPageActive = true;
                ConfigureRealtimeUpdates();
            }
        }

        [RelayCommand]
        private async Task FetchCommentsAsync()
        {
            if (Post is null || IsBusy) return;

            IsBusy = true;
            try
            {
                var comments = await PostsApi.GetPostsCommentAsync(Post.PostId, _startIndex, PageSize);
                if (comments.Length > 0)
                {
                    _startIndex += comments.Length;
                    foreach (var c in comments)
                    {
                        c.IsOwnComment = c.UserId == _authService.User?.Id;
                        if (!Comments.Any(x => x.CommentId == c.CommentId))
                            Comments.Add(c);
                    }
                    
                    System.Diagnostics.Debug.WriteLine($"Fetched {comments.Length} comments, total: {Comments.Count}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error fetching comments: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [ObservableProperty]
        private string? comment;

        [ObservableProperty]
        private bool isEditing;

        [ObservableProperty]
        private CommentDto? commentBeingEdited;

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(Comment))
            {
                await ToastAsync("Please enter comment");
                return;
            }
            if (IsBusy) return;

            IsBusy = true;
            try
            {
                
                await _realtimeUpdatesService.EnsureConnectedAsync();

                if (IsEditing && CommentBeingEdited != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Updating comment: {CommentBeingEdited.CommentId}");

                    var updateDto = new UpdateCommentDto { Content = Comment };
                    var result = await PostsApi.UpdateCommentAsync(CommentBeingEdited.CommentId, updateDto);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    System.Diagnostics.Debug.WriteLine($"Comment updated successfully: {result.Data.CommentId}");

                   
                    var idx = Comments.IndexOf(CommentBeingEdited);
                    if (idx >= 0)
                    {
                        Comments[idx] = result.Data; 
                    }

                    IsEditing = false;
                    CommentBeingEdited = null;
                    Comment = string.Empty;
                    
                    await ToastAsync("Comment updated");
                }
                else
                {
                    var dto = new SaveCommentDto { PostId = Post!.PostId, Content = Comment };
                    var result = await PostsApi.SaveCommentAsync(Post.PostId, dto);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }
                    
                    Comment = string.Empty;
                    await ToastAsync("Comment added");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error processing comment: {ex.Message}");
                await ShowErrorAlertAsync($"Error with comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task EditCommentAsync(CommentDto commentDto)
        {
            if (commentDto == null || IsBusy) return;
            if (_authService.User == null || commentDto.UserId != _authService.User.Id)
            {
                await Application.Current.MainPage.DisplayAlert("Error", "You can only edit your own comments.", "OK");
                return;
            }
            System.Diagnostics.Debug.WriteLine($"Editing comment: {commentDto.CommentId}");
            Comment = commentDto.Content;
            IsEditing = true;
            CommentBeingEdited = commentDto;
            await ToastAsync("You are now editing a comment");
        }

        [RelayCommand]
        private async Task DeleteCommentAsync(CommentDto commentDto)
        {
            if (commentDto == null || IsBusy) return;
            if (_authService.User == null || commentDto.UserId != _authService.User.Id)
            {
                await Application.Current.MainPage.DisplayAlert("Error", "You can only delete your own comments.", "OK");
                return;
            }
            bool confirm = await Shell.Current.DisplayAlert("Confirm Delete", "Are you sure?", "Yes", "No");
            if (!confirm) return;

            IsBusy = true;
            try
            {
                var result = await PostsApi.DeleteCommentAsync(commentDto.CommentId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
                if (IsEditing && CommentBeingEdited?.CommentId == commentDto.CommentId)
                {
                    IsEditing = false;
                    CommentBeingEdited = null;
                    Comment = string.Empty;
                }
                Comments.Remove(commentDto);
                await ToastAsync("Comment deleted");
            }
            finally
            {
                IsBusy = false;
            }
        }
        [RelayCommand]
        private async Task EditPostAsync()
        {
            if (Post == null)
                return;
            var param = new Dictionary<string, object>
            {
                [nameof(SavePostViewModel.Post)] = Post
            };
           
            await Shell.Current.GoToAsync(nameof(AddPostPage), true, param);
        }

        [RelayCommand]
        private async Task DeletePostAsync()
        {
            if (Post is null)
                return;

            if (await Shell.Current.DisplayAlert("Confirm?", "Are you sure you want to delete this post?", "Yes", "No"))
            {
                if (IsBusy)
                    return;
                IsBusy = true;
                try
                {
                    var result = await PostsApi.DeletePostAsync(Post.PostId);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }
                    await Shell.Current.GoToAsync("..");
                }
                catch (Exception ex)
                {
                    await ShowErrorAlertAsync($"Error deleting post: {ex.Message}");
                }
                finally
                {
                    IsBusy = false;
                }
            }
        }
        private void OnPostChanged(PostDto changedPost)
        {
            System.Diagnostics.Debug.WriteLine($"Received PostChanged event: {changedPost.PostId}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post?.PostId == changedPost.PostId)
                {
                    Post.Content = changedPost.Content;
                    Post.PhotoUrl = changedPost.PhotoUrl;
                    Post.IsLiked = changedPost.IsLiked;
                    Post.NotifyIsLikeIconChanged();
                    Post.IsBookmarked = changedPost.IsBookmarked;
                    Post.NotifyIsBookmarkIconChanged();
                    System.Diagnostics.Debug.WriteLine("Updated post in UI");
                }

            });
        }

        private void OnPostDeleted(Guid postId)
        {
            System.Diagnostics.Debug.WriteLine($"Received PostDeleted event: {postId}");
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post?.PostId == postId)
                {
                    System.Diagnostics.Debug.WriteLine("Navigating back due to post deletion");
                    await Shell.Current.GoToAsync("..");
                }
            });
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            System.Diagnostics.Debug.WriteLine($"Received UserPhotoChanged event: {dto.UserId}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post?.UserId == dto.UserId)
                {
                    Post.UserPhotoUrl = dto.PhotoUrl;
                    System.Diagnostics.Debug.WriteLine("Updated post user photo");
                }

                int updatedComments = 0;
                foreach (var c in Comments.Where(x => x.UserId == dto.UserId))
                {
                    c.UserPhotoUrl = dto.PhotoUrl;
                    updatedComments++;
                }

                if (updatedComments > 0)
                    System.Diagnostics.Debug.WriteLine($"Updated {updatedComments} comment photos");
            });
        }

        private void OnCommentAdded(CommentDto comment)
        {
            System.Diagnostics.Debug.WriteLine($"Received CommentAdded event: {comment.CommentId} for post {comment.PostId}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post != null && comment.PostId == Post.PostId && !Comments.Any(c => c.CommentId == comment.CommentId))
                {
                    comment.IsOwnComment = comment.UserId == _authService.User?.Id;
                    Comments.Insert(0, comment);
                    System.Diagnostics.Debug.WriteLine($"Added new comment to UI: {comment.CommentId}");
                }
            });
        }

        private void OnCommentUpdated(CommentDto comment)
        {
            System.Diagnostics.Debug.WriteLine($"Received CommentUpdated event: {comment.CommentId} for post {comment.PostId}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post != null && comment.PostId == Post.PostId)
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == comment.CommentId);
                    if (existing != null)
                    {
                        // Update the comment properties
                        existing.Content = comment.Content;
                        existing.AddedOn = comment.AddedOn;
                        System.Diagnostics.Debug.WriteLine($"Updated comment in UI: {comment.CommentId}");

                        // Force UI refresh by replacing the comment
                        int index = Comments.IndexOf(existing);
                        if (index >= 0)
                        {
                            Comments.RemoveAt(index);
                            comment.IsOwnComment = comment.UserId == _authService.User?.Id;
                            Comments.Insert(index, comment);
                            System.Diagnostics.Debug.WriteLine($"Replaced comment in collection to force UI update");
                        }
                    }
                    else
                    {
                        // If comment doesn't exist yet, add it
                        comment.IsOwnComment = comment.UserId == _authService.User?.Id;
                        Comments.Add(comment);
                        System.Diagnostics.Debug.WriteLine($"Added newly updated comment to UI: {comment.CommentId}");
                    }
                }
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            System.Diagnostics.Debug.WriteLine($"Received CommentDeleted event: {commentId}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var existing = Comments.FirstOrDefault(c => c.CommentId == commentId);
                if (existing != null)
                {
                    Comments.Remove(existing);
                    System.Diagnostics.Debug.WriteLine($"Removed comment from UI: {commentId}");

                    // If this was the comment being edited, clear the edit state
                    if (IsEditing && CommentBeingEdited?.CommentId == commentId)
                    {
                        IsEditing = false;
                        CommentBeingEdited = null;
                        Comment = string.Empty;
                        System.Diagnostics.Debug.WriteLine("Cleared edit state due to deleted comment");
                    }
                }
            });
        }
        private void OnPostCountsUpdated(PostDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                // Nếu đang xem chi tiết bài này
                if (Post is not null && Post.PostId == dto.PostId)
                {
                    Post.LikeCount = dto.LikeCount;
                    Post.CommentCount = dto.CommentCount;
                }
            });
        }
        public void ConfigureRealtimeUpdates()
        {
            System.Diagnostics.Debug.WriteLine("Configuring realtime updates for DetailsViewModel");
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _realtimeUpdatesService.AddPostChangedHandler(nameof(DetailsViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(DetailsViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(DetailsViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddCommentAddedHandler(nameof(DetailsViewModel), OnCommentAdded);
            _realtimeUpdatesService.AddCommentUpdatedHandler(nameof(DetailsViewModel), OnCommentUpdated);
            _realtimeUpdatesService.AddCommentDeletedHandler(nameof(DetailsViewModel), OnCommentDeleted);
            _realtimeUpdatesService.AddPostCountsUpdatedHandler(nameof(DetailsViewModel), OnPostCountsUpdated);
        }

        public void Cleanup()
        {
            System.Diagnostics.Debug.WriteLine("Cleaning up DetailsViewModel realtime handlers");
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _isPageActive = false;
        }
    }
}