using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using DocumentFormat.OpenXml.Spreadsheet;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(Post), nameof(Post))]
    public partial class DetailsViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly IPostApi PostApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        public DetailsViewModel(AuthService authService, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
            : base(postApi)
        {
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            PostApi = postApi;
            SkipGoToDetailsCommandAction = true;
            ConfigureRealtimeUpdates();
        }

        // Make Post nullable so it can be set via QueryProperty without needing a default instance.
        [ObservableProperty]
        private PostModel? _post;

        [ObservableProperty]
        private bool _isOwnPost;

        public ObservableCollection<CommentDto> Comments { get; set; } = new ObservableCollection<CommentDto>();

        // This method is called when Post property changes (via QueryProperty).
        async partial void OnPostChanged(PostModel? value)
        {
            if (value is null)
                return;

            IsOwnPost = value.UserId == _authService.User?.Id;
            await FetchCommentsAsync();
        }

        private int _startIndex = 0;
        private const int PageSize = 10;

        private async Task FetchCommentsAsync()
        {
            if (Post is null)
                return;

            await MakeApiCall(async () =>
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
            });
        }

        [ObservableProperty]
        private string? _comment;

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(Comment))
            {
                await ToastAsync("Please enter comment");
                return;
            }

            
            await MakeApiCall(async () =>
            {
                var dto = new SaveCommentDto
                {
                    PostId = Post.PostId,
                    Content = Comment
                };
                var result = await PostApi.SaveCommentAsync(Post.PostId, dto);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
                //var newComment = result.Data;
                //// Insert the new comment at the beginning.
                //Comments.Insert(0, newComment);
                //OnPropertyChanged(nameof(Comments));
                //// Xóa text sau khi thêm thành công
                Comment = string.Empty;
            });
        }

        [RelayCommand]
        private async Task DeletePostAsync()
        {
            if (Post is null)
                return;

            if (await Shell.Current.DisplayAlert("Confirm?", "Are you sure, you want to delete this post?", "Yes", "No"))
            {
                await MakeApiCall(async () =>
                {
                    var result = await PostsApi.DeletePostAsync(Post.PostId);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }
                    await ToastAsync("Post deleted");
                    await NavigateAsync("..");
                });
            }
        }

        [RelayCommand]
        private async Task EditPostAsync(PostModel post)
        {
            var param = new Dictionary<string, object>()
            {
                [nameof(SavePostViewModel.Post)] = post
            };
            await NavigateAsync(nameof(AddPostPage), param);
        }
        private void OnPostChanged(PostDto post)
        {
            if(Post.PostId == post.PostId)
            {
                Post.Content = post.Content;
                Post.PhotoUrl = post.PhotoUrl;
            }
           
        }
        private async void OnPostDeleted(Guid postId)
        {
            if(Post.PostId == postId)
            {
                //await ToastAsync("Post no longer exists");
                await NavigateBackAsync();
            }
        }
        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            if(Post.UserId == dto.UserId)
            {
                Post.UserPhotoUrl = dto.PhotoUrl;
                foreach( var comment in Comments.Where(c=> c.UserId == dto.UserId))
                {
                    comment.UserPhotoUrl = dto.PhotoUrl;
                }
            }
        }
        private void OnCommentAdded(CommentDto dto)
        {
            if(dto.PostId == Post.PostId)
            {
                Comments = [dto, .. Comments];
                OnPropertyChanged(nameof(Comments));
            }
        }
        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddPostChangedHandler(nameof(DetailsViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(DetailsViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(DetailsViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddCommentAddedHandler(nameof(DetailsViewModel), OnCommentAdded);
        }

    }
}
