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

        // Post có thể null do dùng QueryProperty
        [ObservableProperty]
        private PostModel? post;

        // Xác định xem bài đăng có thuộc về người dùng hiện tại hay không (tính từ Post)
        [ObservableProperty]
        private bool isOwnPost;

        // Danh sách bình luận
        public ObservableCollection<CommentDto> Comments { get; set; }

        // Khi Post thay đổi, cập nhật IsOwnPost và load lại bình luận
        async partial void OnPostChanged(PostModel? value)
        {
            if (value is null)
                return;

            // Xác định quyền sở hữu bài đăng
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

        private int _startIndex = 0;
        private const int PageSize = 10;

        [RelayCommand]
        private async Task FetchCommentsAsync()
        {
            if (Post is null)
                return;
            if (IsBusy)
                return;

            IsBusy = true;
            try
            {
                var comments = await PostsApi.GetPostsCommentAsync(Post.PostId, _startIndex, PageSize);
                if (comments.Length > 0)
                {
                    _startIndex += comments.Length;
                    // Tính toán thuộc tính IsOwnComment cho mỗi comment
                    foreach (var c in comments)
                    {
                        c.IsOwnComment = c.UserId == _authService.User?.Id;
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

        // Thêm biến để theo dõi trạng thái chỉnh sửa
        [ObservableProperty]
        private bool isEditing;

        // Lưu trữ comment đang được chỉnh sửa
        [ObservableProperty]
        private CommentDto? commentBeingEdited;

        // Command thêm hoặc cập nhật bình luận
        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(Comment))
            {
                await ToastAsync("Please enter comment");
                return;
            }

            if (IsBusy)
                return;

            IsBusy = true;
            try
            {
                // Nếu đang chỉnh sửa bình luận
                if (IsEditing && CommentBeingEdited != null)
                {
                    var result = await PostsApi.UpdateCommentAsync(CommentBeingEdited.CommentId, Comment);
                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    int index = Comments.IndexOf(CommentBeingEdited);
                    if (index >= 0)
                    {
                        Comments[index].Content = Comment;
                    }

                    // Reset trạng thái chỉnh sửa
                    IsEditing = false;
                    CommentBeingEdited = null;
                    Comment = string.Empty;
                    await ToastAsync("Comment updated");
                }
                // Thêm bình luận mới
                else
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

                    // Người dùng vừa tạo comment nên chắc chắn thuộc về họ: gán IsOwnComment = true
                    result.Data.IsOwnComment = true;
                    Comments.Insert(0, result.Data);
                    Comment = string.Empty;
                    await ToastAsync("Comment added");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error with comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        // Command sửa bình luận - giờ hiển thị comment trong khung input
        [RelayCommand]
        private async Task EditCommentAsync(CommentDto commentDto)
        {
            // Kiểm tra quyền: nếu không phải của người dùng hiện tại thì dừng
            if (commentDto.UserId != _authService.User?.Id)
                return;

            // Đặt nội dung comment vào trường nhập liệu
            Comment = commentDto.Content;
            IsEditing = true;
            CommentBeingEdited = commentDto;
        }

        // Thêm command hủy chỉnh sửa
        [RelayCommand]
        private void CancelEditAsync()
        {
            Comment = string.Empty;
            IsEditing = false;
            CommentBeingEdited = null;
        }

        // Command xóa bình luận
        [RelayCommand]
        private async Task DeleteCommentAsync(CommentDto commentDto)
        {
            if (commentDto.UserId != _authService.User?.Id)
                return;

            bool confirm = await Shell.Current.DisplayAlert("Confirm Delete", "Are you sure you want to delete this comment?", "Yes", "No");
            if (!confirm)
                return;

            try
            {
                var result = await PostsApi.DeleteCommentAsync(commentDto.CommentId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }

                // Nếu comment đang được chỉnh sửa bị xóa, reset trạng thái chỉnh sửa
                if (IsEditing && CommentBeingEdited?.CommentId == commentDto.CommentId)
                {
                    IsEditing = false;
                    CommentBeingEdited = null;
                    Comment = string.Empty;
                }

                Comments.Remove(commentDto);
                await ToastAsync("Comment deleted");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync("Error deleting comment: " + ex.Message);
            }
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

        // Các handler cho realtime updates (SignalR)
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
                if (Post is not null && Post.UserId == dto.UserId)
                {
                    Post.UserPhotoUrl = dto.PhotoUrl;
                }
                foreach (var comment in Comments.Where(c => c.UserId == dto.UserId))
                {
                    comment.UserPhotoUrl = dto.PhotoUrl;
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _realtimeUpdatesService.AddPostChangedHandler(nameof(DetailsViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(DetailsViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(DetailsViewModel), OnUserPhotoChanged);
        }

        public void RemoveRealtimeHandlers()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _isPageActive = false;
        }

        public void Cleanup()
        {
            RemoveRealtimeHandlers();
        }
    }
}