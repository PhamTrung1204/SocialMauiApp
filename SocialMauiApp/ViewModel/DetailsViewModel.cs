using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Pages;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
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

        public DetailsViewModel(AuthService authService, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
            : base(postApi, realtimeUpdatesService)
        {
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            SkipGoToDetailsCommandAction = true; // Prevent navigation loop
            Comments = new ObservableCollection<CommentDto>();
        }

        // Post can be null (due to QueryProperty) => needs to be nullable
        [ObservableProperty]
        private PostModel? post;

        [ObservableProperty]
        private bool isOwnPost;

        public ObservableCollection<CommentDto> Comments { get; set; }

        // Called when Post changes (QueryProperty)
        async partial void OnPostChanged(PostModel? value)
        {
            if (value is null) return;

            IsOwnPost = value.UserId == _authService.User?.Id;

            // Reset comments when post changes
            _startIndex = 0;
            Comments.Clear();
            await FetchCommentsAsync();

            if (!_isPageActive)
            {
                _isPageActive = true;
                ConfigureRealtimeUpdates();
            }
        }

        private int _startIndex = 0;
        private const int PageSize = 10;

        [RelayCommand]
        private async Task FetchCommentsAsync()
        {
            if (Post is null) return;
            if (IsBusy) return;

            IsBusy = true;
            try
            {
                var comments = await PostsApi.GetPostsCommentAsync(Post.PostId, _startIndex, PageSize);
                if (comments.Length > 0)
                {
                    _startIndex += comments.Length;
                    foreach (var c in comments)
                    {
                        Comments.Add(c);
                    }
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error loading comments: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [ObservableProperty]
        private string? comment;

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
                var dto = new SaveCommentDto
                {
                    PostId = Post!.PostId,
                    Content = Comment
                };
                var result = await PostsApi.SaveCommentAsync(Post.PostId, dto);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }

                // Clear text after successful addition
                Comment = string.Empty;
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error adding comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task DeletePostAsync()
        {
            if (Post is null) return;

            if (await Shell.Current.DisplayAlert("Confirm?", "Are you sure, you want to delete this post?", "Yes", "No"))
            {
                if (IsBusy) return;
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

        [RelayCommand]
        private async Task EditPostAsync()
        {
            if (Post == null) return;

            var param = new Dictionary<string, object>
            {
                [nameof(SavePostViewModel.Post)] = Post
            };
            await Shell.Current.GoToAsync(nameof(AddPostPage), true, param);
        }

        private void OnPostChanged(PostDto changedPost)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post is not null && Post.PostId == changedPost.PostId)
                {
                    Post.Content = changedPost.Content;
                    Post.PhotoUrl = changedPost.PhotoUrl;
                    Post.IsLiked = changedPost.IsLiked;
                    Post.IsBookmarked = changedPost.IsBookmarked;
                }
            });
        }

        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post is not null && Post.PostId == postId)
                {
                    await Shell.Current.GoToAsync("..");
                }
            });
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                // Update user photo for Post
                if (Post is not null && Post.UserId == dto.UserId)
                {
                    Post.UserPhotoUrl = dto.PhotoUrl;
                }

                // Update user photo for comments
                foreach (var comment in Comments.Where(c => c.UserId == dto.UserId))
                {
                    comment.UserPhotoUrl = dto.PhotoUrl;
                }
            });
        }

        private void OnCommentAdded(CommentDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post is not null && dto.PostId == Post.PostId)
                {
                    // Add new comment at the top of the list
                    Comments.Insert(0, dto);
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            // Clean existing handlers first to prevent duplicates
            RemoveRealtimeHandlers();

            _realtimeUpdatesService.AddPostChangedHandler(nameof(DetailsViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(DetailsViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(DetailsViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddCommentAddedHandler(nameof(DetailsViewModel), OnCommentAdded);
        }

        public void RemoveRealtimeHandlers()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _isPageActive = false;
        }

        // Make sure to call this when the page disappears
        public void Cleanup()
        {
            RemoveRealtimeHandlers();
        }
    }
}