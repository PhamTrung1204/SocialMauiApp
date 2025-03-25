using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

using Microsoft.Maui.ApplicationModel; // Để gọi MainThread
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
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
        private readonly IPostApi _postApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        public DetailsViewModel(AuthService authService, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
            : base(postApi, realtimeUpdatesService)
        {
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            _postApi = postApi;
            SkipGoToDetailsCommandAction = true;
            ConfigureRealtimeUpdates();
        }

        // Post có thể null (do QueryProperty) => cần nullable
        [ObservableProperty]
        private PostModel? post;

        [ObservableProperty]
        private bool isOwnPost;

        public ObservableCollection<CommentDto> Comments { get; set; } = new();

        // Gọi khi Post thay đổi (QueryProperty)
        async partial void OnPostChanged(PostModel? value)
        {
            if (value is null) return;

            IsOwnPost = value.UserId == _authService.User?.Id;
            await FetchCommentsAsync();
        }

        private int _startIndex = 0;
        private const int PageSize = 10;

        private async Task FetchCommentsAsync()
        {
            if (Post is null) return;

            await MakeApiCall(async () =>
            {
                var comments = await _postApi.GetPostsCommentAsync(Post.PostId, _startIndex, PageSize);
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
        private string? comment;

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
                    PostId = Post!.PostId,
                    Content = Comment
                };
                var result = await _postApi.SaveCommentAsync(Post.PostId, dto);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
                // Nếu muốn thêm comment ngay (trước khi SignalR bắn sự kiện), có thể làm ở đây:
                //var newComment = result.Data;
                //Comments.Insert(0, newComment);
                //OnPropertyChanged(nameof(Comments));

                // Xóa text sau khi thêm thành công
                Comment = string.Empty;
            });
        }

        [RelayCommand]
        private async Task DeletePostAsync()
        {
            if (Post is null) return;

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
                    await NavigateAsync("..");
                });
            }
        }

        [RelayCommand]
        private async Task EditPostAsync(PostModel post)
        {
            var param = new Dictionary<string, object>
            {
                [nameof(SavePostViewModel.Post)] = post
            };
            await NavigateAsync(nameof(AddPostPage), param);
        }
        private void OnPostChanged(PostDto changedPost)
        {
            _ = MainThread.InvokeOnMainThreadAsync(() =>
            {
                if (Post is not null && Post.PostId == changedPost.PostId)
                {
                    Post.Content = changedPost.Content;
                    Post.PhotoUrl = changedPost.PhotoUrl;
                }
            });
        }
        private void OnPostDeleted(Guid postId)
        {
            _ = MainThread.InvokeOnMainThreadAsync(async () =>
            {
                if (Post is not null && Post.PostId == postId)
                {
                    await NavigateBackAsync();
                }
            });
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            _ = MainThread.InvokeOnMainThreadAsync(() =>
            {
                // Cập nhật ảnh user cho Post
                if (Post is not null && Post.UserId == dto.UserId)
                {
                    Post.UserPhotoUrl = dto.PhotoUrl;
                }
                // Cập nhật ảnh user cho các comment
                foreach (var comment in Comments.Where(c => c.UserId == dto.UserId))
                {
                    comment.UserPhotoUrl = dto.PhotoUrl;
                }
            });
        }

        private void OnCommentAdded(CommentDto dto)
        {
            _ = MainThread.InvokeOnMainThreadAsync(() =>
            {
                if (Post is not null && dto.PostId == Post.PostId)
                {
                    // Thêm comment mới lên đầu danh sách
                    Comments.Insert(0, dto);
                    OnPropertyChanged(nameof(Comments));
                }
            });
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
