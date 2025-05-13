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

        private readonly List<(string Id, ImageSource ImageSource, FileResult FileResult)> _imageFileMap = new();

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
                IsPhotoButtonVisible = !HasSelectedImages;
                OnPropertyChanged(nameof(HasSelectedImages));
                OnPropertyChanged(nameof(IsPhotoButtonVisible));
                System.Diagnostics.Debug.WriteLine($"HasSelectedImages updated to: {HasSelectedImages}, Preview count: {SelectedImagePreviews.Count}");
            };
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
            if (value is null) return;
            IsOwnPost = _authService.User != null && value.UserId == _authService.User.Id;
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
                        c.IsOwnComment = _authService.User != null && c.UserId == _authService.User.Id;
                        c.Level = c.ParentCommentId == null ? 0 : 1;
                        c.UserPhotoUrl = c.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                        // Ensure Replies is an ObservableCollection
                        var replies = new ObservableCollection<CommentDto>();
                        foreach (var reply in c.Replies ?? Enumerable.Empty<CommentDto>())
                        {
                            reply.IsOwnComment = _authService.User != null && reply.UserId == _authService.User.Id;
                            reply.Level = 1;
                            reply.UserPhotoUrl = reply.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                            replies.Add(reply);
                            System.Diagnostics.Debug.WriteLine($"Fetched reply {reply.CommentId}, UserPhotoUrl: {reply.UserPhotoUrl}, Level: {reply.Level}, IsOwnComment: {reply.IsOwnComment}, UserId: {reply.UserId}, PhotoUrl: {reply.PhotoUrl}");
                        }
                        c.Replies = replies;
                        if (!Comments.Any(x => x.CommentId == c.CommentId))
                        {
                            Comments.Add(c);
                            System.Diagnostics.Debug.WriteLine($"Fetched comment {c.CommentId}, UserPhotoUrl: {c.UserPhotoUrl}, Level: {c.Level}, IsOwnComment: {c.IsOwnComment}, UserId: {c.UserId}, Replies: {c.Replies.Count}, PhotoUrl: {c.PhotoUrl}");
                        }
                    }
                    System.Diagnostics.Debug.WriteLine($"Fetched {comments.Length} comments, total: {Comments.Count}");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Failed to fetch comments: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Error fetching comments: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
                System.Diagnostics.Debug.WriteLine("FetchCommentsAsync completed, IsBusy set to false");
            }
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
                    System.Diagnostics.Debug.WriteLine($"Unsupported image format: {contentType}");
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
                    System.Diagnostics.Debug.WriteLine($"Added image: ID: {imageId}, Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}, Map: {_imageFileMap.Count}");
                });
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error selecting image: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"SelectPhotoAsync error: {ex}");
            }
            finally
            {
                IsBusy = false;
                System.Diagnostics.Debug.WriteLine("SelectPhotoAsync completed, IsBusy set to false");
            }
        }

        [RelayCommand]
        private async Task RemovePhoto(string imageId)
        {
            if (string.IsNullOrEmpty(imageId) || IsBusy)
            {
                System.Diagnostics.Debug.WriteLine($"RemovePhoto: Invalid imageId or IsBusy. imageId: {imageId}, IsBusy: {IsBusy}");
                return;
            }

            IsBusy = true;
            try
            {
                System.Diagnostics.Debug.WriteLine($"RemovePhoto: Attempting to remove image with ID: {imageId}, Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}, Map: {_imageFileMap.Count}");

                var mapEntry = _imageFileMap.FirstOrDefault(x => x.Id == imageId);
                if (mapEntry.ImageSource == null)
                {
                    System.Diagnostics.Debug.WriteLine($"RemovePhoto: No image found in _imageFileMap with ID: {imageId}");
                    await ToastAsync("Image not found.");
                    return;
                }

                var preview = SelectedImagePreviews.FirstOrDefault(p => p.Id == imageId);
                if (preview == null)
                {
                    System.Diagnostics.Debug.WriteLine($"RemovePhoto: No preview found with ID: {imageId}");
                    await ToastAsync("Image preview not found.");
                    return;
                }

                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    SelectedImagePreviews.Remove(preview);
                    _selectedFiles.Remove(mapEntry.FileResult);
                    _imageFileMap.Remove(mapEntry);

                    if (mapEntry.ImageSource is StreamImageSource streamImageSource && streamImageSource.Stream != null)
                    {
                        try
                        {
                            var stream = streamImageSource.Stream(CancellationToken.None);
                            stream?.Dispose();
                            System.Diagnostics.Debug.WriteLine($"RemovePhoto: Disposed ImageSource stream for ID: {imageId}");
                        }
                        catch (Exception disposeEx)
                        {
                            System.Diagnostics.Debug.WriteLine($"RemovePhoto: Error disposing ImageSource for ID: {imageId}, Error: {disposeEx.Message}");
                        }
                    }

                    HasSelectedImages = SelectedImagePreviews.Count > 0;
                    IsPhotoButtonVisible = !HasSelectedImages;
                    OnPropertyChanged(nameof(SelectedImagePreviews));
                    OnPropertyChanged(nameof(HasSelectedImages));
                    OnPropertyChanged(nameof(IsPhotoButtonVisible));
                    System.Diagnostics.Debug.WriteLine($"RemovePhoto: Successfully removed image with ID: {imageId}. Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}, Map: {_imageFileMap.Count}");
                });

                await ToastAsync("Image removed successfully.");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"RemovePhoto: Error removing image with ID: {imageId}. Error: {ex.Message}, StackTrace: {ex.StackTrace}");
                await ToastAsync($"Error removing image: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
                System.Diagnostics.Debug.WriteLine($"RemovePhoto: Completed for ID: {imageId}, IsBusy: {IsBusy}");
            }
        }

        private async Task ClearPhotos()
        {
            try
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    foreach (var mapEntry in _imageFileMap.ToList()) // Create a copy to avoid collection modification issues
                    {
                        if (mapEntry.ImageSource is StreamImageSource streamImageSource)
                        {
                            try
                            {
                                var streamTask = streamImageSource.Stream?.Invoke(CancellationToken.None);
                                if (streamTask != null)
                                {
                                    var stream = streamTask.GetAwaiter().GetResult();
                                    stream?.Dispose();
                                }
                            }
                            catch (Exception disposeEx)
                            {
                                System.Diagnostics.Debug.WriteLine($"ClearPhotos: Error disposing ImageSource for ID {mapEntry.Id}: {disposeEx.Message}");
                            }
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
                    System.Diagnostics.Debug.WriteLine("Cleared all photos");
                });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ClearPhotos error: {ex.Message}");
                await ToastAsync($"Error clearing photos: {ex.Message}");
            }
        }

        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0)
            {
                await ToastAsync("Please enter a comment or select an image.");
                return;
            }
            if (IsBusy) return;

            IsBusy = true;
            try
            {
                await _realtimeUpdatesService.EnsureConnectedAsync();

                if (IsEditing && _commentBeingEdited != null && Post != null)
                {
                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Editing comment {_commentBeingEdited.CommentId}, Level: {_commentBeingEdited.Level}, ParentCommentId: {_commentBeingEdited.ParentCommentId}, UserId: {_commentBeingEdited.UserId}, IsOwnComment: {_commentBeingEdited.IsOwnComment}, PhotoUrl: {_commentBeingEdited.PhotoUrl}");

                    if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0)
                    {
                        await ToastAsync("Please enter content or select an image.");
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: No content or image for comment {_commentBeingEdited.CommentId}");
                        return;
                    }

                    if (_commentBeingEdited.CommentId == Guid.Empty)
                    {
                        await ToastAsync("Invalid comment selected for editing.");
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Invalid CommentId for comment {_commentBeingEdited.CommentId}");
                        return;
                    }

                    if (_authService.User == null || _commentBeingEdited.UserId != _authService.User.Id)
                    {
                        await ToastAsync("You can only edit your own comments.");
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: User not authorized to edit comment {_commentBeingEdited.CommentId}");
                        return;
                    }

                    var dto = new UpdateCommentDto
                    {
                        CommentId = _commentBeingEdited.CommentId,
                        Content = Comment ?? "",
                        IsExistingPhotoRemoved = _selectedFiles.Count == 0 && !string.IsNullOrEmpty(_commentBeingEdited.PhotoUrl),
                        Photo = null // Client sends image as StreamPart, not IFormFile
                    };
                    var serialized = JsonSerializer.Serialize(dto);

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
                    if (_selectedFiles.Count > 0)
                    {
                        var f = _selectedFiles.FirstOrDefault();
                        if (f == null)
                        {
                            await ToastAsync("Selected image is invalid.");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Selected file is null for comment {_commentBeingEdited.CommentId}");
                            return;
                        }
                        try
                        {
                            var fileName = f.FileName ?? $"{Guid.NewGuid()}.jpg";
                            var srcStream = await f.OpenReadAsync();
                            memoryStream = new MemoryStream();
                            await srcStream.CopyToAsync(memoryStream);
                            srcStream.Close();
                            memoryStream.Position = 0;
                            imgPart = new StreamPart(memoryStream, fileName, f.ContentType ?? "image/jpeg");
                        }
                        catch (Exception ex)
                        {
                            memoryStream?.Dispose();
                            await ToastAsync($"Error preparing image for update: {ex.Message}");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Error preparing image for comment {_commentBeingEdited.CommentId}: {ex.Message}, StackTrace: {ex.StackTrace}");
                            return;
                        }
                    }

                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Calling UpdateCommentWithImagesAsync for comment {_commentBeingEdited.CommentId}, IsExistingPhotoRemoved: {dto.IsExistingPhotoRemoved}, HasImage: {imgPart != null}");
                        var result = await PostsApi.UpdateCommentWithImagesAsync(
                            _commentBeingEdited.CommentId,
                            imgPart,
                            serialized
                        );
                        if (!result.IsSuccess)
                        {
                            await ShowErrorAlertAsync(result.Error);
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: API error for comment {_commentBeingEdited.CommentId}: {result.Error}");
                            return;
                        }

                        if (result.Data == null)
                        {
                            await ToastAsync("Failed to update comment: No data returned.");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: result.Data is null for comment {_commentBeingEdited.CommentId}");
                            return;
                        }

                        var updatedComment = new CommentDto
                        {
                            CommentId = _commentBeingEdited.CommentId,
                            PostId = Post.PostId,
                            Content = Comment ?? "",
                            PhotoUrl = imgPart != null ? result.Data.PhotoUrl : (dto.IsExistingPhotoRemoved ? null : _commentBeingEdited.PhotoUrl),
                            UserId = _commentBeingEdited.UserId,
                            UserName = _authService.User?.Name ?? result.Data.UserName ?? _commentBeingEdited.UserName ?? "Unknown",
                            UserPhotoUrl = result.Data.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? _commentBeingEdited.UserPhotoUrl ?? "default_avatar.png",
                            AddedOn = result.Data.AddedOn != default ? result.Data.AddedOn : _commentBeingEdited.AddedOn,
                            IsOwnComment = _authService.User != null && _commentBeingEdited.UserId == _authService.User.Id,
                            Level = _commentBeingEdited.Level,
                            ParentCommentId = _commentBeingEdited.ParentCommentId,
                            Replies = _commentBeingEdited.Replies ?? new ObservableCollection<CommentDto>()
                        };

                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Created updatedComment {updatedComment.CommentId}, PhotoUrl: {updatedComment.PhotoUrl}, UserName: {updatedComment.UserName}, UserPhotoUrl: {updatedComment.UserPhotoUrl}, Level: {updatedComment.Level}, ParentCommentId: {updatedComment.ParentCommentId}");

                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            if (_commentBeingEdited.Level == 0) // Top-level comment
                            {
                                var existingComment = Comments.FirstOrDefault(c => c.CommentId == _commentBeingEdited.CommentId);
                                if (existingComment != null)
                                {
                                    int index = Comments.IndexOf(existingComment);
                                    if (index >= 0)
                                    {
                                        Comments[index] = updatedComment;
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Updated top-level comment {updatedComment.CommentId}, UserPhotoUrl: {updatedComment.UserPhotoUrl}, IsOwnComment: {updatedComment.IsOwnComment}, UserId: {updatedComment.UserId}, PhotoUrl: {updatedComment.PhotoUrl}, Replies count: {updatedComment.Replies.Count}");
                                        OnPropertyChanged(nameof(Comments));
                                    }
                                    else
                                    {
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Existing comment {_commentBeingEdited.CommentId} index not found in Comments");
                                    }
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Top-level comment {_commentBeingEdited.CommentId} not found in Comments");
                                }
                            }
                            else // Reply (Level 1)
                            {
                                if (_commentBeingEdited.ParentCommentId == null || _commentBeingEdited.ParentCommentId == Guid.Empty)
                                {
                                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Reply {_commentBeingEdited.CommentId} has null or invalid ParentCommentId: {_commentBeingEdited.ParentCommentId}");
                                    return;
                                }

                                var parentComment = Comments.FirstOrDefault(c => c.CommentId == _commentBeingEdited.ParentCommentId);
                                if (parentComment != null)
                                {
                                    if (parentComment.Replies == null)
                                    {
                                        parentComment.Replies = new ObservableCollection<CommentDto>();
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Initialized Replies for parent comment {parentComment.CommentId}");
                                    }

                                    int parentIndex = Comments.IndexOf(parentComment);
                                    if (parentIndex < 0)
                                    {
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Parent comment {_commentBeingEdited.ParentCommentId} index not found in Comments");
                                        return;
                                    }

                                    var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == _commentBeingEdited.CommentId);
                                    if (existingReply != null)
                                    {
                                        int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                        if (replyIndex >= 0)
                                        {
                                            parentComment.Replies[replyIndex] = updatedComment;
                                            // Replace the parent comment to force UI refresh
                                            Comments[parentIndex] = parentComment;
                                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Updated reply {updatedComment.CommentId}, ParentCommentId: {parentComment.CommentId}, UserPhotoUrl: {updatedComment.UserPhotoUrl}, IsOwnComment: {updatedComment.IsOwnComment}, UserId: {updatedComment.UserId}, PhotoUrl: {updatedComment.PhotoUrl}, Parent replies count: {parentComment.Replies.Count}");
                                            OnPropertyChanged(nameof(Comments));
                                        }
                                        else
                                        {
                                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Reply {_commentBeingEdited.CommentId} index not found in parent {parentComment.CommentId}");
                                        }
                                    }
                                    else
                                    {
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Reply {_commentBeingEdited.CommentId} not found in parent {parentComment.CommentId}. Adding as new reply.");
                                        parentComment.Replies.Add(updatedComment);
                                        Comments[parentIndex] = parentComment;
                                        OnPropertyChanged(nameof(Comments));
                                    }
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Parent comment {_commentBeingEdited.ParentCommentId} not found for reply {_commentBeingEdited.CommentId}");
                                }
                            }
                        });
                    }
                    catch (Exception ex)
                    {
                        await ToastAsync($"Error updating comment: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Error updating comment {_commentBeingEdited.CommentId}: {ex.Message}, StackTrace: {ex.StackTrace}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    Comment = string.Empty;
                    IsEditing = false;
                    _commentBeingEdited = null;
                    await ClearPhotos();
                    await ToastAsync("Comment updated");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Adding new comment/reply. Post: {(Post != null ? Post.PostId.ToString() : "null")}, ReplyingToComment: {(_replyingToComment != null ? _replyingToComment.CommentId.ToString() : "null")}, User: {_authService.User?.Id.ToString() ?? "null"}, Comment: {Comment}");
                    var isReply = _replyingToComment != null;
                    if (Post == null)
                    {
                        await ToastAsync("Post not loaded.");
                        System.Diagnostics.Debug.WriteLine("AddCommentAsync: Post is null");
                        return;
                    }
                    if (isReply && (_replyingToComment == null || _replyingToComment.CommentId == Guid.Empty))
                    {
                        await ToastAsync("Invalid reply: No parent comment specified.");
                        System.Diagnostics.Debug.WriteLine("AddCommentAsync: ReplyingToComment is null or invalid");
                        return;
                    }
                    if (_authService.User == null)
                    {
                        await ToastAsync("User not authenticated.");
                        System.Diagnostics.Debug.WriteLine("AddCommentAsync: _authService.User is null");
                        return;
                    }

                    var dto = new SaveCommentDto
                    {
                        PostId = Post.PostId,
                        Content = Comment ?? "",
                        ParentCommentId = isReply ? _replyingToComment!.CommentId : null
                    };
                    var serialized = JsonSerializer.Serialize(dto);
                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: SaveCommentDto serialized: {serialized}");

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
                    if (_selectedFiles.Count > 0)
                    {
                        var f = _selectedFiles.FirstOrDefault();
                        if (f == null)
                        {
                            await ToastAsync("Selected image is invalid.");
                            System.Diagnostics.Debug.WriteLine("AddCommentAsync: Selected file is null");
                            return;
                        }
                        try
                        {
                            var fileName = f.FileName ?? $"{Guid.NewGuid()}.jpg";
                            var srcStream = await f.OpenReadAsync();
                            memoryStream = new MemoryStream();
                            await srcStream.CopyToAsync(memoryStream);
                            srcStream.Close();
                            memoryStream.Position = 0;
                            imgPart = new StreamPart(memoryStream, fileName, f.ContentType ?? "image/jpeg");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Prepared image for upload: {fileName}, ContentType: {f.ContentType}");
                        }
                        catch (Exception ex)
                        {
                            memoryStream?.Dispose();
                            await ToastAsync($"Error preparing image: {ex.Message}");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Error preparing image: {ex.Message}");
                            return;
                        }
                    }

                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Calling SaveCommentWithImagesAsync for PostId: {Post.PostId}, ParentCommentId: {(isReply ? _replyingToComment!.CommentId.ToString() : "null")}");
                        var result = await PostsApi.SaveCommentWithImagesAsync(Post.PostId, imgPart, serialized);

                        if (!result.IsSuccess)
                        {
                            await ToastAsync($"Failed to add {(isReply ? "reply" : "comment")}: {result.Error}");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: API error saving {(isReply ? "reply" : "comment")}: {result.Error}");
                            return;
                        }
                        if (result.Data == null)
                        {
                            await ToastAsync($"Failed to add {(isReply ? "reply" : "comment")}: No data returned.");
                            System.Diagnostics.Debug.WriteLine($"AddCommentAsync: result.Data is null for new {(isReply ? "reply" : "comment")}");
                            return;
                        }

                        result.Data.IsOwnComment = _authService.User != null && result.Data.UserId == _authService.User.Id;
                        result.Data.Level = isReply ? 1 : 0;
                        result.Data.UserPhotoUrl = result.Data.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                        result.Data.Replies = new ObservableCollection<CommentDto>(result.Data.Replies ?? Enumerable.Empty<CommentDto>());
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Successfully added {(isReply ? "reply" : "comment")} {result.Data.CommentId}, UserPhotoUrl: {result.Data.UserPhotoUrl}, Level: {result.Data.Level}, IsOwnComment: {result.Data.IsOwnComment}, PhotoUrl: {result.Data.PhotoUrl}");

                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            if (isReply)
                            {
                                var parentComment = Comments.FirstOrDefault(c => c.CommentId == _replyingToComment!.CommentId);
                                if (parentComment != null)
                                {
                                    int parentIndex = Comments.IndexOf(parentComment);
                                    if (parentComment.Replies == null)
                                    {
                                        parentComment.Replies = new ObservableCollection<CommentDto>();
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Initialized Replies for parent comment {parentComment.CommentId}");
                                    }
                                    if (!parentComment.Replies.Any(r => r.CommentId == result.Data.CommentId))
                                    {
                                        parentComment.Replies.Insert(0, result.Data);
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Added reply {result.Data.CommentId} to parent {parentComment.CommentId}, Total replies: {parentComment.Replies.Count}");
                                        OnPropertyChanged(nameof(Comments));
                                    }
                                    else
                                    {
                                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Reply {result.Data.CommentId} already exists in parent {parentComment.CommentId}, skipping UI update");
                                    }
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Parent comment {_replyingToComment!.CommentId} not found in Comments");
                                }
                            }
                            else
                            {
                                if (!Comments.Any(c => c.CommentId == result.Data.CommentId))
                                {
                                    Comments.Insert(0, result.Data);
                                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Added top-level comment {result.Data.CommentId}, Total comments: {Comments.Count}");
                                    OnPropertyChanged(nameof(Comments));
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Comment {result.Data.CommentId} already exists, skipping UI update");
                                }
                            }
                        });
                    }
                    catch (Exception ex)
                    {
                        await ToastAsync($"Error saving {(isReply ? "reply" : "comment")}: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"AddCommentAsync: Error saving {(isReply ? "reply" : "comment")}: {ex.Message}, StackTrace: {ex.StackTrace}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    Comment = string.Empty;
                    _replyingToComment = null;
                    await ClearPhotos();
                    await ToastAsync(isReply ? "Reply added" : "Comment added");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error with {(_replyingToComment != null ? "reply" : "comment")}: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"AddCommentAsync: General error: {ex.Message}, StackTrace: {ex.StackTrace}");
            }
            finally
            {
                IsBusy = false;
                System.Diagnostics.Debug.WriteLine("AddCommentAsync completed, IsBusy set to false");
            }
        }

        [RelayCommand]
        private void ReplyComment(CommentDto commentDto)
        {
            if (IsBusy || commentDto == null) return;
            _replyingToComment = commentDto;
            Comment = $"@{commentDto.UserName} ";
            System.Diagnostics.Debug.WriteLine($"ReplyComment: Initiated reply to comment {commentDto.CommentId}, UserName: {commentDto.UserName}");
        }

        [RelayCommand]
        private async Task CancelReply()
        {
            if (IsBusy) return;
            _replyingToComment = null;
            Comment = string.Empty;
            await ClearPhotos();
            System.Diagnostics.Debug.WriteLine("CancelReply: Reply cancelled");
        }

        [RelayCommand]
        public async Task EditAndUpdateCommentAsync(CommentDto? commentDto)
        {
            if (IsBusy) return;
            IsBusy = true;

            try
            {
                if (commentDto != null)
                {
                    System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: Starting edit for comment {commentDto.CommentId}, Level: {commentDto.Level}, UserId: {commentDto.UserId}, IsOwnComment: {commentDto.IsOwnComment}, PhotoUrl: {commentDto.PhotoUrl}");

                    if (_authService.User == null || commentDto.UserId != _authService.User.Id)
                    {
                        await Application.Current.MainPage.DisplayAlert("Error", "You can only edit your own comments.", "OK");
                        System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: User not authorized to edit comment {commentDto.CommentId}");
                        return;
                    }

                    if (commentDto.CommentId == Guid.Empty)
                    {
                        await ToastAsync("Invalid comment selected for editing.");
                        System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: Invalid CommentId for comment {commentDto.CommentId}");
                        return;
                    }

                    Comment = commentDto.Content ?? "";
                    IsEditing = true;
                    _commentBeingEdited = commentDto;
                    _replyingToComment = null;

                    await ClearPhotos();

                    if (!string.IsNullOrEmpty(commentDto.PhotoUrl))
                    {
                        try
                        {
                            var httpClient = new HttpClient();
                            var imageBytes = await httpClient.GetByteArrayAsync(commentDto.PhotoUrl);
                            var fileName = $"{Guid.NewGuid()}.jpg";
                            var tempPath = Path.Combine(FileSystem.CacheDirectory, fileName);
                            if (!Directory.Exists(FileSystem.CacheDirectory))
                            {
                                Directory.CreateDirectory(FileSystem.CacheDirectory);
                            }
                            await File.WriteAllBytesAsync(tempPath, imageBytes);

                            var fileResult = new FileResult(tempPath, "image/jpeg")
                            {
                                FileName = fileName
                            };
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
                                System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: Loaded existing image for comment {commentDto.CommentId}, ImageId: {imageId}, Level: {commentDto.Level}, UserId: {commentDto.UserId}, PhotoUrl: {commentDto.PhotoUrl}");
                            });

                            await ToastAsync("Editing comment with existing image.");
                        }
                        catch (Exception ex)
                        {
                            await ToastAsync($"Error loading existing image: {ex.Message}");
                            System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: Error loading image for comment {commentDto.CommentId}: {ex.Message}, StackTrace: {ex.StackTrace}");
                            await ClearPhotos();
                            return;
                        }
                    }
                    else
                    {
                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            HasSelectedImages = false;
                            IsPhotoButtonVisible = true;
                            OnPropertyChanged(nameof(HasSelectedImages));
                            OnPropertyChanged(nameof(IsPhotoButtonVisible));
                            System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: No existing image for comment {commentDto.CommentId}, HasSelectedImages: {HasSelectedImages}, IsPhotoButtonVisible: {IsPhotoButtonVisible}");
                        });
                    }

                    await ToastAsync($"You are now editing a {(commentDto.Level == 1 ? "reply" : "comment")}");
                    System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: Editing initiated for comment {commentDto.CommentId}, Level: {commentDto.Level}, UserId: {commentDto.UserId}, IsOwnComment: {commentDto.IsOwnComment}");
                }
                else
                {
                    await ToastAsync("No comment selected for update.");
                    System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: No comment selected. IsEditing: {IsEditing}, CommentBeingEdited: {(_commentBeingEdited != null ? _commentBeingEdited.CommentId : "null")}, Post: {(Post != null ? Post.PostId : "null")}");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync: General error: {ex.Message}, StackTrace: {ex.StackTrace}");
            }
            finally
            {
                IsBusy = false;
                System.Diagnostics.Debug.WriteLine("EditAndUpdateCommentAsync completed, IsBusy set to false");
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
            System.Diagnostics.Debug.WriteLine("CancelEdit: Edit cancelled");
        }

        [RelayCommand]
        public async Task DeleteCommentAsync(CommentDto commentDto)
        {
            if (commentDto == null || IsBusy) return;
            IsBusy = true;
            try
            {
                if (_authService.User == null || commentDto.UserId != _authService.User.Id)
                {
                    await Application.Current.MainPage.DisplayAlert("Error", "You can only delete your own comments.", "OK");
                    System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: User not authorized to delete comment {commentDto.CommentId}");
                    return;
                }
                bool confirm = await Shell.Current.DisplayAlert("Confirm Delete", $"Are you sure you want to delete this {(commentDto.Level == 1 ? "reply" : "comment")}?", "Yes", "No");
                if (!confirm) return;

                var result = await PostsApi.DeleteCommentAsync(commentDto.CommentId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: API error deleting comment {commentDto.CommentId}: {result.Error}");
                    return;
                }

                if (IsEditing && _commentBeingEdited?.CommentId == commentDto.CommentId)
                {
                    IsEditing = false;
                    _commentBeingEdited = null;
                    Comment = string.Empty;
                    await ClearPhotos();
                }
                if (_replyingToComment?.CommentId == commentDto.CommentId)
                {
                    _replyingToComment = null;
                    Comment = string.Empty;
                    await ClearPhotos();
                }

                if (commentDto.Level == 1) // Reply
                {
                    var parentComment = Comments.FirstOrDefault(c => c.Replies.Any(r => r.CommentId == commentDto.CommentId));
                    if (parentComment != null)
                    {
                        int parentIndex = Comments.IndexOf(parentComment);
                        var reply = parentComment.Replies.FirstOrDefault(r => r.CommentId == commentDto.CommentId);
                        if (reply != null)
                        {
                            parentComment.Replies.Remove(reply);
                            // Replace the parent comment to force UI refresh
                            Comments[parentIndex] = parentComment;
                            System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: Deleted reply {commentDto.CommentId}, ParentCommentId: {parentComment.CommentId}, Remaining replies: {parentComment.Replies.Count}");
                            OnPropertyChanged(nameof(Comments));
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: Reply {commentDto.CommentId} not found in parent {parentComment.CommentId}");
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: Parent comment not found for reply {commentDto.CommentId}");
                    }
                }
                else // Top-level comment
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == commentDto.CommentId);
                    if (existing != null)
                    {
                        Comments.Remove(existing);
                        System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: Deleted comment {commentDto.CommentId}, Total comments: {Comments.Count}");
                        OnPropertyChanged(nameof(Comments));
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: Comment {commentDto.CommentId} not found in Comments");
                    }
                }

                await ToastAsync($"{(commentDto.Level == 1 ? "Reply" : "Comment")} deleted");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"DeleteCommentAsync: Error deleting comment {commentDto.CommentId}: {ex.Message}, StackTrace: {ex.StackTrace}");
            }
            finally
            {
                IsBusy = false;
                System.Diagnostics.Debug.WriteLine("DeleteCommentAsync completed, IsBusy set to false");
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
                        System.Diagnostics.Debug.WriteLine($"DeletePostAsync: API error deleting post {Post.PostId}: {result.Error}");
                        return;
                    }
                    await Shell.Current.GoToAsync("..");
                }
                catch (Exception ex)
                {
                    await ShowErrorAlertAsync($"Error deleting post: {ex.Message}");
                    System.Diagnostics.Debug.WriteLine($"DeletePostAsync: Error deleting post: {ex.Message}, StackTrace: {ex.StackTrace}");
                }
                finally
                {
                    IsBusy = false;
                    System.Diagnostics.Debug.WriteLine("DeletePostAsync completed, IsBusy set to false");
                }
            }
        }

        private void OnPostChanged(PostDto changedPost)
        {
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
                        UserPhotoUrl = changedPost.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png",
                        LikeCount = changedPost.LikeCount,
                        CommentCount = changedPost.CommentCount,
                    };
                    System.Diagnostics.Debug.WriteLine($"OnPostChanged: Post updated: {Post.PostId}, UserPhotoUrl: {Post.UserPhotoUrl}");
                }
            });
        }

        private void OnPostDeleted(Guid postId)
        {
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                if (Post?.PostId == postId)
                {
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
                System.Diagnostics.Debug.WriteLine($"OnUserPhotoChanged: User photo updated for UserId: {dto.UserId}, PhotoUrl: {dto.PhotoUrl}");
                OnPropertyChanged(nameof(Comments));
            });
        }

        private void OnCommentAdded(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post != null && comment.PostId == Post.PostId)
                {
                    if (Comments.Any(c => c.CommentId == comment.CommentId))
                    {
                        System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Comment {comment.CommentId} already exists, skipping UI update");
                        return;
                    }

                    comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                    comment.Level = comment.ParentCommentId == null ? 0 : 1;
                    comment.UserPhotoUrl = comment.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                    // Ensure Replies is an ObservableCollection
                    comment.Replies = new ObservableCollection<CommentDto>(comment.Replies ?? Enumerable.Empty<CommentDto>());
                    System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Received CommentAdded: CommentId: {comment.CommentId}, UserPhotoUrl: {comment.UserPhotoUrl}, Level: {comment.Level}, ParentCommentId: {comment.ParentCommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, PhotoUrl: {comment.PhotoUrl}");

                    if (comment.Level == 0) // Top-level comment
                    {
                        Comments.Insert(0, comment);
                        System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Added comment {comment.CommentId}, Total comments: {Comments.Count}");
                        OnPropertyChanged(nameof(Comments));
                    }
                    else if (comment.Level == 1) // Reply
                    {
                        var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                        if (parentComment != null)
                        {
                            int parentIndex = Comments.IndexOf(parentComment);
                            if (parentComment.Replies == null)
                            {
                                parentComment.Replies = new ObservableCollection<CommentDto>();
                                System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Initialized Replies for parent comment {parentComment.CommentId}");
                            }
                            if (!parentComment.Replies.Any(r => r.CommentId == comment.CommentId))
                            {
                                parentComment.Replies.Insert(0, comment);
                                System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Added reply {comment.CommentId}, ParentCommentId: {parentComment.CommentId}, Parent replies count: {parentComment.Replies.Count}, IsOwnComment: {comment.IsOwnComment}, PhotoUrl: {comment.PhotoUrl}");
                                OnPropertyChanged(nameof(Comments));
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Reply {comment.CommentId} already exists in parent {parentComment.CommentId}, skipping UI update");
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"OnCommentAdded: Parent comment {comment.ParentCommentId} not found for reply {comment.CommentId}");
                        }
                    }
                }
            });
        }

        private void OnCommentUpdated(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post != null && comment.PostId == Post.PostId)
                {
                    comment.Level = comment.ParentCommentId == null ? 0 : 1;
                    comment.UserPhotoUrl = comment.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                    comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                    // Ensure Replies is an ObservableCollection
                    comment.Replies = new ObservableCollection<CommentDto>(comment.Replies ?? Enumerable.Empty<CommentDto>());
                    System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Received CommentUpdated: CommentId: {comment.CommentId}, ParentCommentId: {comment.ParentCommentId}, UserPhotoUrl: {comment.UserPhotoUrl}, Level: {comment.Level}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, PhotoUrl: {comment.PhotoUrl}");

                    if (comment.Level == 0) // Top-level comment
                    {
                        var existing = Comments.FirstOrDefault(c => c.CommentId == comment.CommentId);
                        if (existing != null)
                        {
                            int index = Comments.IndexOf(existing);
                            if (index >= 0)
                            {
                                // Preserve the existing Replies collection
                                comment.Replies = existing.Replies ?? new ObservableCollection<CommentDto>();
                                Comments[index] = comment;
                                System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Updated top-level comment {comment.CommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, PhotoUrl: {comment.PhotoUrl}, Replies count: {comment.Replies.Count}");
                                OnPropertyChanged(nameof(Comments));
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Existing comment {comment.CommentId} index not found in Comments");
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Top-level comment {comment.CommentId} not found in Comments");
                        }
                    }
                    else if (comment.Level == 1) // Reply
                    {
                        var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                        if (parentComment != null)
                        {
                            if (parentComment.Replies == null)
                            {
                                parentComment.Replies = new ObservableCollection<CommentDto>();
                                System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Initialized Replies for parent comment {parentComment.CommentId}");
                            }
                            var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == comment.CommentId);
                            if (existingReply != null)
                            {
                                int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                if (replyIndex >= 0)
                                {
                                    parentComment.Replies[replyIndex] = comment;
                                    System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Updated reply {comment.CommentId}, ParentCommentId: {parentComment.CommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, PhotoUrl: {comment.PhotoUrl}, Parent replies count: {parentComment.Replies.Count}");
                                    OnPropertyChanged(nameof(Comments));
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Reply {comment.CommentId} index not found in parent {parentComment.CommentId}");
                                }
                            }
                            else
                            {
                                parentComment.Replies.Insert(0, comment);
                                System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Added new reply {comment.CommentId} to parent {parentComment.CommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, PhotoUrl: {comment.PhotoUrl}, Parent replies count: {parentComment.Replies.Count}");
                                OnPropertyChanged(nameof(Comments));
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"OnCommentUpdated: Parent comment {comment.ParentCommentId} not found for reply {comment.CommentId}");
                        }
                    }
                }
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var parentComment = Comments.FirstOrDefault(c => c.Replies?.Any(r => r.CommentId == commentId) == true);
                if (parentComment != null)
                {
                    var reply = parentComment.Replies.FirstOrDefault(r => r.CommentId == commentId);
                    if (reply != null)
                    {
                        parentComment.Replies.Remove(reply);
                        System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Deleted reply {commentId}, ParentCommentId: {parentComment.CommentId}, Remaining replies: {parentComment.Replies.Count}");
                        OnPropertyChanged(nameof(Comments));
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Reply {commentId} not found in parent {parentComment.CommentId}");
                    }
                }
                else
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == commentId);
                    if (existing != null)
                    {
                        Comments.Remove(existing);
                        System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Deleted comment {commentId}, Total comments: {Comments.Count}");
                        OnPropertyChanged(nameof(Comments));
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Comment {commentId} not found in Comments");
                    }
                }

                if (IsEditing && _commentBeingEdited?.CommentId == commentId)
                {
                    IsEditing = false;
                    _commentBeingEdited = null;
                    Comment = string.Empty;
                    ClearPhotos();
                    System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Cleared editing state for deleted comment {commentId}");
                }
                if (_replyingToComment?.CommentId == commentId)
                {
                    _replyingToComment = null;
                    Comment = string.Empty;
                    ClearPhotos();
                    System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Cleared replying state for deleted comment {commentId}");
                }
                System.Diagnostics.Debug.WriteLine($"OnCommentDeleted: Comment deleted: {commentId}");
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
                    System.Diagnostics.Debug.WriteLine($"OnPostCountsUpdated: Post counts updated: PostId: {dto.PostId}, LikeCount: {dto.LikeCount}, CommentCount: {dto.CommentCount}");
                }
            });
        }

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _realtimeUpdatesService.AddPostChangedHandler(nameof(DetailsViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(DetailsViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(DetailsViewModel), OnUserPhotoChanged);
            _realtimeUpdatesService.AddCommentAddedHandler(nameof(DetailsViewModel), OnCommentAdded);
            _realtimeUpdatesService.AddCommentUpdatedHandler(nameof(DetailsViewModel), OnCommentUpdated);
            _realtimeUpdatesService.AddCommentDeletedHandler(nameof(DetailsViewModel), OnCommentDeleted);
            _realtimeUpdatesService.AddPostCountsUpdatedHandler(nameof(DetailsViewModel), OnPostCountsUpdated);
            System.Diagnostics.Debug.WriteLine("ConfigureRealtimeUpdates: Realtime updates configured for DetailsViewModel");
        }

        public void Cleanup()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _isPageActive = false;
            System.Diagnostics.Debug.WriteLine("Cleanup: Realtime updates cleaned up for DetailsViewModel");
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