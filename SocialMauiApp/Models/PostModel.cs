using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.Graphics;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using SQLite;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;

namespace SocialMauiApp.Models
{
    public partial class PostModel : BasePostViewModel
    {
        [PrimaryKey]
        public Guid PostId { get; set; }

        [ObservableProperty]
        private Guid _userId;

        [ObservableProperty]
        private string _userName = string.Empty;

        [ObservableProperty]
        private string? _userPhotoUrl;

        public string UserPhoto => string.IsNullOrWhiteSpace(_userPhotoUrl) ? "personal.png" : UserPhotoUrl;

        [ObservableProperty]
        private string? _content;

        [ObservableProperty]
        private string? _photoUrl;
        [ObservableProperty]
        private string? comment;
        [ObservableProperty]
        private string _postedOnDisplay;

        public string PostTemplateContentViewName =>
            string.IsNullOrWhiteSpace(PhotoUrl) ? "WithNoImage" :
            string.IsNullOrEmpty(Content) ? "ImageOnly" : "WithImage";

        [ObservableProperty]
        private bool _isLiked;

        [ObservableProperty]
        private bool _isBookmarked;

        [ObservableProperty]
        private int _likeCount;

        [ObservableProperty]
        private int _commentCount;

        [Ignore]
        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";

        [Ignore]
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";

        [ObservableProperty]
        private int _isSync;

        [Ignore]
        public ObservableCollection<CommentDto> Comments { get; } = new ObservableCollection<CommentDto>();
        public ObservableCollection<ImagePreview> SelectedImagePreviews { get; } = new();
        [ObservableProperty]
        private bool _isCommentsExpanded;

        [ObservableProperty]
        private bool _isCommentsVisible;

        [ObservableProperty]
        private string _commentInput;

        [ObservableProperty]
        private bool _isEditing;

        [ObservableProperty]
        private CommentDto? _commentBeingEdited;

        [ObservableProperty]
        private CommentDto? _replyingToComment;

        [ObservableProperty]
        private bool _hasSelectedImages;

        [ObservableProperty]
        private bool _isPhotoButtonVisible;

        private readonly HashSet<Guid> _processedCommentIds = new();
        private bool _isInDetailsView;
        private readonly AuthService _authService;
        private readonly IPostApi _postsApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly ObservableCollection<FileResult> _selectedFiles = new();
        private readonly List<(string Id, ImageSource ImageSource, FileResult FileResult)> _imageFileMap = new();
        public PostModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService)
            : base(postApi, realtimeUpdatesService)
        {
            _authService = authService;
            ConfigureRealtimeUpdates();
            Task.Run(() => LoadCommentsAsync(1)); // Load 1 comment initially
            IsPhotoButtonVisible = true;
        }


        public static PostModel FromDto(PostDto dto, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService) =>
            new PostModel(postApi, realtimeUpdatesService, authService)
            {
                PostId = dto.PostId,
                UserId = dto.UserId,
                UserName = dto.UserName ?? string.Empty,
                UserPhotoUrl = dto.UserPhotoUrl,
                Content = dto.Content,
                PhotoUrl = dto.PhotoUrl,
                PostedOnDisplay = dto.PostedOnDisplay,
                IsLiked = dto.IsLiked,
                IsBookmarked = dto.IsBookmarked,
                LikeCount = dto.LikeCount,
                CommentCount = dto.CommentCount,
                IsSync = 0
            };

        [RelayCommand]
        private async Task ToggleCommentsVisibility()
        {
            IsCommentsExpanded = !IsCommentsExpanded;
            if (IsCommentsExpanded)
            {
                await LoadCommentsAsync(int.MaxValue);
            }
            else
            {
                await LoadCommentsAsync(1); // Show 1 comment when collapsed
            }
        }

