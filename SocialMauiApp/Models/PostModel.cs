using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.Controls;
using Microsoft.Maui.Dispatching;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared.Dtos;
using SQLite;
using System;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using CommunityToolkit.Maui.Alerts;
using static SQLite.SQLite3;

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
        private string? _commentInput;

        [ObservableProperty]
        private DateTime? _postedOn;

        [ObservableProperty]
        private DateTime _modifiedOn;

        [ObservableProperty]
        private string _postedOnDisplay;
        [ObservableProperty]
        private bool _isContentTruncated = true;

        [ObservableProperty]
        private bool _isSeeMoreVisible;

        public string DisplayContent
        {
            get
            {
                if (string.IsNullOrEmpty(Content)) return string.Empty;
                if (IsContentTruncated && Content.Length > 100 && !string.IsNullOrWhiteSpace(PhotoUrl))
                {
                    return Content.Substring(0, 100) + "... See More";
                }
                else if (string.IsNullOrWhiteSpace(PhotoUrl) && IsContentTruncated && Content.Length > 300)
                {
                    return Content.Substring(0, 200) + "... See More";
                }
                return Content + (IsContentTruncated && IsSeeMoreVisible ? " See Less" : "");
            }
        }

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
        private readonly object _commentLock = new object();
        private IDispatcherTimer _updateTimer;

        public PostModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService)
            : base(postApi, realtimeUpdatesService)
        {
            _authService = authService ?? throw new ArgumentNullException(nameof(authService));
            _postsApi = postApi ?? throw new ArgumentNullException(nameof(postApi));
            _realtimeUpdatesService = realtimeUpdatesService ?? throw new ArgumentNullException(nameof(realtimeUpdatesService));
            ConfigureRealtimeUpdates();
            Task.Run(() => LoadCommentsAsync(1));
            IsPhotoButtonVisible = true;

            // Khởi tạo timer bằng IDispatcherTimer
            _updateTimer = Application.Current.Dispatcher.CreateTimer();
            _updateTimer.Interval = TimeSpan.FromSeconds(60); // Cập nhật mỗi phút
            //_updateTimer.Tick += OnUpdateTimerTick;
            _updateTimer.Start();

            // Gọi UpdatePostedOnDisplay ngay sau khi khởi tạo để đảm bảo giá trị ban đầu
            //UpdatePostedOnDisplay();
        }

        public static PostModel FromDto(PostDto dto, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, AuthService authService)
        {
            var model = new PostModel(postApi, realtimeUpdatesService, authService)
            {
                PostId = dto.PostId,
                UserId = dto.UserId,
                UserName = dto.UserName ?? string.Empty,
                UserPhotoUrl = dto.UserPhotoUrl,
                Content = dto.Content,
                PhotoUrl = dto.PhotoUrl,
                PostedOn = dto.PostedOn,
                ModifiedOn = dto.ModifiedOn,
                IsLiked = dto.IsLiked,
                IsBookmarked = dto.IsBookmarked,
                LikeCount = dto.LikeCount,
                CommentCount = dto.CommentCount,
                PostedOnDisplay = dto.PostedOnDisplay,
                IsSync = 0
            };

            // Không gán PostedOnDisplay từ PostDto, để UpdatePostedOnDisplay tự tính toán
            //model.UpdatePostedOnDisplay();
            return model;
        }

        [Ignore]
        public string IsLikeIcon => IsLiked ? "heart_f.png" : "heart.png";

        [Ignore]
        public string IsBookmarkIcon => IsBookmarked ? "bookmark_f.png" : "bookmark.png";

        partial void OnContentChanged(string? oldValue, string? newValue)
        {
            IsSeeMoreVisible = !string.IsNullOrEmpty(newValue) && newValue.Length > 300;
            OnPropertyChanged(nameof(DisplayContent));
        }

        [RelayCommand]
        private void ToggleContentTruncation()
        {
            IsContentTruncated = !IsContentTruncated;
            OnPropertyChanged(nameof(DisplayContent));
            OnPropertyChanged(nameof(IsSeeMoreVisible));
        }

        [RelayCommand]
        private async Task ShowLikersAsync()
        {
            if (IsBusy || LikeCount == 0) return;
            IsBusy = true;
            try
            {
                var likers = await _postsApi.GetPostLikersAsync(PostId);
                if (likers != null && likers.Any())
                {
                    var likersList = string.Join("\n", likers);
                    await Shell.Current.DisplayAlert("Users Who Liked This Post", likersList, "OK");
                }
                else
                {
                    await ToastAsync("No users have liked this post.");
                }
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error fetching likers: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task ToggleCommentsVisibility()
        {
            IsCommentsExpanded = !IsCommentsExpanded;
            IsCommentsVisible = true; // Ensure comments section is visible when toggling
            if (IsCommentsExpanded)
            {
                await LoadCommentsAsync(int.MaxValue);
            }
            else
            {
                await LoadCommentsAsync(1);
            }
            OnPropertyChanged(nameof(Comments)); // Force UI refresh
        }

        [RelayCommand]
        private void ToggleCommentsDisplay()
        {
            if (_isInDetailsView) return;
            IsCommentsVisible = !IsCommentsVisible;
            if (IsCommentsVisible && Comments.Count == 0)
            {
                // Load comments if none are present when showing the comments section
                Task.Run(() => LoadCommentsAsync(IsCommentsExpanded ? int.MaxValue : 1));
            }
            OnPropertyChanged(nameof(Comments)); // Force UI refresh
        }

        [RelayCommand]
        private async Task SaveEditedCommentAsync()
        {
            if (IsBusy || !IsEditing || CommentBeingEdited == null || string.IsNullOrWhiteSpace(CommentInput)) return;

            if (_authService.User == null)
            {
                await ToastAsync("Please log in to edit comment.");
                return;
            }

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

                StreamPart? photoPart = null;
                FileResult? imageFile = _selectedFiles.FirstOrDefault();
                if (imageFile != null)
                {
                    var stream = await imageFile.OpenReadAsync();
                    photoPart = new StreamPart(stream, imageFile.FileName, imageFile.ContentType);
                    dto.IsExistingPhotoRemoved = true;
                }

                var result = await _postsApi.UpdateCommentWithImagesAsync(CommentBeingEdited.CommentId, photoPart, serialized);
                if (result.IsSuccess && result.Data != null)
                {
                    result.Data.Level = CommentBeingEdited.Level;
                    result.Data.UserName = result.Data.UserName ?? "Unknown User";
                    result.Data.UserPhotoUrl = _authService.User.PhotoUrl ?? "user.png";
                    result.Data.IsOwnComment = result.Data.UserId == _authService.User.Id;
                    result.Data.Replies = CommentBeingEdited.Replies ?? new ObservableCollection<CommentDto>();

                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        lock (_commentLock)
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
                            CommentInput = string.Empty;
                            OnPropertyChanged(nameof(CommentInput));
                        }
                    });
                    await ClearPhotosAsync();
                    _realtimeUpdatesService.NotifyCommentUpdated(result.Data);
                    await ToastAsync("Comment updated successfully.");
                }
                else
                {
                    await ToastAsync($"Failed to update comment: {result.Error}");
                }
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error updating comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    IsEditing = false;
                    CommentBeingEdited = null;
                    OnPropertyChanged(nameof(IsEditing));
                    OnPropertyChanged(nameof(CommentBeingEdited));
                });
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
                await ClearPhotosAsync();
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
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
                await ToastAsync($"Error selecting image: {ex.Message}");
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

                var result = await _postsApi.DeleteCommentAsync(commentDto.CommentId);
                if (result.IsSuccess)
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        lock (_commentLock)
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
                        }
                    });
                    Console.WriteLine($"Deleted comment {commentDto.CommentId} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }
                else
                {
                    await ToastAsync($"Failed to delete comment: {result.Error}");
                }
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error deleting comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(CommentInput) && _selectedFiles.Count == 0) return;
            if (IsBusy) return;

            if (_authService.User == null)
            {
                await ToastAsync("Please log in to comment.");
                return;
            }

            IsBusy = true;
            Console.WriteLine($"AddCommentAsync started at {DateTime.Now:HH:mm:ss} +07, 04/06/2025. IsBusy: {IsBusy}, Comment: {CommentInput}, IsEditing: {IsEditing}");

            try
            {
                await _realtimeUpdatesService.EnsureConnectedAsync();
                Console.WriteLine($"EnsureConnectedAsync completed at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");

                if (PostId == Guid.Empty || _authService.User == null)
                {
                    Console.WriteLine($"AddCommentAsync aborted: PostId or User is invalid at {DateTime.Now:HH:mm:ss}.");
                    return;
                }

                StreamPart? imgPart = null;
                MemoryStream? memoryStream = null;
                try
                {
                    if (_selectedFiles.Count > 0)
                    {
                        var f = _selectedFiles.FirstOrDefault();
                        if (f != null)
                        {
                            var fileName = f.FileName ?? $"{Guid.NewGuid()}.jpg";
                            var srcStream = await f.OpenReadAsync();
                            memoryStream = new MemoryStream();
                            await srcStream.CopyToAsync(memoryStream);
                            srcStream.Close();
                            memoryStream.Position = 0;
                            imgPart = new StreamPart(memoryStream, fileName, f.ContentType ?? "image/jpeg");
                            Console.WriteLine($"Image prepared for comment at {DateTime.Now:HH:mm:ss}");
                        }
                    }

                    if (IsEditing && _commentBeingEdited != null)
                    {
                        // Logic chỉnh sửa comment
                        var updateDto = new UpdateCommentDto
                        {
                            CommentId = _commentBeingEdited.CommentId,
                            Content = CommentInput ?? "",
                            IsExistingPhotoRemoved = _selectedFiles.Count == 0 && !string.IsNullOrEmpty(_commentBeingEdited.PhotoUrl),
                            Photo = null
                        };
                        var serializedUpdate = JsonSerializer.Serialize(updateDto);
                        Console.WriteLine($"Serialized UpdateCommentDto for comment {_commentBeingEdited.CommentId} at {DateTime.Now:HH:mm:ss}.");

                        var updateResult = await _postsApi.UpdateCommentWithImagesAsync(_commentBeingEdited.CommentId, imgPart, serializedUpdate);
                        Console.WriteLine($"API UpdateCommentWithImagesAsync completed for comment {_commentBeingEdited.CommentId} at {DateTime.Now:HH:mm:ss} . Success: {updateResult.IsSuccess}");

                        if (updateResult.IsSuccess && updateResult.Data != null)
                        {
                            var updatedComment = new CommentDto
                            {
                                CommentId = _commentBeingEdited.CommentId,
                                PostId = PostId,
                                Content = CommentInput ?? "",
                                PhotoUrl = imgPart != null ? updateResult.Data.PhotoUrl : (updateDto.IsExistingPhotoRemoved ? null : _commentBeingEdited.PhotoUrl),
                                UserId = _commentBeingEdited.UserId,
                                UserName = _authService.User?.Name ?? updateResult.Data.UserName ?? _commentBeingEdited.UserName ?? "Unknown",
                                UserPhotoUrl = updateResult.Data.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "",
                                AddedOn = updateResult.Data.AddedOn != default ? updateResult.Data.AddedOn : _commentBeingEdited.AddedOn,
                                IsOwnComment = _authService.User != null && _commentBeingEdited.UserId == _authService.User.Id,
                                Level = _commentBeingEdited.Level,
                                ParentCommentId = _commentBeingEdited.ParentCommentId,
                                Replies = _commentBeingEdited.Replies ?? new ObservableCollection<CommentDto>()
                            };

                            await MainThread.InvokeOnMainThreadAsync(() =>
                            {
                                lock (_commentLock)
                                {
                                    if (_commentBeingEdited.Level == 0)
                                    {
                                        var existingComment = Comments.FirstOrDefault(c => c.CommentId == _commentBeingEdited.CommentId);
                                        if (existingComment != null)
                                        {
                                            int index = Comments.IndexOf(existingComment);
                                            if (index >= 0) Comments[index] = updatedComment;
                                        }
                                    }
                                    else
                                    {
                                        var parentComment = Comments.FirstOrDefault(c => c.CommentId == _commentBeingEdited.ParentCommentId);
                                        if (parentComment != null && parentComment.Replies != null)
                                        {
                                            var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == _commentBeingEdited.CommentId);
                                            if (existingReply != null)
                                            {
                                                int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                                if (replyIndex >= 0) parentComment.Replies[replyIndex] = updatedComment;
                                            }
                                        }
                                    }
                                    OnPropertyChanged(nameof(Comments));
                                    Console.WriteLine($"Updated UI for comment {updatedComment.CommentId} at {DateTime.Now:HH:mm:ss}");
                                }
                            });

                            try
                            {
                                await ToastAsync("Comment updated");
                                Console.WriteLine($"ToastAsync completed at {DateTime.Now:HH:mm:ss}.");
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Error in ToastAsync: {ex.Message}, StackTrace: {ex.StackTrace} at {DateTime.Now:HH:mm:ss}.");
                            }
                        }
                        else
                        {
                            await ToastAsync(updateResult.Error ?? "Failed to update comment");
                            Console.WriteLine($"Failed to update comment: {updateResult.Error} at {DateTime.Now:HH:mm:ss}.");
                        }
                    }
                    else
                    {
                        // Logic thêm comment mới
                        Guid? parentCommentId = null;
                        if (ReplyingToComment != null)
                        {
                            parentCommentId = ReplyingToComment.Level == 1 ? ReplyingToComment.ParentCommentId : ReplyingToComment.CommentId;
                            Console.WriteLine($"Replying to comment with ParentCommentId: {parentCommentId}");
                        }

                        var saveDto = new SaveCommentDto
                        {
                            PostId = PostId,
                            Content = CommentInput ?? "",
                            ParentCommentId = parentCommentId
                        };
                        var serializedSave = JsonSerializer.Serialize(saveDto);
                        Console.WriteLine($"Serialized SaveCommentDto for post {PostId} at {DateTime.Now:HH:mm:ss}.");

                        var saveResult = await _postsApi.SaveCommentWithImagesAsync(PostId, imgPart, serializedSave);
                        Console.WriteLine($"API SaveCommentWithImagesAsync completed for post {PostId} at {DateTime.Now:HH:mm:ss}. Success: {saveResult.IsSuccess}");

                        if (saveResult.IsSuccess && saveResult.Data != null)
                        {
                            if (!_processedCommentIds.Contains(saveResult.Data.CommentId))
                            {
                                saveResult.Data.Level = parentCommentId == null ? 0 : 1;
                                saveResult.Data.UserName = saveResult.Data.UserName ?? "Unknown User";
                                saveResult.Data.UserPhotoUrl = _authService.User?.PhotoUrl ?? "user.png";
                                saveResult.Data.IsOwnComment = saveResult.Data.UserId == _authService.User.Id;
                                saveResult.Data.Replies = new ObservableCollection<CommentDto>();

                                await MainThread.InvokeOnMainThreadAsync(() =>
                                {
                                    lock (_commentLock)
                                    {
                                        if (saveResult.Data.Level == 0 || parentCommentId == null)
                                        {
                                            Comments.Insert(0, saveResult.Data);
                                        }
                                        else
                                        {
                                            var parent = Comments.FirstOrDefault(c => c.CommentId == parentCommentId);
                                            if (parent != null)
                                            {
                                                parent.Replies ??= new ObservableCollection<CommentDto>();
                                                parent.Replies.Insert(0, saveResult.Data);
                                                int parentIndex = Comments.IndexOf(parent);
                                                if (parentIndex >= 0) Comments[parentIndex] = parent;
                                            }
                                            else
                                            {
                                                Comments.Insert(0, saveResult.Data);
                                                Console.WriteLine($"Warning: Parent comment {parentCommentId} not found, added as new comment.");
                                            }
                                        }
                                        _processedCommentIds.Add(saveResult.Data.CommentId);
                                        CommentCount++;
                                        OnPropertyChanged(nameof(CommentCount));
                                        OnPropertyChanged(nameof(Comments));
                                    }
                                });

                                try
                                {
                                    await ToastAsync(parentCommentId == null ? "Comment added" : "Reply added");
                                    Console.WriteLine($"ToastAsync completed at {DateTime.Now:HH:mm:ss}.");
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine($"Error in ToastAsync: {ex.Message}, StackTrace: {ex.StackTrace} at {DateTime.Now:HH:mm:ss}.");
                                }

                                _realtimeUpdatesService.NotifyCommentAddedAsync(saveResult.Data);
                            }
                        }
                        else
                        {
                            await ToastAsync(saveResult.Error ?? "Failed to add comment");
                            Console.WriteLine($"Failed to add comment: {saveResult.Error} at {DateTime.Now:HH:mm:ss}.");
                        }
                    }
                }
                finally
                {
                    if (memoryStream != null)
                    {
                        try
                        {
                            memoryStream.Dispose();
                            Console.WriteLine($"MemoryStream disposed at {DateTime.Now:HH:mm:ss}.");
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error disposing MemoryStream: {ex.Message}, StackTrace: {ex.StackTrace} at {DateTime.Now:HH:mm:ss}.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in AddCommentAsync: {ex.Message}, StackTrace: {ex.StackTrace} at {DateTime.Now:HH:mm:ss}.");
                await ToastAsync($"Error processing comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
                Console.WriteLine($"IsBusy set to false in finally at {DateTime.Now:HH:mm:ss}.");

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    lock (_commentLock)
                    {
                        CommentInput = string.Empty;
                        ReplyingToComment = null;
                        IsEditing = false;
                        _commentBeingEdited = null;
                        OnPropertyChanged(nameof(CommentInput));
                        OnPropertyChanged(nameof(ReplyingToComment));
                        OnPropertyChanged(nameof(IsEditing));
                        OnPropertyChanged(nameof(CommentBeingEdited));
                    }
                });

                try
                {
                    await ClearPhotosAsync();
                    Console.WriteLine($"ClearPhotosAsync completed at {DateTime.Now:HH:mm:ss}.");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error in ClearPhotosAsync: {ex.Message}, StackTrace: {ex.StackTrace} at {DateTime.Now:HH:mm:ss}.");
                }
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

                await MainThread.InvokeOnMainThreadAsync(async () =>
                {
                    SelectedImagePreviews.Remove(preview);
                    _selectedFiles.Remove(mapEntry.FileResult);
                    _imageFileMap.Remove(mapEntry);

                    if (mapEntry.ImageSource is StreamImageSource streamImageSource)
                    {
                        var streamTask = streamImageSource.Stream?.Invoke(CancellationToken.None);
                        if (streamTask != null)
                        {
                            try
                            {
                                var stream = await streamTask;
                                stream?.Dispose();
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Error disposing stream: {ex.Message} at {DateTime.Now:HH:mm:ss}.");
                            }
                        }
                    }

                    HasSelectedImages = SelectedImagePreviews.Any();
                    IsPhotoButtonVisible = !HasSelectedImages;
                    OnPropertyChanged(nameof(SelectedImagePreviews));
                    OnPropertyChanged(nameof(HasSelectedImages));
                    OnPropertyChanged(nameof(IsPhotoButtonVisible));
                });
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error removing image: {ex.Message}");
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
                CommentInput = $"@{commentDto.UserName} ";
                OnPropertyChanged(nameof(ReplyingToComment));
                OnPropertyChanged(nameof(CommentInput));
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
                OnPropertyChanged(nameof(ReplyingToComment));
                OnPropertyChanged(nameof(CommentInput));
            });
            await ClearPhotosAsync();
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
                OnPropertyChanged(nameof(CommentInput));
                OnPropertyChanged(nameof(IsEditing));
                OnPropertyChanged(nameof(CommentBeingEdited));
            });
            await ClearPhotosAsync();
        }

        [RelayCommand]
        private async Task EditCommentAsync(CommentDto commentDto)
        {
            if (IsBusy || commentDto == null || !commentDto.IsOwnComment) return;

            if (_authService.User == null)
            {
                await ToastAsync("Please log in to edit comment.");
                return;
            }

            IsBusy = true;
            try
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    IsEditing = true;
                    CommentBeingEdited = commentDto;
                    CommentInput = commentDto.Content ?? "";
                    IsCommentsVisible = true;
                    OnPropertyChanged(nameof(IsEditing));
                    OnPropertyChanged(nameof(CommentBeingEdited));
                    OnPropertyChanged(nameof(CommentInput));
                    OnPropertyChanged(nameof(IsCommentsVisible));
                });
                await ClearPhotosAsync();
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
                        UserPhotoUrl = _authService.User?.PhotoUrl ?? "";
                        OnPropertyChanged(nameof(UserPhotoUrl));
                        OnPropertyChanged(nameof(SelectedImagePreviews));
                        OnPropertyChanged(nameof(HasSelectedImages));
                        OnPropertyChanged(nameof(IsPhotoButtonVisible));
                    });
                }
                await ToastAsync("You are now editing a comment");
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error preparing comment for edit: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private async Task ClearPhotosAsync()
        {
            foreach (var mapEntry in _imageFileMap.ToList())
            {
                if (mapEntry.ImageSource is StreamImageSource streamImageSource)
                {
                    var streamTask = streamImageSource.Stream?.Invoke(CancellationToken.None);
                    if (streamTask != null)
                    {
                        try
                        {
                            var stream = await streamTask;
                            stream?.Dispose();
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error disposing stream in ClearPhotos: {ex.Message} at {DateTime.Now:HH:mm:ss} .");
                        }
                    }
                }
            }

            await MainThread.InvokeOnMainThreadAsync(() =>
            {
                SelectedImagePreviews.Clear();
                _selectedFiles.Clear();
                _imageFileMap.Clear();
                HasSelectedImages = false;
                IsPhotoButtonVisible = true;
                OnPropertyChanged(nameof(SelectedImagePreviews));
                OnPropertyChanged(nameof(HasSelectedImages));
                OnPropertyChanged(nameof(IsPhotoButtonVisible));
            });
        }

        private async Task LoadCommentsAsync(int limit)
        {
            if (IsBusy || _isInDetailsView) return;
            IsBusy = true;
            try
            {
                var comments = await _postsApi.GetPostsCommentAsync(PostId, 0, limit);
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    lock (_commentLock)
                    {
                        Comments.Clear();
                        _processedCommentIds.Clear();
                        foreach (var comment in comments.OrderByDescending(c => c.AddedOn))
                        {
                            if (!_processedCommentIds.Contains(comment.CommentId))
                            {
                                comment.Level = comment.ParentCommentId == null ? 0 : 1;
                                comment.UserName = _authService.User != null && comment.UserId == _authService.User.Id ? _authService.User.Name : (comment.UserName ?? "Unknown User");
                                comment.UserPhotoUrl = comment.UserPhoto;
                                comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                                comment.Replies = new ObservableCollection<CommentDto>(
                                    comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());
                                Comments.Add(comment);
                                _processedCommentIds.Add(comment.CommentId);
                                if (comment.Replies != null)
                                {
                                    foreach (var reply in comment.Replies)
                                    {
                                        reply.UserName = reply.UserName ?? "Unknown User";
                                        reply.UserPhotoUrl = _authService.User.PhotoUrl ?? "user.png";
                                        reply.IsOwnComment = _authService.User != null && reply.UserId == _authService.User.Id;
                                        _processedCommentIds.Add(reply.CommentId);
                                    }
                                }
                            }
                        }
                        OnPropertyChanged(nameof(Comments)); // Force UI refresh
                    }
                    Console.WriteLine($"Loaded {Comments.Count} comments for post {PostId} at {DateTime.Now:HH:mm:ss}.");
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading comments: {ex.Message} at {DateTime.Now:HH:mm:ss}.");
                await ToastAsync($"Error loading comments: {ex.Message}");
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
            _realtimeUpdatesService?.AddUserNameChangedHandler($"PostModel_{PostId}", OnUserNameChanged);
        }

        public void SetDetailsViewState(bool isInDetailsView)
        {
            _isInDetailsView = isInDetailsView;
            if (isInDetailsView)
            {
                IsCommentsVisible = false;
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
                comment.UserName = _authService.User != null && comment.UserId == _authService.User.Id
               ? _authService.User.Name
               : (comment.UserName ?? "Unknown User");
                comment.UserPhotoUrl = _authService.User.PhotoUrl ?? "user.png";
                comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                comment.Replies = new ObservableCollection<CommentDto>(
                    comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());

                lock (_commentLock)
                {
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
                }
                Console.WriteLine($"Added comment {comment.CommentId} via SignalR at {DateTime.Now:HH:mm:ss}.");
            });
        }

        private void OnCommentUpdated(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (_isInDetailsView) return;
                comment.Level = comment.ParentCommentId == null ? 0 : 1;
                comment.UserName = _authService.User != null && comment.UserId == _authService.User.Id ? _authService.User.Name : (comment.UserName ?? "Unknown User");
                comment.UserPhotoUrl = _authService.User.PhotoUrl ?? "user.png";
                comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                comment.Replies = new ObservableCollection<CommentDto>(
                    comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());

                lock (_commentLock)
                {
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
                }
                Console.WriteLine($"Updated comment {comment.CommentId} via SignalR at {DateTime.Now:HH:mm:ss}.");
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (_isInDetailsView) return;

                lock (_commentLock)
                {
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
                        OnPropertyChanged(nameof(IsEditing));
                        OnPropertyChanged(nameof(CommentBeingEdited));
                    }
                }
                Console.WriteLine($"Deleted comment {commentId} via SignalR at {DateTime.Now:HH:mm:ss}");
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

        private async Task ToastAsync(string message)
        {
            await MainThread.InvokeOnMainThreadAsync(async () =>
            {
                var toast = Toast.Make(message, CommunityToolkit.Maui.Core.ToastDuration.Short, 14);
                await toast.Show();
            });
        }

        private void OnUserNameChanged(UserNameChangedDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (dto.UserId == UserId)
                {
                    UserName = dto.NewName;
                    OnPropertyChanged(nameof(UserName));
                }

                lock (_commentLock)
                {
                    foreach (var comment in Comments.Where(c => c.UserId == dto.UserId))
                    {
                        comment.UserName = dto.NewName;
                    }
                    foreach (var comment in Comments.Where(c => c.Replies != null))
                    {
                        foreach (var reply in comment.Replies.Where(r => r.UserId == dto.UserId))
                        {
                            reply.UserName = dto.NewName;
                        }
                    }
                    OnPropertyChanged(nameof(Comments));
                }
            });
        }
        ~PostModel()
        {
            _updateTimer?.Stop();
        }
    }
}