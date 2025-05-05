using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel;
using Microsoft.Maui.Dispatching;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text.Json;
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

        public DetailsViewModel(
            AuthService authService,
            IPostApi postApi,
            RealtimeUpdatesService realtimeUpdatesService
        ) : base(postApi, realtimeUpdatesService)
        {
            _authService = authService;
            _realtimeUpdatesService = realtimeUpdatesService;
            SkipGoToDetailsCommandAction = true;
            Comments = new ObservableCollection<CommentDto>();
            SelectedImagePreviews.CollectionChanged += (s, e) =>
            {
                HasSelectedImages = SelectedImagePreviews.Count > 0;
                System.Diagnostics.Debug.WriteLine($"HasSelectedImages updated to: {HasSelectedImages}, Preview count: {SelectedImagePreviews.Count}");
            };
        }

        [ObservableProperty]
        private bool _isEditing;

        [ObservableProperty]
        private CommentDto? _commentBeingEdited;

        [ObservableProperty]
        private PostModel? post;

        [ObservableProperty]
        private bool isOwnPost;

        [ObservableProperty]
        private bool _hasSelectedImages;

        public ObservableCollection<CommentDto> Comments { get; }

        public ObservableCollection<ImageSource> SelectedImagePreviews { get; } = new();

        private readonly ObservableCollection<FileResult> _selectedFiles = new();

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
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Failed to fetch comments: {ex.Message}");
            }
            finally { IsBusy = false; }
        }

        [ObservableProperty]
        private string? comment;

        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            if (IsBusy) return;
            IsBusy = true;
            try
            {
                PermissionStatus status;
                if (DeviceInfo.Platform == DevicePlatform.Android)
                {
                    status = await Permissions.RequestAsync<Permissions.StorageRead>();
                }
                else
                {
                    status = await Permissions.RequestAsync<Permissions.Photos>();
                }

                if (status != PermissionStatus.Granted)
                {
                    await ToastAsync("Không có quyền truy cập ảnh");
                    return;
                }

                var action = await Shell.Current.DisplayActionSheet(
                    "Chọn ảnh", "Hủy", null, "Thư viện", "Chụp ảnh");
                FileResult? file = null;
                if (action == "Thư viện")
                {
                    file = await MediaPicker.Default.PickPhotoAsync();
                }
                else if (action == "Chụp ảnh")
                {
                    var cameraStatus = await Permissions.RequestAsync<Permissions.Camera>();
                    if (cameraStatus != PermissionStatus.Granted)
                    {
                        await ToastAsync("Không có quyền truy cập máy ảnh");
                        return;
                    }
                    file = await MediaPicker.Default.CapturePhotoAsync();
                }

                if (file == null) return;

                var fileName = string.IsNullOrWhiteSpace(file.FileName)
                    ? $"{Guid.NewGuid()}.jpg"
                    : file.FileName;
                var tempPath = Path.Combine(FileSystem.CacheDirectory, fileName);
                using (var src = await file.OpenReadAsync())
                using (var dst = File.Create(tempPath))
                {
                    await src.CopyToAsync(dst);
                }

                System.Diagnostics.Debug.WriteLine($"Adding image to preview: {tempPath}");
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    _selectedFiles.Add(file);
                    SelectedImagePreviews.Add(ImageSource.FromFile(tempPath));
                    System.Diagnostics.Debug.WriteLine($"Image added. Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}");
                });
            }
            catch (Exception ex)
            {
                await ToastAsync($"Lỗi khi chọn ảnh: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"SelectPhotoAsync error: {ex}");
            }
            finally { IsBusy = false; }
        }

        [RelayCommand]
        private async Task RemovePhoto(ImageSource preview)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"Attempting to remove preview: {preview}");
                var idx = SelectedImagePreviews.IndexOf(preview);
                if (idx >= 0)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        SelectedImagePreviews.RemoveAt(idx);
                        if (idx < _selectedFiles.Count)
                        {
                            _selectedFiles.RemoveAt(idx);
                        }
                        System.Diagnostics.Debug.WriteLine($"Removed image at index {idx}. Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}");
                    });
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Image not found in SelectedImagePreviews");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"RemovePhoto error: {ex}");
                await ToastAsync($"Lỗi khi xóa ảnh: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task ClearPhotos()
        {
            try
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    SelectedImagePreviews.Clear();
                    _selectedFiles.Clear();
                    System.Diagnostics.Debug.WriteLine("Cleared all photos");
                });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ClearPhotos error: {ex}");
                await ToastAsync($"Lỗi khi xóa tất cả ảnh: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (Post == null)
            {
                await ToastAsync("Post not found.");
                return;
            }
            if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0)
            {
                await ToastAsync("Nhập nội dung hoặc chọn ảnh.");
                return;
            }

            IsBusy = true;
            try
            {
                await _realtimeUpdatesService.EnsureConnectedAsync();

                var dto = new SaveCommentDto
                {
                    PostId = Post.PostId,
                    Content = Comment ?? ""
                };
                var serialized = JsonSerializer.Serialize(dto);

                StreamPart? imgPart = null;
                if (_selectedFiles.Count > 0)
                {
                    var f = _selectedFiles.First();
                    using var srcStream = await f.OpenReadAsync();
                    var memoryStream = new MemoryStream();
                    await srcStream.CopyToAsync(memoryStream);
                    memoryStream.Position = 0;
                    imgPart = new StreamPart(memoryStream, f.FileName, f.ContentType ?? "image/jpeg");
                    System.Diagnostics.Debug.WriteLine($"Prepared image for upload: {f.FileName}, Size: {memoryStream.Length}");
                }

                var result = await PostsApi.SaveCommentWithImagesAsync(
                    Post.PostId,
                    imgPart,
                    serialized
                );
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }

                Comment = "";
                await ClearPhotos();
                await ToastAsync("Comment added");
            }
            catch (HttpRequestException ex)
            {
                await ShowErrorAlertAsync($"Failed to upload comment: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"AddCommentAsync HttpRequestException: {ex}");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"AddCommentAsync error: {ex}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task UpdateCommentAsync()
        {
            if (CommentBeingEdited == null || Post == null || IsBusy) return;
            if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0)
            {
                await ToastAsync("Nhập nội dung hoặc chọn ảnh.");
                return;
            }

            IsBusy = true;
            try
            {
                await _realtimeUpdatesService.EnsureConnectedAsync();

                var dto = new UpdateCommentDto
                {
                    CommentId = CommentBeingEdited.CommentId,
                    Content = Comment ?? ""
                };
                var serialized = JsonSerializer.Serialize(dto);

                StreamPart? imgPart = null;
                if (_selectedFiles.Count > 0)
                {
                    var f = _selectedFiles.First();
                    using var srcStream = await f.OpenReadAsync();
                    var memoryStream = new MemoryStream();
                    await srcStream.CopyToAsync(memoryStream);
                    memoryStream.Position = 0;
                    imgPart = new StreamPart(memoryStream, f.FileName, f.ContentType ?? "image/jpeg");
                    System.Diagnostics.Debug.WriteLine($"Prepared image for update: {f.FileName}, Size: {memoryStream.Length}");
                }

                var result = await PostsApi.UpdateCommentWithImagesAsync(
                    CommentBeingEdited.CommentId,
                    imgPart,
                    serialized
                );
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }

                Comment = "";
                IsEditing = false;
                CommentBeingEdited = null;
                await ClearPhotos();
                await ToastAsync("Comment updated");
            }
            catch (HttpRequestException ex)
            {
                await ShowErrorAlertAsync($"Failed to update comment: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"UpdateCommentAsync HttpRequestException: {ex}");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"UpdateCommentAsync error: {ex}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private void CancelEdit()
        {
            IsEditing = false;
            CommentBeingEdited = null;
            Comment = "";
            ClearPhotos();
        }

        [RelayCommand]
        private async Task EditCommentAsync(CommentDto commentDto)
        {
            if (commentDto == null || IsBusy) return;
            IsBusy = true;
            try
            {
                if (_authService.User == null || commentDto.UserId != _authService.User.Id)
                {
                    await Application.Current.MainPage.DisplayAlert("Error", "You can only edit your own comments.", "OK");
                    return;
                }
                System.Diagnostics.Debug.WriteLine($"Editing comment: {commentDto.CommentId}");

                Comment = commentDto.Content;
                IsEditing = true;
                CommentBeingEdited = commentDto;

                await ClearPhotos();

                if (!string.IsNullOrEmpty(commentDto.PhotoUrl))
                {
                    try
                    {
                        var httpClient = new HttpClient();
                        var imageBytes = await httpClient.GetByteArrayAsync(commentDto.PhotoUrl);
                        var fileName = $"{Guid.NewGuid()}.jpg";
                        var tempPath = Path.Combine(FileSystem.CacheDirectory, fileName);
                        await File.WriteAllBytesAsync(tempPath, imageBytes);

                        var fileResult = new FileResult(tempPath, "image/jpeg");
                        System.Diagnostics.Debug.WriteLine($"Loading existing comment image: {tempPath}");
                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            _selectedFiles.Add(fileResult);
                            SelectedImagePreviews.Add(ImageSource.FromFile(tempPath));
                            System.Diagnostics.Debug.WriteLine($"Added existing image to preview. Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}");
                        });

                        await ToastAsync("Editing comment with existing image. Select a new image to replace it.");
                    }
                    catch (Exception ex)
                    {
                        await ToastAsync($"Error loading comment image: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"EditCommentAsync image load error: {ex}");
                    }
                }

                await ToastAsync("You are now editing a comment");
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"EditCommentAsync error: {ex}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task DeleteCommentAsync(CommentDto commentDto)
        {
            if (commentDto == null || IsBusy) return;
            IsBusy = true;
            try
            {
                if (_authService.User == null || commentDto.UserId != _authService.User.Id)
                {
                    await Application.Current.MainPage.DisplayAlert("Error", "You can only delete your own comments.", "OK");
                    return;
                }
                bool confirm = await Shell.Current.DisplayAlert("Confirm Delete", "Are you sure?", "Yes", "No");
                if (!confirm) return;

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
                    await ClearPhotos();
                }
                Comments.Remove(commentDto);
                await ToastAsync("Comment deleted");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync error: {ex}");
            }
            finally
            {
                IsBusy = false;
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

        [RelayCommand]
        private async Task DeletePostAsync()
        {
            if (Post is null || IsBusy) return;
            if (await Shell.Current.DisplayAlert("Confirm?", "Are you sure you want to delete this post?", "Yes", "No"))
            {
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
                    System.Diagnostics.Debug.WriteLine($"DeletePostAsync error: {ex}");
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
                    Post = new PostModel(PostsApi, _realtimeUpdatesService)
                    {
                        PostId = changedPost.PostId,
                        Content = changedPost.Content,
                        PhotoUrl = changedPost.PhotoUrl,
                        IsLiked = changedPost.IsLiked,
                        IsBookmarked = changedPost.IsBookmarked,
                        UserId = Post.UserId,
                        UserName = Post.UserName,
                        UserPhotoUrl = Post.UserPhotoUrl,
                        LikeCount = Post.LikeCount,
                        CommentCount = Post.CommentCount,
                       
                    };
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
                        int index = Comments.IndexOf(existing);
                        if (index >= 0)
                        {
                            Comments.RemoveAt(index);
                            comment.IsOwnComment = comment.UserId == _authService.User?.Id;
                            Comments.Insert(index, comment);
                            System.Diagnostics.Debug.WriteLine($"Updated comment in UI: {comment.CommentId}");
                        }
                    }
                    else
                    {
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

                    if (IsEditing && CommentBeingEdited?.CommentId == commentId)
                    {
                        IsEditing = false;
                        CommentBeingEdited = null;
                        Comment = string.Empty;
                        ClearPhotos();
                        System.Diagnostics.Debug.WriteLine("Cleared edit state due to deleted comment");
                    }
                }
            });
        }

        private void OnPostCountsUpdated(PostDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
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

        private async Task ToastAsync(string message)
        {
            await CommunityToolkit.Maui.Alerts.Toast.Make(message, CommunityToolkit.Maui.Core.ToastDuration.Short).Show();
        }
    }
}