        [RelayCommand]
        private void ToggleCommentsDisplay()
        {
            if (_isInDetailsView) return; // Skip in details view
            IsCommentsVisible = !IsCommentsVisible;
        }

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(CommentInput) || IsBusy) return;
            IsBusy = true;
            try
            {
                if (_realtimeUpdatesService == null)
                {
                    await ShowErrorAlertAsync("Error: Realtime service is not initialized.");
                    return;
                }
                if (_postsApi == null)
                {
                    await ShowErrorAlertAsync("Error: Post API service is not initialized.");
                    return;
                }

                await _realtimeUpdatesService.EnsureConnectedAsync();
                var dto = new SaveCommentDto
                {
                    PostId = PostId,
                    Content = CommentInput,
                    ParentCommentId = ReplyingToComment?.CommentId // Hỗ trợ trả lời comment
                };
                var serialized = JsonSerializer.Serialize(dto);

                // Xử lý ảnh nếu có
                StreamPart? photoPart = null;
                FileResult? imageFile = _selectedFiles.FirstOrDefault();
                if (imageFile != null)
                {
                    var stream = await imageFile.OpenReadAsync();
                    photoPart = new StreamPart(stream, imageFile.FileName, imageFile.ContentType);
                }

                var result = await _postsApi.SaveCommentWithImagesAsync(PostId, photoPart, serialized);
                if (result.IsSuccess && result.Data != null)
                {
                    if (!_processedCommentIds.Contains(result.Data.CommentId))
                    {
                        result.Data.Level = dto.ParentCommentId == null ? 0 : 1;
                        result.Data.UserPhotoUrl = result.Data.UserPhotoUrl ?? "default_avatar.png";
                        result.Data.IsOwnComment = _authService.User != null && result.Data.UserId == _authService.User.Id;
                        result.Data.Replies = new ObservableCollection<CommentDto>();

                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            if (!_isInDetailsView)
                            {
                                if (result.Data.Level == 0)
                                {
                                    Comments.Insert(0, result.Data);
                                }
                                else
                                {
                                    var parent = Comments.FirstOrDefault(c => c.CommentId == dto.ParentCommentId);
                                    if (parent != null)
                                    {
                                        parent.Replies ??= new ObservableCollection<CommentDto>();
                                        parent.Replies.Insert(0, result.Data);
                                        int parentIndex = Comments.IndexOf(parent);
                                        if (parentIndex >= 0) Comments[parentIndex] = parent;
                                    }
                                }
                                _processedCommentIds.Add(result.Data.CommentId);
                            }
                            CommentInput = string.Empty;
                            ClearPhotos();
                            CommentCount++;
                            OnPropertyChanged(nameof(CommentInput));
                            OnPropertyChanged(nameof(CommentCount));
                            OnPropertyChanged(nameof(Comments));
                        });
                        _realtimeUpdatesService?.NotifyCommentAddedAsync(result.Data);
                        await ToastAsync("Comment added successfully.");
                    }
                }
                else
                {
                    await ShowErrorAlertAsync($"Failed to add comment: {result.Error}");
                }
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
        private async Task RemovePhoto(string imageId)
        {
            if (string.IsNullOrEmpty(imageId) || IsBusy) return;
            IsBusy = true;
            try
            {
                var mapEntry = _imageFileMap.FirstOrDefault(x => x.Id == imageId);
                if (mapEntry.ImageSource == null) return;
                var preview = SelectedImagePreviews.FirstOrDefault(p => p.Id == imageId);
                if (preview == null) return;
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    SelectedImagePreviews.Remove(preview);
                    _selectedFiles.Remove(mapEntry.FileResult);
                    _imageFileMap.Remove(mapEntry);
                    if (mapEntry.ImageSource is StreamImageSource stream)
                    {
                        var s = stream.Stream?.Invoke(CancellationToken.None);
                        s?.Dispose();
                    }
                    HasSelectedImages = SelectedImagePreviews.Any();
                    IsPhotoButtonVisible = !HasSelectedImages;
                    OnPropertyChanged(nameof(SelectedImagePreviews));
                });
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error removing image: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task SaveEditedCommentAsync()
        {
            if (IsBusy || !IsEditing || CommentBeingEdited == null || string.IsNullOrWhiteSpace(CommentInput)) return;
            IsBusy = true;
            try
            {
                var dto = new UpdateCommentDto
                {
                    CommentId = CommentBeingEdited.CommentId,
                    Content = CommentInput,
                    IsExistingPhotoRemoved = !_selectedFiles.Any() && !string.IsNullOrEmpty(CommentBeingEdited.PhotoUrl)
                };
                var serialized = JsonSerializer.Serialize(dto);

                // Xử lý ảnh
                StreamPart? photoPart = null;
                FileResult? imageFile = _selectedFiles.FirstOrDefault();
                if (imageFile != null)
                {
                    var stream = await imageFile.OpenReadAsync();
                    photoPart = new StreamPart(stream, imageFile.FileName, imageFile.ContentType);
                    dto.IsExistingPhotoRemoved = true; // Thay ảnh cũ bằng ảnh mới
                }

                var result = await _postsApi.UpdateCommentWithImagesAsync(CommentBeingEdited.CommentId, photoPart, serialized);
                if (result.IsSuccess && result.Data != null)
                {
                    result.Data.Level = CommentBeingEdited.Level;
                    result.Data.UserPhotoUrl = result.Data.UserPhotoUrl ?? "default_avatar.png";
                    result.Data.IsOwnComment = _authService.User != null && result.Data.UserId == _authService.User.Id;
                    result.Data.Replies = CommentBeingEdited.Replies ?? new ObservableCollection<CommentDto>();

                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        if (!_isInDetailsView)
                        {
                            if (result.Data.Level == 0)
                            {
                                var existing = Comments.FirstOrDefault(c => c.CommentId == result.Data.CommentId);
                                if (existing != null)
                                {
                                    int index = Comments.IndexOf(existing);
                                    if (index >= 0) Comments[index] = result.Data;
                                }
                            }
                            else
                            {
                                var parent = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == result.Data.CommentId) == true);
                                if (parent != null && parent.Replies != null)
                                {
                                    var reply = parent.Replies.FirstOrDefault(r => r.CommentId == result.Data.CommentId);
                                    if (reply != null)
                                    {
                                        int replyIndex = parent.Replies.IndexOf(reply);
                                        if (replyIndex >= 0) parent.Replies[replyIndex] = result.Data;
                                    }
                                    int parentIndex = Comments.IndexOf(parent);
                                    if (parentIndex >= 0) Comments[parentIndex] = parent;
                                }
                            }
                            OnPropertyChanged(nameof(Comments));
                        }
                        CommentInput = string.Empty;
                        ClearPhotos();
                        IsEditing = false;
                        CommentBeingEdited = null;
                        OnPropertyChanged(nameof(CommentInput));
                    });
                    _realtimeUpdatesService?.NotifyCommentUpdated(result.Data);
                    await ToastAsync("Comment updated successfully.");
                }
                else
                {
                    await ShowErrorAlertAsync($"Failed to update comment: {result.Error}");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error updating comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task SelectPhoto()
        {
            if (IsBusy || !IsPhotoButtonVisible) return;
            IsBusy = true;
            try
            {
                var status = DeviceInfo.Platform == DevicePlatform.Android
                    ? await Permissions.RequestAsync<Permissions.StorageRead>()
                    : await Permissions.RequestAsync<Permissions.Photos>();
                if (status != PermissionStatus.Granted)
                {
                    await ToastAsync("No permission to access photos.");
                    return;
                }
                var action = await Shell.Current.DisplayActionSheet("Choose image", "Cancel", null, "Pick from Device", "Capture Photo");
                FileResult? file = null;
                if (action == "Pick from Device")
                {
                    file = await MediaPicker.Default.PickPhotoAsync(new MediaPickerOptions { Title = "Select Photo" });
                }
                else if (action == "Capture Photo")
                {
                    var cameraStatus = await Permissions.RequestAsync<Permissions.Camera>();
                    if (cameraStatus != PermissionStatus.Granted)
                    {
                        await ToastAsync("No permission to access camera.");
                        return;
                    }
                    file = await MediaPicker.Default.CapturePhotoAsync(new MediaPickerOptions { Title = "Take Photo" });
                }
                if (file == null)
                {
                    await ToastAsync("No photo selected.");
                    return;
                }
                var contentType = file.ContentType?.ToLower();
                if (contentType != "image/jpeg" && contentType != "image/png")
                {
                    await ToastAsync("Only JPEG and PNG images are supported.");
                    return;
                }
                Stream imageStream = await file.OpenReadAsync();
                using var memoryStream = new MemoryStream();
                await imageStream.CopyToAsync(memoryStream);
                imageStream.Close();
                var imageData = memoryStream.ToArray();
                var imageSource = ImageSource.FromStream(() => new MemoryStream(imageData));
                var imageId = Guid.NewGuid().ToString();
                var imagePreview = new ImagePreview { Id = imageId, Source = imageSource };
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    ClearPhotos();
                    _selectedFiles.Add(file);
                    SelectedImagePreviews.Add(imagePreview);
                    _imageFileMap.Add((imageId, imageSource, file));
                    HasSelectedImages = true;
                    IsPhotoButtonVisible = false;
                    OnPropertyChanged(nameof(SelectedImagePreviews));
                });
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error selecting image: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task DeleteCommentAsync(CommentDto commentDto)
        {
            if (IsBusy || commentDto == null || !commentDto.IsOwnComment) return;
            IsBusy = true;
            try
            {
                bool confirm = await Shell.Current.DisplayAlert("Confirm Delete",
                    $"Are you sure you want to delete this {(commentDto.Level == 1 ? "reply" : "comment")}?{(commentDto.Level == 0 ? " This will also delete all replies." : "")}",
                    "Yes", "No");
                if (!confirm) return;

                var result = await PostsApi.DeleteCommentAsync(commentDto.CommentId);
                if (result.IsSuccess)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        if (!_isInDetailsView)
                        {
                            if (commentDto.Level == 0)
                            {
                                var existing = Comments.FirstOrDefault(c => c.CommentId == commentDto.CommentId);
                                if (existing != null)
                                {
                                    Comments.Remove(existing);
                                    _processedCommentIds.Remove(commentDto.CommentId);
                                    if (existing.Replies != null)
                                    {
                                        foreach (var reply in existing.Replies)
                                        {
                                            _processedCommentIds.Remove(reply.CommentId);
                                        }
                                    }
                                }
                            }
                            else
                            {
                                var parent = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == commentDto.CommentId) == true);
                                if (parent != null && parent.Replies != null)
                                {
                                    var reply = parent.Replies.FirstOrDefault(r => r.CommentId == commentDto.CommentId);
                                    if (reply != null)
                                    {
                                        parent.Replies.Remove(reply);
                                        _processedCommentIds.Remove(commentDto.CommentId);
                                        int parentIndex = Comments.IndexOf(parent);
                                        if (parentIndex >= 0) Comments[parentIndex] = parent;
                                    }
                                }
                            }
                            CommentCount--;
                            OnPropertyChanged(nameof(Comments));
                            OnPropertyChanged(nameof(CommentCount));
                        }
                        if (IsEditing && CommentBeingEdited?.CommentId == commentDto.CommentId)
                        {
                            IsEditing = false;
                            CommentBeingEdited = null;
                            CommentInput = string.Empty;
                            OnPropertyChanged(nameof(CommentInput));
                        }
                    });
                    //_realtimeUpdatesService?.NotifyCommentDeleted(commentDto.CommentId);
                    Console.WriteLine($"Deleted comment {commentDto.CommentId} at {DateTime.Now:HH:mm tt zzz}, 28/05/2025.");
                }
                else
                {
                    await ShowErrorAlertAsync($"Failed to delete comment: {result.Error}");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error deleting comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task ReplyComment(CommentDto commentDto)
        {
            if (IsBusy || commentDto == null) return;
            await MainThread.InvokeOnMainThreadAsync(() =>
            {
                ReplyingToComment = commentDto;
                Comment = $"@{commentDto.UserName} ";
            });
        }
        [RelayCommand]
        private async Task CancelReply()
        {
            if (IsBusy) return;
            await MainThread.InvokeOnMainThreadAsync(() =>
            {
                ReplyingToComment = null;
                CommentInput = string.Empty;
                ClearPhotos();
                OnPropertyChanged(nameof(CommentInput));
            });
        }
        [RelayCommand]
        private async Task CancelEditAsync()
        {
            if (IsBusy) return;
            await MainThread.InvokeOnMainThreadAsync(() =>
            {
                IsEditing = false;
                CommentBeingEdited = null;
                CommentInput = string.Empty;
                ClearPhotos();
                OnPropertyChanged(nameof(CommentInput));
            });
        }
        [RelayCommand]
        private async Task EditCommentAsync(CommentDto commentDto)
        {
            if (IsBusy || commentDto == null || !commentDto.IsOwnComment) return;
            IsBusy = true;
            try
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    IsEditing = true;
                    CommentBeingEdited = commentDto;
                    CommentInput = commentDto.Content ?? "";
                    IsCommentsVisible = true;
                });
                ClearPhotos();
                if (!string.IsNullOrEmpty(commentDto.PhotoUrl))
                {
                    var httpClient = new HttpClient();
                    var imageBytes = await httpClient.GetByteArrayAsync(commentDto.PhotoUrl);
                    var fileName = $"{Guid.NewGuid()}.jpg";
                    var tempPath = Path.Combine(FileSystem.AppDataDirectory, fileName);
                    await File.WriteAllBytesAsync(tempPath, imageBytes);
                    var fileResult = new FileResult(tempPath, "image/jpeg") { FileName = fileName };
                    var imageSource = ImageSource.FromFile(tempPath);
                    var imageId = Guid.NewGuid().ToString();
                    var imagePreview = new ImagePreview { Id = imageId, Source = imageSource };
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        _selectedFiles.Clear();
                        SelectedImagePreviews.Clear();
                        _imageFileMap.Clear();
                        _selectedFiles.Add(fileResult);
                        SelectedImagePreviews.Add(imagePreview);
                        _imageFileMap.Add((imageId, imageSource, fileResult));
                        HasSelectedImages = true;
                        IsPhotoButtonVisible = false;
                        OnPropertyChanged(nameof(SelectedImagePreviews));
                    });
                }
                await ToastAsync("You are now editing a comment");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error preparing comment for edit: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }
        private void ClearPhotos()
        {
            foreach (var mapEntry in _imageFileMap.ToList())
            {
                if (mapEntry.ImageSource is StreamImageSource stream)
                {
                    var s = stream.Stream?.Invoke(CancellationToken.None);
                    s?.Dispose();
                }
            }
            SelectedImagePreviews.Clear();
            _selectedFiles.Clear();
            _imageFileMap.Clear();
            HasSelectedImages = false;
            IsPhotoButtonVisible = true;
            OnPropertyChanged(nameof(SelectedImagePreviews));
        }

        private async Task LoadCommentsAsync(int limit)
        {
            if (IsBusy || _isInDetailsView) return;
            IsBusy = true;
            try
            {
                var comments = await PostsApi.GetPostsCommentAsync(PostId, 0, limit);
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    Comments.Clear();
                    _processedCommentIds.Clear();
                    foreach (var comment in comments.OrderByDescending(c => c.AddedOn))
                    {
                        if (!_processedCommentIds.Contains(comment.CommentId))
                        {
                            comment.Level = comment.ParentCommentId == null ? 0 : 1;
                            comment.UserPhotoUrl = comment.UserPhotoUrl ?? "default_avatar.png";
                            comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                            comment.Replies = new ObservableCollection<CommentDto>(
                                comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());
                            Comments.Add(comment);
                            _processedCommentIds.Add(comment.CommentId);
                            if (comment.Replies != null)
                            {
                                foreach (var reply in comment.Replies)
                                {
                                    reply.IsOwnComment = _authService.User != null && reply.UserId == _authService.User.Id;
                                    _processedCommentIds.Add(reply.CommentId);
                                }
                            }
                        }
                    }
                    OnPropertyChanged(nameof(Comments));
                    Console.WriteLine($"Loaded {Comments.Count} comments for post {PostId} at {DateTime.Now:HH:mm tt zzz}, 28/05/2025.");
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading comments: {ex.Message} at {DateTime.Now:HH:mm tt zzz}, 28/05/2025.");
                await ShowErrorAlertAsync($"Error loading comments: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService?.RemoveHandlers($"PostModel_{PostId}");
            _realtimeUpdatesService?.AddCommentAddedHandler($"PostModel_{PostId}", OnCommentAdded);
            _realtimeUpdatesService?.AddCommentUpdatedHandler($"PostModel_{PostId}", OnCommentUpdated);
            _realtimeUpdatesService?.AddCommentDeletedHandler($"PostModel_{PostId}", OnCommentDeleted);
            _realtimeUpdatesService?.AddPostCountsUpdatedHandler($"PostModel_{PostId}", OnPostCountsUpdated);
        }

        public void SetDetailsViewState(bool isInDetailsView)
        {
            _isInDetailsView = isInDetailsView;
            if (isInDetailsView)
            {
                IsCommentsVisible = false; // Hide comment UI in details view
            }
        }

        partial void OnIsLikedChanged(bool oldValue, bool newValue)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                OnPropertyChanged(nameof(IsLikeIcon));
            });
        }

        public void NotifyIsLikeIconChanged()
        {
            OnPropertyChanged(nameof(IsLikeIcon));
        }

        partial void OnIsBookmarkedChanged(bool oldValue, bool newValue)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                OnPropertyChanged(nameof(IsBookmarkIcon));
            });
        }

        public void NotifyIsBookmarkIconChanged()
        {
            OnPropertyChanged(nameof(IsBookmarkIcon));
        }
        private void OnCommentAdded(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (_isInDetailsView || _processedCommentIds.Contains(comment.CommentId)) return;
                comment.Level = comment.ParentCommentId == null ? 0 : 1;
                comment.UserPhotoUrl = comment.UserPhotoUrl ?? "default_avatar.png";
                comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                comment.Replies = new ObservableCollection<CommentDto>(
                    comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());
                if (comment.Level == 0)
                {
                    Comments.Insert(0, comment);
                    _processedCommentIds.Add(comment.CommentId);
                }
                else
                {
                    var parent = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                    if (parent != null)
                    {
                        parent.Replies ??= new ObservableCollection<CommentDto>();
                        parent.Replies.Insert(0, comment);
                        int parentIndex = Comments.IndexOf(parent);
                        if (parentIndex >= 0) Comments[parentIndex] = parent;
                    }
                    else
                    {
                        Comments.Insert(0, comment);
                    }
                    _processedCommentIds.Add(comment.CommentId);
                }
                CommentCount++;
                OnPropertyChanged(nameof(Comments));
                OnPropertyChanged(nameof(CommentCount));
                Console.WriteLine($"Added comment {comment.CommentId} via SignalR at {DateTime.Now:HH:mm tt zzz}, 28/05/2025.");
            });
        }

        private void OnCommentUpdated(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (_isInDetailsView) return;
                comment.Level = comment.ParentCommentId == null ? 0 : 1;
                comment.UserPhotoUrl = comment.UserPhotoUrl ?? "default.png";
                comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                comment.Replies = new ObservableCollection<CommentDto>(
                    comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());

                if (comment.Level == 0)
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == comment.CommentId);
                    if (existing != null)
                    {
                        int index = Comments.IndexOf(existing);
                        if (index >= 0)
                        {
                            comment.Replies = existing.Replies ?? new ObservableCollection<CommentDto>();
                            Comments[index] = comment;
                        }
                    }
                }
                else
                {
                    var parent = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == comment.CommentId) == true);
                    if (parent != null && parent.Replies != null)
                    {
                        var reply = parent.Replies?.FirstOrDefault(r => r.CommentId == comment.CommentId);
                        if (reply != null)
                        {
                            int replyIndex = parent.Replies.IndexOf(reply);
                            if (replyIndex >= 0) parent.Replies[replyIndex] = comment;
                        }
                        var parentIndex = Comments.IndexOf(parent);
                        if (parentIndex >= 0) Comments[parentIndex] = parent;
                    }
                }

                OnPropertyChanged(nameof(Comments));
                Console.WriteLine($"Updated comment {comment.CommentId} via SignalR at {DateTime.Now:HH:mm tt zzz}, 28/05/2025.");
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (_isInDetailsView) return;
                var parent = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == commentId) == true);
                if (parent != null && parent.Replies != null)
                {
                    var reply = parent.Replies.FirstOrDefault(r => r.CommentId == commentId);
                    if (reply != null)
                    {
                        parent.Replies.Remove(reply);
                        _processedCommentIds.Remove(commentId);
                        int parentIndex = Comments.IndexOf(parent);
                        if (parentIndex >= 0) Comments[parentIndex] = parent;
                    }
                }
                else
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == commentId);
                    if (existing != null)
                    {
                        Comments.Remove(existing);
                        _processedCommentIds.Remove(commentId);
                        if (existing.Replies != null)
                        {
                            foreach (var reply in existing.Replies)
                            {
                                _processedCommentIds.Remove(reply.CommentId);
                            }
                        }
                    }
                }
                CommentCount--;
                OnPropertyChanged(nameof(Comments));
                OnPropertyChanged(nameof(CommentCount));
                if (IsEditing && CommentBeingEdited?.CommentId == commentId)
                {
                    IsEditing = false;
                    CommentBeingEdited = null;
                    CommentInput = string.Empty;
                    OnPropertyChanged(nameof(CommentInput));
                }
                Console.WriteLine($"Deleted comment {commentId} via SignalR at {DateTime.Now:HH:mm tt zzz}, 28/05/2025.");
            });
        }

        private void OnPostCountsUpdated(PostDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (dto.PostId == PostId)
                {
                    CommentCount = dto.CommentCount;
                    OnPropertyChanged(nameof(CommentCount));
                }
            });
        }
        private async Task ShowErrorAlertAsync(string message)
        {
            await MainThread.InvokeOnMainThreadAsync(async () =>
            {
                await Application.Current.MainPage.DisplayAlert("Error", message, "OK");
            });
        }
    }
}