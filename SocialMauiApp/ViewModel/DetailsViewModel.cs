using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Maui.ApplicationModel;
using Microsoft.Maui.Dispatching;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Data;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using SQLite;
using System;
using System.Collections.Generic;
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
        private readonly ISyncApi _syncApi;
        private readonly AuthService _authService;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;
        private readonly LocalDatabase _localDatabase;
        private bool _isPageActive = false;
        private bool _hasFetchedComments = false;
        private bool _isFetchingComments = false; // Prevent recursive FetchCommentsAsync calls
        private int _startIndex = 0;
        private const int PageSize = 10;
        private readonly IDispatcherTimer _syncTimer;
        private DateTime _lastSyncTime;
        private readonly List<(string Id, ImageSource ImageSource, FileResult FileResult)> _imageFileMap = new();
        private readonly HashSet<Guid> _processedCommentIds = new();
        private readonly object _commentLock = new(); // Lock for thread-safe comment processing

        public DetailsViewModel(
            AuthService authService,
            IPostApi postApi,
            ISyncApi syncApi,
            IDispatcher dispatcher,
            LocalDatabase localDatabase,
            RealtimeUpdatesService realtimeUpdatesService
        ) : base(postApi, realtimeUpdatesService)
        {
            _authService = authService;
            _syncApi = syncApi;
            _localDatabase = localDatabase;
            _realtimeUpdatesService = realtimeUpdatesService;
            SkipGoToDetailsCommandAction = true;
            Comments = new ObservableCollection<CommentDto>();
            SelectedImagePreviews.CollectionChanged += (s, e) =>
            {
                HasSelectedImages = SelectedImagePreviews.Count > 0;
                IsPhotoButtonVisible = !HasSelectedImages;
                OnPropertyChanged(nameof(HasSelectedImages));
                OnPropertyChanged(nameof(IsPhotoButtonVisible));
                Console.WriteLine($"HasSelectedImages updated to: {HasSelectedImages}, Preview count: {SelectedImagePreviews.Count} at {DateTime.Now}.");
            };
            _syncTimer = dispatcher.CreateTimer();
            _syncTimer.Interval = TimeSpan.FromMinutes(5);
            _syncTimer.Tick += async (s, e) => await AutoSynchronizeDataAsync();
            _lastSyncTime = DateTime.UtcNow;
            IsPhotoButtonVisible = true;
        }

        [ObservableProperty]
        private bool _isEditing;

        [ObservableProperty]
        private CommentDto? _commentBeingEdited;

        [ObservableProperty]
        private CommentDto? _replyingToComment;

        [ObservableProperty]
        private PostModel? post;

        [ObservableProperty]
        private bool isOwnPost;

        [ObservableProperty]
        private bool _hasSelectedImages;

        [ObservableProperty]
        private bool _isPhotoButtonVisible;

        [ObservableProperty]
        private string? comment;

        public ObservableCollection<CommentDto> Comments { get; }

        public ObservableCollection<ImagePreview> SelectedImagePreviews { get; } = new();

        private readonly ObservableCollection<FileResult> _selectedFiles = new();

        async partial void OnPostChanged(PostModel? value)
        {
            if (value is null || _isFetchingComments) return;
            value.SetDetailsViewState(true);
            IsOwnPost = _authService.User != null && value.UserId == _authService.User.Id;
            lock (_commentLock)
            {
                _startIndex = 0;
                Comments.Clear();
                _processedCommentIds.Clear();
                foreach (var comment in value.Comments)
                {
                    if (!_processedCommentIds.Contains(comment.CommentId))
                    {
                        Comments.Add(comment);
                        _processedCommentIds.Add(comment.CommentId);
                        if (comment.Replies != null)
                        {
                            foreach (var reply in comment.Replies)
                            {
                                _processedCommentIds.Add(reply.CommentId);
                            }
                        }
                    }
                }
            }

            var localPost = await _localDatabase.GetPostAsync(value.PostId);
            if (localPost != null && !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet))
            {
                Post = localPost.ToPostModel(PostsApi, _realtimeUpdatesService, _authService);
            }
            else
            {
                var postEntity = new PostEntity
                {
                    PostId = value.PostId,
                    UserId = value.UserId,
                    UserName = value.UserName,
                    UserPhotoUrl = value.UserPhotoUrl,
                    Content = value.Content,
                    PhotoUrl = value.PhotoUrl,
                    PostedOnDisplay = value.PostedOnDisplay,
                    IsLiked = value.IsLiked,
                    IsBookmarked = value.IsBookmarked,
                    LikeCount = value.LikeCount,
                    CommentCount = value.CommentCount,
                    IsSync = value.IsSync
                };
                await _localDatabase.SavePostAsync(postEntity);
                Post = value;
            }

            if (!_hasFetchedComments)
            {
                _isFetchingComments = true;
                try
                {
                    await FetchCommentsAsync();
                    _hasFetchedComments = true;
                }
                finally
                {
                    _isFetchingComments = false;
                }
            }

            if (!_isPageActive)
            {
                _isPageActive = true;
                ConfigureRealtimeUpdates();
            }
        }

        public void ResetFetchState()
        {
            _hasFetchedComments = false;
            _isPageActive = false;
            lock (_commentLock)
            {
                Comments.Clear();
                _processedCommentIds.Clear();
            }
            Console.WriteLine($"Reset fetch state for post {Post?.PostId} at {DateTime.Now}.");
        }

        [RelayCommand]
        private async Task SynchronizeDataAsync()
        {
            if (IsBusy || !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet) || Post == null) return;

            IsBusy = true;
            try
            {
                var result = await _syncApi.SynchronizeAsync();
                Console.WriteLine($"Synchronize successful: {result} at {DateTime.Now}.");
                if (Post != null)
                {
                    var postEntity = new PostEntity
                    {
                        PostId = Post.PostId,
                        UserId = Post.UserId,
                        UserName = Post.UserName,
                        UserPhotoUrl = Post.UserPhotoUrl,
                        Content = Post.Content,
                        PhotoUrl = Post.PhotoUrl,
                        PostedOnDisplay = Post.PostedOnDisplay,
                        IsLiked = Post.IsLiked,
                        IsBookmarked = Post.IsBookmarked,
                        LikeCount = Post.LikeCount,
                        CommentCount = Post.CommentCount,
                        IsSync = 1
                    };
                    await Task.Run(() => _localDatabase.SavePostAsync(postEntity));
                }

                if (Post != null)
                {
                    var remotePost = await PostsApi.GetPostAsync(Post.PostId);
                    if (remotePost != null && remotePost.CommentCount != Post.CommentCount && !_isFetchingComments)
                    {
                        _isFetchingComments = true;
                        try
                        {
                            await FetchCommentsAsync();
                        }
                        finally
                        {
                            _isFetchingComments = false;
                        }
                    }
                }

                _lastSyncTime = DateTime.UtcNow;
                var syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = _lastSyncTime };
                await Task.Run(() => _localDatabase.SaveSyncMetadataAsync(syncMetadata));
            }
            catch (ApiException ex)
            {
                Console.WriteLine($"Synchronize error: {ex.Message} at {DateTime.Now}.");
                await ShowErrorAlertAsync($"Synchronize error: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private async Task AutoSynchronizeDataAsync()
        {
            if (!_isPageActive || IsBusy || !Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet) || Post == null) return;

            IsBusy = true;
            try
            {
                var newComments = await _syncApi.GetCommentsSinceAsync(_lastSyncTime, Post.PostId);
                _lastSyncTime = DateTime.UtcNow;

                foreach (var comment in newComments.OrderByDescending(c => c.AddedOn))
                {
                    if (!_processedCommentIds.Contains(comment.CommentId))
                    {
                        AddCommentToCollection(comment, "AutoSync");
                        await _localDatabase.SaveCommentAsync(comment);
                        Console.WriteLine($"Saved comment {comment.CommentId} to SQLite via AutoSync at {DateTime.Now}.");
                    }
                }

                var syncMetadata = new SyncMetadata { Id = 1, LastSyncTime = _lastSyncTime };
                await _localDatabase.SaveSyncMetadataAsync(syncMetadata);
            }
            catch (ApiException ex)
            {
                await ShowErrorAlertAsync($"Auto synchronize error: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task FetchCommentsAsync()
        {
            if (Post is null || IsBusy || _isFetchingComments) return;

            _isFetchingComments = true;
            IsBusy = true;
            try
            {
                Console.WriteLine($"Fetching all comments for post {Post.PostId} at {DateTime.Now}.");

                List<CommentDto> newComments = new();
                if (!Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet))
                {
                    var localComments = await _localDatabase.GetCommentsAsync(Post.PostId, _startIndex, PageSize);
                    newComments = localComments.OrderByDescending(c => c.AddedOn).ToList();
                    _startIndex += localComments.Count;
                }
                else
                {
                    var comments = await PostsApi.GetPostsCommentAsync(Post.PostId, _startIndex, PageSize);
                    Console.WriteLine($"API returned {comments?.Length ?? 0} comments for post {Post.PostId} at {DateTime.Now}.");
                    newComments = comments?.OrderByDescending(c => c.AddedOn).ToList() ?? new List<CommentDto>();
                    _startIndex += comments?.Length ?? 0;
                }

                // Kiểm tra nếu không còn comment để tải
                if (newComments.Count < PageSize)
                {
                    _startIndex = 0; // Reset để tránh gọi lại vô hạn
                }

                await UpdateCommentsCollection(newComments, Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet) ? "API" : "Local");
            }
            catch (ApiException apiEx)
            {
                Console.WriteLine($"API error fetching comments: {apiEx.Message} at {DateTime.Now}.");
                await ShowErrorAlertAsync($"API error: {apiEx.Message}");
            }
            catch (SQLiteException sqlEx)
            {
                Console.WriteLine($"SQLite error fetching comments: {sqlEx.Message} at {DateTime.Now}.");
                await ShowErrorAlertAsync($"Database error: {sqlEx.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error fetching comments: {ex.Message} at {DateTime.Now}.");
                await ShowErrorAlertAsync($"Unexpected error: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
                _isFetchingComments = false;
            }
        }

        private async Task UpdateCommentsCollection(List<CommentDto> newComments, string source)
        {
            if (newComments.Count == 0) return; // Không xử lý nếu không có comment mới

            lock (_commentLock)
            {
                var addedComments = new List<CommentDto>();
                foreach (var comment in newComments)
                {
                    if (!_processedCommentIds.Contains(comment.CommentId))
                    {
                        comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                        comment.Level = comment.ParentCommentId == null ? 0 : 1;
                        comment.UserPhotoUrl = comment.UserPhotoUrl ?? "default_avatar.png";
                        comment.Replies = new ObservableCollection<CommentDto>(
                            comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());
                        addedComments.Add(comment);
                        _processedCommentIds.Add(comment.CommentId);
                        if (comment.Replies != null)
                        {
                            foreach (var reply in comment.Replies)
                            {
                                _processedCommentIds.Add(reply.CommentId);
                            }
                        }
                        if (source == "API")
                        {
                            _localDatabase.SaveCommentAsync(comment);
                        }
                    }
                }

                if (addedComments.Count > 0)
                {
                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        foreach (var comment in addedComments)
                        {
                            if (comment.Level == 0)
                            {
                                Comments.Insert(0, comment);
                            }
                            else
                            {
                                var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                                if (parentComment != null)
                                {
                                    parentComment.Replies ??= new ObservableCollection<CommentDto>();
                                    if (!parentComment.Replies.Any(r => r.CommentId == comment.CommentId))
                                    {
                                        parentComment.Replies.Insert(0, comment);
                                        int parentIndex = Comments.IndexOf(parentComment);
                                        if (parentIndex >= 0) Comments[parentIndex] = parentComment;
                                    }
                                }
                                else
                                {
                                    Comments.Insert(0, comment);
                                }
                            }
                        }
                        OnPropertyChanged(nameof(Comments)); // Chỉ gọi một lần sau khi thêm tất cả
                    });
                }

                Console.WriteLine($"Loaded {addedComments.Count} {source} comments for post {Post?.PostId} at {DateTime.Now}.");
            }
        }

        private void AddCommentToCollection(CommentDto comment, string source)
        {
            lock (_commentLock)
            {
                if (_processedCommentIds.Contains(comment.CommentId))
                {
                    Console.WriteLine($"Skipped duplicate comment {comment.CommentId} from {source} at {DateTime.Now}.");
                    return;
                }

                comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                comment.Level = comment.ParentCommentId == null ? 0 : 1;
                comment.UserPhotoUrl = comment.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                comment.Replies = new ObservableCollection<CommentDto>(
                    comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());

                MainThread.BeginInvokeOnMainThread(() =>
                {
                    if (comment.Level == 0)
                    {
                        Comments.Insert(0, comment);
                        _processedCommentIds.Add(comment.CommentId);
                        Console.WriteLine($"Added top-level comment {comment.CommentId} with {comment.Replies?.Count ?? 0} replies via {source} at {DateTime.Now}.");
                    }
                    else
                    {
                        var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                        if (parentComment != null)
                        {
                            parentComment.Replies ??= new ObservableCollection<CommentDto>();
                            if (!parentComment.Replies.Any(r => r.CommentId == comment.CommentId))
                            {
                                parentComment.Replies.Insert(0, comment);
                                int parentIndex = Comments.IndexOf(parentComment);
                                if (parentIndex >= 0) Comments[parentIndex] = parentComment;
                                _processedCommentIds.Add(comment.CommentId);
                                Console.WriteLine($"Added reply {comment.CommentId} to parent {parentComment.CommentId} via {source} at {DateTime.Now}.");
                            }
                        }
                        else
                        {
                            Comments.Insert(0, comment);
                            _processedCommentIds.Add(comment.CommentId);
                            Console.WriteLine($"Parent comment {comment.ParentCommentId} not found, added reply {comment.CommentId} as top-level via {source} at {DateTime.Now}.");
                        }
                    }
                    OnPropertyChanged(nameof(Comments)); // Chỉ gọi một lần sau khi thêm
                });
            }
        }

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0) return;
            if (IsBusy) return;

            IsBusy = true;
            try
            {
                await _realtimeUpdatesService.EnsureConnectedAsync();

                if (IsEditing && _commentBeingEdited != null && Post != null)
                {
                    var dto = new UpdateCommentDto
                    {
                        CommentId = _commentBeingEdited.CommentId,
                        Content = Comment ?? "",
                        IsExistingPhotoRemoved = _selectedFiles.Count == 0 && !string.IsNullOrEmpty(_commentBeingEdited.PhotoUrl),
                        Photo = null
                    };
                    var serialized = JsonSerializer.Serialize(dto);

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
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
                        }
                    }

                    var result = await PostsApi.UpdateCommentWithImagesAsync(_commentBeingEdited.CommentId, imgPart, serialized);
                    if (result.IsSuccess && result.Data != null)
                    {
                        var updatedComment = new CommentDto
                        {
                            CommentId = _commentBeingEdited.CommentId,
                            PostId = Post.PostId,
                            Content = Comment ?? "",
                            PhotoUrl = imgPart != null ? result.Data.PhotoUrl : (dto.IsExistingPhotoRemoved ? null : _commentBeingEdited.PhotoUrl),
                            UserId = _commentBeingEdited.UserId,
                            UserName = _authService.User?.Name ?? result.Data.UserName ?? _commentBeingEdited.UserName ?? "Unknown",
                            UserPhotoUrl = result.Data.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "",
                            AddedOn = result.Data.AddedOn != default ? result.Data.AddedOn : _commentBeingEdited.AddedOn,
                            IsOwnComment = _authService.User != null && _commentBeingEdited.UserId == _authService.User.Id,
                            Level = _commentBeingEdited.Level,
                            ParentCommentId = _commentBeingEdited.ParentCommentId,
                            Replies = _commentBeingEdited.Replies ?? new ObservableCollection<CommentDto>()
                        };

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
                                if (parentComment != null)
                                {
                                    if (parentComment.Replies != null)
                                    {
                                        var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == _commentBeingEdited.CommentId);
                                        if (existingReply != null)
                                        {
                                            int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                            if (replyIndex >= 0) parentComment.Replies[replyIndex] = updatedComment;
                                        }
                                    }
                                    int parentIndex = Comments.IndexOf(parentComment);
                                    if (parentIndex >= 0) Comments[parentIndex] = parentComment;
                                }
                            }
                            OnPropertyChanged(nameof(Comments));
                            Comment = string.Empty; // Xóa nội dung ô nhập
                            OnPropertyChanged(nameof(Comment));
                            IsEditing = false;
                            _commentBeingEdited = null;
                        }

                        await ClearPhotos();
                        await _localDatabase.SaveCommentAsync(updatedComment);
                        await ToastAsync("Comment updated");
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Failed to update comment");
                    }
                }
                else
                {
                    var isReply = _replyingToComment != null;
                    if (Post == null || _authService.User == null) return;

                    Guid? parentCommentId = null;
                    if (isReply)
                    {
                        parentCommentId = _replyingToComment!.Level == 1
                            ? _replyingToComment.ParentCommentId
                            : _replyingToComment.CommentId;
                    }

                    var dto = new SaveCommentDto
                    {
                        PostId = Post.PostId,
                        Content = Comment ?? "",
                        ParentCommentId = parentCommentId
                    };
                    var serialized = JsonSerializer.Serialize(dto);

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
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
                        }
                    }

                    var result = await PostsApi.SaveCommentWithImagesAsync(Post.PostId, imgPart, serialized);
                    if (result.IsSuccess && result.Data != null)
                    {
                        result.Data.IsOwnComment = _authService.User != null && result.Data.UserId == _authService.User.Id;
                        result.Data.Level = isReply ? 1 : 0;
                        result.Data.UserPhotoUrl = result.Data.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "";
                        result.Data.Replies = new ObservableCollection<CommentDto>(
                            result.Data.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());

                        AddCommentToCollection(result.Data, "AddComment");
                        await _localDatabase.SaveCommentAsync(result.Data);
                        Console.WriteLine($"Saved comment {result.Data.CommentId} to SQLite at {DateTime.Now}.");

                        lock (_commentLock)
                        {
                            Comment = string.Empty; // Xóa nội dung ô nhập
                            OnPropertyChanged(nameof(Comment));
                            _replyingToComment = null;
                        }

                        await ClearPhotos();
                        await ToastAsync(isReply ? "Reply added" : "Comment added");
                    }
                    else
                    {
                        await ShowErrorAlertAsync(result.Error ?? "Failed to add comment");
                    }
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
            }
            finally
            {
                lock (_commentLock)
                {
                    Comment = string.Empty; // Đảm bảo xóa nội dung ô nhập ngay cả khi có lỗi
                    OnPropertyChanged(nameof(Comment));
                    _replyingToComment = null;
                    IsEditing = false;
                    _commentBeingEdited = null;
                }
                await ClearPhotos();
                IsBusy = false;
            }
        }

        private void OnCommentAdded(CommentDto comment)
        {
            if (Post == null || comment.PostId != Post.PostId)
            {
                Console.WriteLine($"Comment {comment.CommentId} ignored: Post null or mismatched PostId at {DateTime.Now}.");
                return;
            }

            Task.Run(async () =>
            {
                var existingComment = await _localDatabase.GetCommentAsync(comment.CommentId);
                if (existingComment != null)
                {
                    Console.WriteLine($"Comment {comment.CommentId} already exists in database, skipping SignalR at {DateTime.Now}.");
                    return;
                }

                AddCommentToCollection(comment, "SignalR");
                await _localDatabase.SaveCommentAsync(comment);
                Console.WriteLine($"Saved comment {comment.CommentId} to SQLite via SignalR at {DateTime.Now}.");
            });
        }

        [RelayCommand]
        private async Task SelectPhotoAsync()
        {
            if (IsBusy || !IsPhotoButtonVisible) return;
            IsBusy = true;
            try
            {
                PermissionStatus status = DeviceInfo.Platform == DevicePlatform.Android
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

                await ClearPhotos();

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    _selectedFiles.Add(file);
                    SelectedImagePreviews.Add(imagePreview);
                    _imageFileMap.Add((imageId, imageSource, file));
                    HasSelectedImages = SelectedImagePreviews.Count > 0;
                    IsPhotoButtonVisible = false;
                    OnPropertyChanged(nameof(SelectedImagePreviews));
                    OnPropertyChanged(nameof(HasSelectedImages));
                    OnPropertyChanged(nameof(IsPhotoButtonVisible));
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

                    if (mapEntry.ImageSource is StreamImageSource streamImageSource)
                    {
                        var stream = streamImageSource.Stream?.Invoke(CancellationToken.None);
                        stream?.Dispose();
                    }

                    HasSelectedImages = SelectedImagePreviews.Count > 0;
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

        private async Task ClearPhotos()
        {
            try
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    foreach (var mapEntry in _imageFileMap.ToList())
                    {
                        if (mapEntry.ImageSource is StreamImageSource streamImageSource)
                        {
                            var stream = streamImageSource.Stream?.Invoke(CancellationToken.None);
                            stream?.Dispose();
                        }
                    }

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
            catch (Exception ex)
            {
                await ToastAsync($"Error clearing photos: {ex.Message}");
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
                Comment = string.Empty;
            });
            await ClearPhotos();
        }

        [RelayCommand]
        public async Task EditAndUpdateCommentAsync(CommentDto? commentDto)
        {
            if (IsBusy || commentDto == null) return;
            IsBusy = true;
            try
            {
                if (_authService.User == null || commentDto.UserId != _authService.User.Id) return;

                Comment = commentDto.Content ?? "";
                IsEditing = true;
                CommentBeingEdited = commentDto;
                ReplyingToComment = null;
                await ClearPhotos();

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
                        HasSelectedImages = SelectedImagePreviews.Count > 0;
                        IsPhotoButtonVisible = false;
                        OnPropertyChanged(nameof(SelectedImagePreviews));
                        OnPropertyChanged(nameof(HasSelectedImages));
                        OnPropertyChanged(nameof(IsPhotoButtonVisible));
                    });
                }
                else
                {
                    await MainThread.InvokeOnMainThreadAsync(() =>
                    {
                        HasSelectedImages = false;
                        IsPhotoButtonVisible = true;
                        OnPropertyChanged(nameof(HasSelectedImages));
                        OnPropertyChanged(nameof(IsPhotoButtonVisible));
                    });
                }

                await ToastAsync($"You are now editing a {(commentDto.Level == 1 ? "reply" : "comment")}");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task CancelEdit()
        {
            if (IsBusy) return;
            IsEditing = false;
            _commentBeingEdited = null;
            Comment = string.Empty;
            await ClearPhotos();
        }

        [RelayCommand]
        public async Task DeleteCommentAsync(CommentDto commentDto)
        {
            if (commentDto == null || IsBusy) return;
            IsBusy = true;
            try
            {
                bool confirm = await Shell.Current.DisplayAlert("Confirm Delete",
                    $"Are you sure you want to delete this {(commentDto.Level == 1 ? "reply" : "comment")}?{(commentDto.Level == 0 ? " This will also delete all replies." : "")}",
                    "Yes", "No");
                if (!confirm) return;

                var allComments = await FetchAllCommentsForPostAsync();
                await DeleteCommentRecursivelyAsync(commentDto.CommentId, allComments);

                var result = await PostsApi.DeleteCommentAsync(commentDto.CommentId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync($"Failed to delete comment: {result.Error}");
                    return;
                }

                lock (_commentLock)
                {
                    if (IsEditing && _commentBeingEdited?.CommentId == commentDto.CommentId)
                    {
                        IsEditing = false;
                        _commentBeingEdited = null;
                        Comment = string.Empty;
                    }
                    if (ReplyingToComment?.CommentId == commentDto.CommentId)
                    {
                        ReplyingToComment = null;
                        Comment = string.Empty;
                    }

                    if (commentDto.Level == 1)
                    {
                        var parentComment = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == commentDto.CommentId) == true);
                        if (parentComment != null)
                        {
                            var reply = parentComment.Replies.FirstOrDefault(r => r.CommentId == commentDto.CommentId);
                            if (reply != null)
                            {
                                parentComment.Replies.Remove(reply);
                                int parentIndex = Comments.IndexOf(parentComment);
                                if (parentIndex >= 0) Comments[parentIndex] = parentComment;
                            }
                        }
                    }
                    else
                    {
                        var existing = Comments.FirstOrDefault(c => c.CommentId == commentDto.CommentId);
                        if (existing != null)
                        {
                            Comments.Remove(existing);
                        }
                    }
                    OnPropertyChanged(nameof(Comments));
                    _processedCommentIds.Remove(commentDto.CommentId);
                }

                await _localDatabase.DeleteCommentAsync(commentDto);
                await ToastAsync($"{(commentDto.Level == 1 ? "Reply" : "Comment")} deleted");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error deleting comment: {ex.Message}");
            }
            finally
            {
                await ClearPhotos();
                IsBusy = false;
            }
        }

        private async Task<ObservableCollection<CommentDto>> FetchAllCommentsForPostAsync()
        {
            var allComments = new ObservableCollection<CommentDto>();
            int currentIndex = 0;
            while (true)
            {
                var comments = await PostsApi.GetPostsCommentAsync(Post!.PostId, currentIndex, PageSize);
                if (comments.Length == 0) break;
                foreach (var c in comments)
                {
                    c.IsOwnComment = _authService.User != null && c.UserId == _authService.User.Id;
                    c.Level = c.ParentCommentId == null ? 0 : 1;
                    c.UserPhotoUrl = c.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                    var replies = new ObservableCollection<CommentDto>(c.Replies ?? Enumerable.Empty<CommentDto>());
                    c.Replies = replies;
                    allComments.Add(c);
                }
                currentIndex += comments.Length;
            }
            return allComments;
        }

        private async Task DeleteCommentRecursivelyAsync(Guid commentId, ObservableCollection<CommentDto> allComments)
        {
            var childComments = allComments
                .Where(c => c.ParentCommentId == commentId)
                .ToList();

            foreach (var child in childComments.ToList())
            {
                await DeleteCommentRecursivelyAsync(child.CommentId, allComments);
                var result = await PostsApi.DeleteCommentAsync(child.CommentId);
                if (result.IsSuccess)
                {
                    lock (_commentLock)
                    {
                        var parentComment = allComments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == child.CommentId) == true);
                        if (parentComment != null)
                        {
                            var reply = parentComment.Replies.FirstOrDefault(r => r.CommentId == child.CommentId);
                            if (reply != null)
                            {
                                parentComment.Replies.Remove(reply);
                            }
                        }
                        else
                        {
                            var existing = allComments.FirstOrDefault(c => c.CommentId == child.CommentId);
                            if (existing != null)
                            {
                                allComments.Remove(existing);
                            }
                        }
                        var localComment = Comments.FirstOrDefault(c => c.CommentId == child.CommentId);
                        if (localComment != null)
                        {
                            Comments.Remove(localComment);
                        }
                        OnPropertyChanged(nameof(Comments));
                        _processedCommentIds.Remove(child.CommentId);
                    }

                    await _localDatabase.DeleteCommentAsync(child);
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
                }
                finally
                {
                    IsBusy = false;
                }
            }
        }

        private void OnPostUpdated(PostDto changedPost)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post?.PostId != changedPost.PostId)
                {
                    Console.WriteLine($"Post {changedPost.PostId} ignored: Mismatched PostId at {DateTime.Now}.");
                    return;
                }

                var updatedPost = new PostModel(PostsApi, _realtimeUpdatesService, _authService)
                {
                    PostId = changedPost.PostId,
                    Content = changedPost.Content,
                    PhotoUrl = changedPost.PhotoUrl,
                    IsLiked = changedPost.IsLiked,
                    IsBookmarked = changedPost.IsBookmarked,
                    UserId = Post.UserId,
                    UserName = Post.UserName,
                    UserPhotoUrl = changedPost.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png",
                    LikeCount = changedPost.LikeCount,
                    CommentCount = changedPost.CommentCount,
                    PostedOnDisplay = Post.PostedOnDisplay
                };

                Post = updatedPost;
                OnPropertyChanged(nameof(Post));
                OnPropertyChanged(nameof(IsOwnPost));

                var postEntity = new PostEntity
                {
                    PostId = Post.PostId,
                    UserId = Post.UserId,
                    UserName = Post.UserName,
                    UserPhotoUrl = Post.UserPhotoUrl,
                    Content = Post.Content,
                    PhotoUrl = Post.PhotoUrl,
                    PostedOnDisplay = Post.PostedOnDisplay,
                    IsLiked = Post.IsLiked,
                    IsBookmarked = Post.IsBookmarked,
                    LikeCount = Post.LikeCount,
                    CommentCount = Post.CommentCount,
                    IsSync = 1
                };

                try
                {
                    await Task.Run(() => _localDatabase.SavePostAsync(postEntity));
                    Console.WriteLine($"Saved updated post {Post.PostId} to SQLite at {DateTime.Now}.");
                }
                catch (SQLiteException ex)
                {
                    Console.WriteLine($"SQLite error saving post: {ex.Message} at {DateTime.Now}.");
                    await ShowErrorAlertAsync($"Database error: {ex.Message}");
                }

                if (Post.CommentCount != changedPost.CommentCount && !_isFetchingComments)
                {
                    _isFetchingComments = true;
                    try
                    {
                        await FetchCommentsAsync();
                    }
                    finally
                    {
                        _isFetchingComments = false;
                    }
                }
            });
        }

        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post?.PostId == postId)
                {
                    await _localDatabase.DeletePostAsync(postId);
                    await Shell.Current.GoToAsync("..");
                }
            });
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post?.UserId == dto.UserId)
                {
                    Post.UserPhotoUrl = dto.PhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                }

                foreach (var c in Comments.Where(x => x.UserId == dto.UserId))
                {
                    c.UserPhotoUrl = dto.PhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                    if (c.Replies != null)
                    {
                        foreach (var r in c.Replies.Where(r => r.UserId == dto.UserId))
                        {
                            r.UserPhotoUrl = dto.PhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                        }
                    }
                }
                OnPropertyChanged(nameof(Comments));
            });
        }

        private void OnCommentUpdated(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post != null && comment.PostId == Post.PostId)
                {
                    lock (_commentLock)
                    {
                        comment.Level = comment.ParentCommentId == null ? 0 : 1;
                        comment.UserPhotoUrl = comment.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                        comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                        comment.Replies = new ObservableCollection<CommentDto>(comment.Replies ?? Enumerable.Empty<CommentDto>());

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
                                    OnPropertyChanged(nameof(Comments));
                                }
                            }
                        }
                        else if (comment.Level == 1)
                        {
                            var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                            if (parentComment != null)
                            {
                                if (parentComment.Replies == null) parentComment.Replies = new ObservableCollection<CommentDto>();
                                var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == comment.CommentId);
                                if (existingReply != null)
                                {
                                    int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                    if (replyIndex >= 0) parentComment.Replies[replyIndex] = comment;
                                }
                                int parentIndex = Comments.IndexOf(parentComment);
                                if (parentIndex >= 0) Comments[parentIndex] = parentComment;
                                OnPropertyChanged(nameof(Comments));
                            }
                        }
                    }

                    await _localDatabase.SaveCommentAsync(comment);
                }
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                lock (_commentLock)
                {
                    var parentComment = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == commentId) == true);
                    if (parentComment != null)
                    {
                        var reply = parentComment.Replies.FirstOrDefault(r => r.CommentId == commentId);
                        if (reply != null)
                        {
                            parentComment.Replies.Remove(reply);
                            int parentIndex = Comments.IndexOf(parentComment);
                            if (parentIndex >= 0) Comments[parentIndex] = parentComment;
                            OnPropertyChanged(nameof(Comments));
                        }
                    }
                    else
                    {
                        var existing = Comments.FirstOrDefault(c => c.CommentId == commentId);
                        if (existing != null)
                        {
                            Comments.Remove(existing);
                            OnPropertyChanged(nameof(Comments));
                        }
                    }

                    if (IsEditing && _commentBeingEdited?.CommentId == commentId)
                    {
                        IsEditing = false;
                        _commentBeingEdited = null;
                        Comment = string.Empty;
                    }
                    if (ReplyingToComment?.CommentId == commentId)
                    {
                        ReplyingToComment = null;
                        Comment = string.Empty;
                    }
                    _processedCommentIds.Remove(commentId);
                }

                await ClearPhotos();
                await _localDatabase.DeleteCommentByIdAsync(commentId);
            });
        }

        private void OnPostCountsUpdated(PostDto dto)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post != null && Post.PostId == dto.PostId)
                {
                    bool commentCountChanged = Post.CommentCount != dto.CommentCount;
                    Post.LikeCount = dto.LikeCount;
                    Post.CommentCount = dto.CommentCount;

                    var postEntity = new PostEntity
                    {
                        PostId = Post.PostId,
                        UserId = Post.UserId,
                        UserName = Post.UserName,
                        UserPhotoUrl = Post.UserPhotoUrl,
                        Content = Post.Content,
                        PhotoUrl = Post.PhotoUrl,
                        PostedOnDisplay = Post.PostedOnDisplay,
                        IsLiked = Post.IsLiked,
                        IsBookmarked = Post.IsBookmarked,
                        LikeCount = Post.LikeCount,
                        CommentCount = Post.CommentCount,
                        IsSync = 1
                    };
                    await _localDatabase.SavePostAsync(postEntity);

                    if (commentCountChanged && !_isFetchingComments)
                    {
                        _isFetchingComments = true;
                        try
                        {
                            await FetchCommentsAsync();
                        }
                        finally
                        {
                            _isFetchingComments = false;
                        }
                    }
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _realtimeUpdatesService.AddPostChangedHandler(nameof(DetailsViewModel), OnPostUpdated);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(DetailsViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(DetailsViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddCommentAddedHandler(nameof(DetailsViewModel), OnCommentAdded);
            _realtimeUpdatesService.AddCommentUpdatedHandler(nameof(DetailsViewModel), OnCommentUpdated);
            _realtimeUpdatesService.AddCommentDeletedHandler(nameof(DetailsViewModel), OnCommentDeleted);
            _realtimeUpdatesService.AddPostCountsUpdatedHandler(nameof(DetailsViewModel), OnPostCountsUpdated);
        }

        public void OnAppearing()
        {
            _isPageActive = true;
            ConfigureRealtimeUpdates();
            Connectivity.ConnectivityChanged += OnConnectivityChanged;
            _syncTimer.Start();
            if (Connectivity.NetworkAccess.HasFlag(NetworkAccess.Internet) && Post != null)
            {
                Task.Run(() => SynchronizeDataAsync());
            }
        }

        private async void OnConnectivityChanged(object sender, ConnectivityChangedEventArgs e)
        {
            if (e.NetworkAccess.HasFlag(NetworkAccess.Internet) && _isPageActive && Post != null && !_isFetchingComments)
            {
                await SynchronizeDataAsync();
                if (!_syncTimer.IsRunning)
                {
                    _syncTimer.Start();
                }
            }
            else
            {
                _syncTimer.Stop();
            }
        }

        public void OnDisappearing()
        {
            _isPageActive = false;
            _syncTimer.Stop();
            Connectivity.ConnectivityChanged -= OnConnectivityChanged;
            Cleanup();
            Console.WriteLine($"Cleaned up DetailsViewModel for post {Post?.PostId} at {DateTime.Now}.");
        }

        public void Cleanup()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _isPageActive = false;
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