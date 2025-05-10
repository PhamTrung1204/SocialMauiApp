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

        public ObservableCollection<CommentDto> Comments { get; }

        public ObservableCollection<ImagePreview> SelectedImagePreviews { get; } = new();

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
                        c.IsOwnComment = _authService.User != null && c.UserId == _authService.User.Id;
                        c.Level = c.ParentCommentId == null ? 0 : 1;
                        c.UserPhotoUrl = c.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                        foreach (var reply in c.Replies)
                        {
                            reply.IsOwnComment = _authService.User != null && reply.UserId == _authService.User.Id;
                            reply.Level = 1;
                            reply.UserPhotoUrl = reply.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                            System.Diagnostics.Debug.WriteLine($"Fetched reply {reply.CommentId}, UserPhotoUrl: {reply.UserPhotoUrl}, Level: {reply.Level}, IsOwnComment: {reply.IsOwnComment}, UserId: {reply.UserId}");
                        }
                        if (!Comments.Any(x => x.CommentId == c.CommentId))
                        {
                            Comments.Add(c);
                            System.Diagnostics.Debug.WriteLine($"Fetched comment {c.CommentId}, UserPhotoUrl: {c.UserPhotoUrl}, Level: {c.Level}, IsOwnComment: {c.IsOwnComment}, UserId: {c.UserId}, Replies: {c.Replies.Count}");
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
            }
        }

        [ObservableProperty]
        private string? comment;

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
                    // Remove the specific image
                    SelectedImagePreviews.Remove(preview);
                    _selectedFiles.Remove(mapEntry.FileResult);
                    _imageFileMap.Remove(mapEntry);

                    // Dispose of the ImageSource if it's a StreamImageSource
                    if (mapEntry.ImageSource is StreamImageSource streamImageSource && streamImageSource.Stream != null)
                    {
                        try
                        {
                            streamImageSource.Stream(CancellationToken.None)?.Dispose();
                        }
                        catch (Exception disposeEx)
                        {
                            System.Diagnostics.Debug.WriteLine($"RemovePhoto: Error disposing ImageSource: {disposeEx.Message}");
                        }
                    }

                    // If no images remain, clear collections and update UI
                    if (SelectedImagePreviews.Count == 0)
                    {
                        ClearPhotos();
                    }
                    else
                    {
                        // Update UI properties for remaining images
                        HasSelectedImages = SelectedImagePreviews.Count > 0;
                        IsPhotoButtonVisible = !HasSelectedImages;
                        OnPropertyChanged(nameof(SelectedImagePreviews));
                        OnPropertyChanged(nameof(HasSelectedImages));
                        OnPropertyChanged(nameof(IsPhotoButtonVisible));
                    }

                    System.Diagnostics.Debug.WriteLine($"RemovePhoto: Successfully removed image with ID: {imageId}. Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}, Map: {_imageFileMap.Count}");
                });

                await ToastAsync("Image removed successfully.");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"RemovePhoto: Error removing image with ID: {imageId}. Error: {ex.Message}");
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
                throw; // Re-throw to let RemovePhoto handle the error
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

                if (IsEditing && CommentBeingEdited != null)
                {
                    var dto = new UpdateCommentDto
                    {
                        CommentId = CommentBeingEdited.CommentId,
                        Content = Comment ?? ""
                    };
                    var serialized = JsonSerializer.Serialize(dto);

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
                    if (_selectedFiles.Count > 0)
                    {
                        var f = _selectedFiles.First();
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
                            await ToastAsync($"Error preparing image: {ex.Message}");
                            return;
                        }
                    }

                    try
                    {
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

                        var existingComment = Comments.FirstOrDefault(c => c.CommentId == CommentBeingEdited.CommentId);
                        if (existingComment != null)
                        {
                            int index = Comments.IndexOf(existingComment);
                            if (index >= 0)
                            {
                                var updatedComment = new CommentDto
                                {
                                    CommentId = CommentBeingEdited.CommentId,
                                    PostId = Post!.PostId,
                                    Content = Comment ?? "",
                                    PhotoUrl = result.Data?.PhotoUrl ?? existingComment.PhotoUrl,
                                    UserId = CommentBeingEdited.UserId,
                                    UserName = _authService.User?.Name ?? existingComment.UserName,
                                    UserPhotoUrl = result.Data?.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png",
                                    AddedOn = existingComment.AddedOn,
                                    IsOwnComment = _authService.User != null && CommentBeingEdited.UserId == _authService.User.Id,
                                    Level = existingComment.Level,
                                    ParentCommentId = existingComment.ParentCommentId,
                                    Replies = existingComment.Replies
                                };
                                System.Diagnostics.Debug.WriteLine($"Updating comment {updatedComment.CommentId}, UserPhotoUrl: {updatedComment.UserPhotoUrl}, Level: {updatedComment.Level}, IsOwnComment: {updatedComment.IsOwnComment}, UserId: {updatedComment.UserId}");
                                Comments[index] = updatedComment;
                                OnPropertyChanged(nameof(Comments));
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        await ToastAsync($"Error updating comment: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"Error updating comment: {ex.Message}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    IsEditing = false;
                    CommentBeingEdited = null;
                    Comment = string.Empty;
                    await ClearPhotos();
                    await ToastAsync("Comment updated");
                }
                else
                {
                    var isReply = ReplyingToComment != null;
                    var dto = new SaveCommentDto
                    {
                        PostId = Post!.PostId,
                        Content = Comment ?? "",
                        ParentCommentId = isReply ? ReplyingToComment!.CommentId : null
                    };
                    var serialized = JsonSerializer.Serialize(dto);

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
                    if (_selectedFiles.Count > 0)
                    {
                        var f = _selectedFiles.First();
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
                            await ToastAsync($"Error preparing image: {ex.Message}");
                            return;
                        }
                    }

                    try
                    {
                        ApiResult<CommentDto> result;
                        if (isReply)
                        {
                            result = await PostsApi.ReplyCommentWithImagesAsync(
                                Post.PostId,
                                imgPart,
                                serialized
                            );
                        }
                        else
                        {
                            result = await PostsApi.SaveCommentWithImagesAsync(
                                Post.PostId,
                                imgPart,
                                serialized
                            );
                        }
                        if (!result.IsSuccess)
                        {
                            await ShowErrorAlertAsync(result.Error);
                            return;
                        }
                        System.Diagnostics.Debug.WriteLine($"Added comment/reply {result.Data.CommentId}, UserPhotoUrl: {result.Data.UserPhotoUrl}, Level: {result.Data.Level}, IsOwnComment: {result.Data.IsOwnComment}");
                    }
                    catch (Exception ex)
                    {
                        await ToastAsync($"Error saving comment/reply: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"Error saving comment/reply: {ex.Message}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    Comment = string.Empty;
                    ReplyingToComment = null;
                    await ClearPhotos();
                    await ToastAsync(isReply ? "Reply added" : "Comment added");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error with comment/reply: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Error with comment/reply: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private void ReplyComment(CommentDto commentDto)
        {
            if (IsBusy || commentDto == null) return;
            ReplyingToComment = commentDto;
            Comment = $"@{commentDto.UserName} ";
            System.Diagnostics.Debug.WriteLine($"Initiated reply to comment: {commentDto.CommentId}, UserName: {commentDto.UserName}");
        }

        [RelayCommand]
        private async Task CancelReply()
        {
            if (IsBusy) return;
            ReplyingToComment = null;
            Comment = string.Empty;
            await ClearPhotos();
            System.Diagnostics.Debug.WriteLine("Reply cancelled");
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
                    if (_authService.User == null || commentDto.UserId != _authService.User.Id)
                    {
                        await Application.Current.MainPage.DisplayAlert("Error", "You can only edit your own comments.", "OK");
                        return;
                    }
                    Comment = commentDto.Content;
                    IsEditing = true;
                    CommentBeingEdited = commentDto;
                    ReplyingToComment = null;

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
                                System.Diagnostics.Debug.WriteLine($"Loaded existing image for editing: CommentId: {commentDto.CommentId}, ImageId: {imageId}, Level: {commentDto.Level}, UserId: {commentDto.UserId}");
                            });

                            await ToastAsync("Editing comment with existing image.");
                        }
                        catch (Exception ex)
                        {
                            await ToastAsync($"Error loading existing image: {ex.Message}");
                            System.Diagnostics.Debug.WriteLine($"Error loading image for comment {commentDto.CommentId}: {ex.Message}");
                            await ClearPhotos();
                            return;
                        }
                    }

                    await ToastAsync($"You are now editing a {(commentDto.Level == 1 ? "reply" : "comment")}");
                    System.Diagnostics.Debug.WriteLine($"Editing initiated: CommentId: {commentDto.CommentId}, Level: {commentDto.Level}, UserId: {commentDto.UserId}, IsOwnComment: {commentDto.IsOwnComment}");
                }
                else if (CommentBeingEdited != null && Post != null)
                {
                    if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0)
                    {
                        await ToastAsync("Please enter content or select an image.");
                        return;
                    }

                    await _realtimeUpdatesService.EnsureConnectedAsync();

                    var dto = new UpdateCommentDto
                    {
                        CommentId = CommentBeingEdited.CommentId,
                        Content = Comment ?? ""
                    };
                    var serialized = JsonSerializer.Serialize(dto);

                    StreamPart? imgPart = null;
                    MemoryStream? memoryStream = null;
                    if (_selectedFiles.Count > 0)
                    {
                        var f = _selectedFiles.First();
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
                            System.Diagnostics.Debug.WriteLine($"Error preparing image for comment {CommentBeingEdited.CommentId}: {ex.Message}");
                            return;
                        }
                    }

                    try
                    {
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

                        if (CommentBeingEdited.ParentCommentId == null) // Comment cấp 1
                        {
                            var existingComment = Comments.FirstOrDefault(c => c.CommentId == CommentBeingEdited.CommentId);
                            if (existingComment != null)
                            {
                                int index = Comments.IndexOf(existingComment);
                                if (index >= 0)
                                {
                                    var updatedComment = new CommentDto
                                    {
                                        CommentId = CommentBeingEdited.CommentId,
                                        PostId = Post.PostId,
                                        Content = Comment ?? "",
                                        PhotoUrl = result.Data?.PhotoUrl ?? existingComment.PhotoUrl,
                                        UserId = CommentBeingEdited.UserId,
                                        UserName = _authService.User?.Name ?? existingComment.UserName,
                                        UserPhotoUrl = result.Data?.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png",
                                        AddedOn = existingComment.AddedOn,
                                        IsOwnComment = _authService.User != null && CommentBeingEdited.UserId == _authService.User.Id,
                                        Level = 0,
                                        ParentCommentId = null,
                                        Replies = existingComment.Replies
                                    };
                                    System.Diagnostics.Debug.WriteLine($"Updating comment {updatedComment.CommentId}, UserPhotoUrl: {updatedComment.UserPhotoUrl}, IsOwnComment: {updatedComment.IsOwnComment}, UserId: {updatedComment.UserId}, Replies count: {updatedComment.Replies.Count}");
                                    Comments[index] = updatedComment;
                                    OnPropertyChanged(nameof(Comments));
                                }
                            }
                        }
                        else // Reply (cấp 2)
                        {
                            var parentComment = Comments.FirstOrDefault(c => c.CommentId == CommentBeingEdited.ParentCommentId);
                            if (parentComment != null)
                            {
                                int parentIndex = Comments.IndexOf(parentComment);
                                var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == CommentBeingEdited.CommentId);
                                var updatedReply = new CommentDto
                                {
                                    CommentId = CommentBeingEdited.CommentId,
                                    PostId = Post.PostId,
                                    Content = Comment ?? "",
                                    PhotoUrl = result.Data?.PhotoUrl ?? (existingReply?.PhotoUrl ?? ""),
                                    UserId = CommentBeingEdited.UserId,
                                    UserName = _authService.User?.Name ?? (existingReply?.UserName ?? ""),
                                    UserPhotoUrl = result.Data?.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png",
                                    AddedOn = existingReply?.AddedOn ?? DateTime.UtcNow,
                                    IsOwnComment = _authService.User != null && CommentBeingEdited.UserId == _authService.User.Id,
                                    Level = 1,
                                    ParentCommentId = CommentBeingEdited.ParentCommentId,
                                    Replies = existingReply?.Replies ?? new List<CommentDto>()
                                };
                                if (existingReply != null)
                                {
                                    int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                    parentComment.Replies[replyIndex] = updatedReply;
                                    System.Diagnostics.Debug.WriteLine($"Updating existing reply {updatedReply.CommentId}, UserPhotoUrl: {updatedReply.UserPhotoUrl}, IsOwnComment: {updatedReply.IsOwnComment}, ParentCommentId: {updatedReply.ParentCommentId}, Parent replies count: {parentComment.Replies.Count}");
                                }
                                else
                                {
                                    parentComment.Replies.Add(updatedReply);
                                    System.Diagnostics.Debug.WriteLine($"Adding new reply {updatedReply.CommentId} to parent {parentComment.CommentId}, UserPhotoUrl: {updatedReply.UserPhotoUrl}, IsOwnComment: {updatedReply.IsOwnComment}, Parent replies count: {parentComment.Replies.Count}");
                                }
                                Comments[parentIndex] = parentComment;
                                OnPropertyChanged(nameof(Comments));
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        await ToastAsync($"Error updating comment: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"Error updating comment {CommentBeingEdited.CommentId}: {ex.Message}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    Comment = string.Empty;
                    IsEditing = false;
                    CommentBeingEdited = null;
                    await ClearPhotos();
                    await ToastAsync($"{(CommentBeingEdited.Level == 1 ? "Reply" : "Comment")} updated");
                }
                else
                {
                    await ToastAsync("No comment selected for update.");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Error editing comment: {ex.Message}");
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
            CommentBeingEdited = null;
            Comment = string.Empty;
            await ClearPhotos();
            System.Diagnostics.Debug.WriteLine("Edit cancelled");
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
                    return;
                }
                bool confirm = await Shell.Current.DisplayAlert("Confirm Delete", $"Are you sure you want to delete this {(commentDto.Level == 1 ? "reply" : "comment")}?", "Yes", "No");
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
                if (ReplyingToComment?.CommentId == commentDto.CommentId)
                {
                    ReplyingToComment = null;
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
                            Comments[parentIndex] = parentComment;
                            System.Diagnostics.Debug.WriteLine($"Deleted reply {commentDto.CommentId}, ParentCommentId: {parentComment.CommentId}, Remaining replies: {parentComment.Replies.Count}");
                        }
                    }
                }
                else // Comment cấp 1
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == commentDto.CommentId);
                    if (existing != null)
                    {
                        Comments.Remove(existing);
                        System.Diagnostics.Debug.WriteLine($"Deleted comment {commentDto.CommentId}, Total comments: {Comments.Count}");
                    }
                }

                await ToastAsync($"{(commentDto.Level == 1 ? "Reply" : "Comment")} deleted");
                OnPropertyChanged(nameof(Comments));
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Error deleting comment {commentDto.CommentId}: {ex.Message}");
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
                    System.Diagnostics.Debug.WriteLine($"Error deleting post: {ex.Message}");
                }
                finally
                {
                    IsBusy = false;
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
                    System.Diagnostics.Debug.WriteLine($"Post updated: {Post.PostId}, UserPhotoUrl: {Post.UserPhotoUrl}");
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
                    foreach (var r in c.Replies.Where(r => r.UserId == dto.UserId))
                    {
                        r.UserPhotoUrl = dto.PhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                    }
                }
                System.Diagnostics.Debug.WriteLine($"User photo updated for UserId: {dto.UserId}, PhotoUrl: {dto.PhotoUrl}");
                OnPropertyChanged(nameof(Comments));
            });
        }

        private void OnCommentAdded(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post != null && comment.PostId == Post.PostId && !Comments.Any(c => c.CommentId == comment.CommentId))
                {
                    comment.IsOwnComment = _authService.User != null && comment.UserId == _authService.User.Id;
                    comment.Level = comment.ParentCommentId == null ? 0 : 1;
                    comment.UserPhotoUrl = comment.UserPhotoUrl ?? _authService.User?.PhotoUrl ?? "default_avatar.png";
                    System.Diagnostics.Debug.WriteLine($"Received CommentAdded: CommentId: {comment.CommentId}, UserPhotoUrl: {comment.UserPhotoUrl}, Level: {comment.Level}, ParentCommentId: {comment.ParentCommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}");

                    if (comment.Level == 0) // Comment cấp 1
                    {
                        Comments.Insert(0, comment);
                        System.Diagnostics.Debug.WriteLine($"Added comment {comment.CommentId}, Total comments: {Comments.Count}");
                    }
                    else if (comment.Level == 1) // Reply
                    {
                        var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                        if (parentComment != null)
                        {
                            int parentIndex = Comments.IndexOf(parentComment);
                            if (!parentComment.Replies.Any(r => r.CommentId == comment.CommentId))
                            {
                                comment.Replies = new List<CommentDto>(); // Initialize Replies
                                parentComment.Replies.Add(comment);
                                Comments[parentIndex] = parentComment;
                                System.Diagnostics.Debug.WriteLine($"Added reply {comment.CommentId}, ParentCommentId: {parentComment.CommentId}, Parent replies count: {parentComment.Replies.Count}, IsOwnComment: {comment.IsOwnComment}");
                            }
                        }
                    }
                    OnPropertyChanged(nameof(Comments));
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
                    System.Diagnostics.Debug.WriteLine($"Received CommentUpdated: CommentId: {comment.CommentId}, ParentCommentId: {comment.ParentCommentId}, UserPhotoUrl: {comment.UserPhotoUrl}, Level: {comment.Level}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}");

                    if (comment.Level == 0) // Comment cấp 1
                    {
                        var existing = Comments.FirstOrDefault(c => c.CommentId == comment.CommentId);
                        if (existing != null)
                        {
                            int index = Comments.IndexOf(existing);
                            if (index >= 0)
                            {
                                comment.Replies = existing.Replies;
                                Comments[index] = comment;
                                System.Diagnostics.Debug.WriteLine($"Updated comment {comment.CommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, Replies count: {comment.Replies.Count}");
                                OnPropertyChanged(nameof(Comments));
                            }
                        }
                    }
                    else if (comment.Level == 1) // Reply
                    {
                        var parentComment = Comments.FirstOrDefault(c => c.CommentId == comment.ParentCommentId);
                        if (parentComment != null)
                        {
                            int parentIndex = Comments.IndexOf(parentComment);
                            var existingReply = parentComment.Replies.FirstOrDefault(r => r.CommentId == comment.CommentId);
                            if (existingReply != null)
                            {
                                int replyIndex = parentComment.Replies.IndexOf(existingReply);
                                comment.Replies = existingReply.Replies ?? new List<CommentDto>();
                                parentComment.Replies[replyIndex] = comment;
                                System.Diagnostics.Debug.WriteLine($"Updated existing reply {comment.CommentId}, ParentCommentId: {parentComment.CommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, Parent replies count: {parentComment.Replies.Count}");
                            }
                            else
                            {
                                comment.Replies = new List<CommentDto>();
                                parentComment.Replies.Add(comment);
                                System.Diagnostics.Debug.WriteLine($"Added new reply {comment.CommentId} to parent {parentComment.CommentId}, IsOwnComment: {comment.IsOwnComment}, UserId: {comment.UserId}, Parent replies count: {parentComment.Replies.Count}");
                            }
                            Comments[parentIndex] = parentComment;
                            OnPropertyChanged(nameof(Comments));
                        }
                    }
                }
            });
        }

        private void OnCommentDeleted(Guid commentId)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                var parentComment = Comments.FirstOrDefault(c => c.Replies.Any(r => r.CommentId == commentId));
                if (parentComment != null)
                {
                    int parentIndex = Comments.IndexOf(parentComment);
                    var reply = parentComment.Replies.FirstOrDefault(r => r.CommentId == commentId);
                    if (reply != null)
                    {
                        parentComment.Replies.Remove(reply);
                        Comments[parentIndex] = parentComment;
                        System.Diagnostics.Debug.WriteLine($"Deleted reply {commentId}, ParentCommentId: {parentComment.CommentId}, Remaining replies: {parentComment.Replies.Count}");
                    }
                }
                else
                {
                    var existing = Comments.FirstOrDefault(c => c.CommentId == commentId);
                    if (existing != null)
                    {
                        Comments.Remove(existing);
                        System.Diagnostics.Debug.WriteLine($"Deleted comment {commentId}, Total comments: {Comments.Count}");
                    }
                }

                if (IsEditing && CommentBeingEdited?.CommentId == commentId)
                {
                    IsEditing = false;
                    CommentBeingEdited = null;
                    Comment = string.Empty;
                    ClearPhotos();
                }
                if (ReplyingToComment?.CommentId == commentId)
                {
                    ReplyingToComment = null;
                    Comment = string.Empty;
                    ClearPhotos();
                }
                System.Diagnostics.Debug.WriteLine($"Comment deleted: {commentId}");
                OnPropertyChanged(nameof(Comments));
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
                    System.Diagnostics.Debug.WriteLine($"Post counts updated: PostId: {dto.PostId}, LikeCount: {dto.LikeCount}, CommentCount: {dto.CommentCount}");
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
            System.Diagnostics.Debug.WriteLine("Realtime updates configured for DetailsViewModel");
        }

        public void Cleanup()
        {
            _realtimeUpdatesService.RemoveHandlers(nameof(DetailsViewModel));
            _isPageActive = false;
            System.Diagnostics.Debug.WriteLine("Realtime updates cleaned up for DetailsViewModel");
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