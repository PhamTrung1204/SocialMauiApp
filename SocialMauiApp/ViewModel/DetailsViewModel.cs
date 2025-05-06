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
                OnPropertyChanged(nameof(HasSelectedImages));
                System.Diagnostics.Debug.WriteLine($"HasSelectedImages updated to: {HasSelectedImages}, Preview count: {SelectedImagePreviews.Count}");
            };
            IsPhotoButtonVisible = true;
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
                        c.IsOwnComment = c.UserId == _authService.User?.Id;
                        if (!Comments.Any(x => x.CommentId == c.CommentId))
                            Comments.Add(c);
                    }
                    System.Diagnostics.Debug.WriteLine($"Fetched {comments.Length} comments, total: {Comments.Count}");
                }
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Failed to fetch comments: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Error fetching comments: {ex.Message}");
            }
            finally { IsBusy = false; }
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
            try
            {
                System.Diagnostics.Debug.WriteLine($"Attempting to remove image with ID: {imageId}");
                var mapEntry = _imageFileMap.FirstOrDefault(x => x.Id == imageId);
                if (mapEntry.ImageSource != null)
                {
                    var preview = SelectedImagePreviews.FirstOrDefault(p => p.Id == imageId);
                    if (preview != null)
                    {
                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            SelectedImagePreviews.Remove(preview);
                            _selectedFiles.Remove(mapEntry.FileResult);
                            _imageFileMap.Remove(mapEntry);
                            HasSelectedImages = SelectedImagePreviews.Count > 0;
                            IsPhotoButtonVisible = true;
                            OnPropertyChanged(nameof(SelectedImagePreviews));
                            OnPropertyChanged(nameof(HasSelectedImages));
                            OnPropertyChanged(nameof(IsPhotoButtonVisible));
                            System.Diagnostics.Debug.WriteLine($"Removed image with ID: {imageId}. Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}, Map: {_imageFileMap.Count}");
                        });
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Preview with ID {imageId} not found in SelectedImagePreviews");
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"Image with ID {imageId} not found in image file map");
                }
            }
            catch (Exception ex)
            {
                await ToastAsync($"Error removing image: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"RemovePhoto error: {ex}");
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
                await ToastAsync($"Error clearing images: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"ClearPhotos error: {ex}");
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
                    System.Diagnostics.Debug.WriteLine($"Updating comment: {CommentBeingEdited.CommentId}");

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
                            System.Diagnostics.Debug.WriteLine($"Prepared image for update: {fileName}, Size: {memoryStream.Length}, Position: {memoryStream.Position}");
                        }
                        catch (Exception ex)
                        {
                            memoryStream?.Dispose();
                            System.Diagnostics.Debug.WriteLine($"Error preparing image stream for update: {ex}");
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
                            System.Diagnostics.Debug.WriteLine($"API update failed: {result.Error}");
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
                                    UserId = _authService.User?.Id ?? Guid.Empty,
                                    UserName = _authService.User?.Name,
                                    UserPhotoUrl = _authService.User?.PhotoUrl, // Always use current user avatar
                                    AddedOn = existingComment.AddedOn,
                                    IsOwnComment = true,
                                    Replies = existingComment.Replies
                                };
                                Comments[index] = updatedComment;
                                System.Diagnostics.Debug.WriteLine($"Updated comment in UI: {updatedComment.CommentId}, Content: {updatedComment.Content}, PhotoUrl: {updatedComment.PhotoUrl}, UserPhotoUrl: {updatedComment.UserPhotoUrl}");
                                OnPropertyChanged(nameof(Comments)); // Ensure UI refresh
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error updating comment via API: {ex}");
                        await ToastAsync($"Error updating comment: {ex.Message}");
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
                    var dto = new SaveCommentDto
                    {
                        PostId = Post!.PostId,
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
                            System.Diagnostics.Debug.WriteLine($"Prepared image for new comment: {fileName}, Size: {memoryStream.Length}, Position: {memoryStream.Position}");
                        }
                        catch (Exception ex)
                        {
                            memoryStream?.Dispose();
                            System.Diagnostics.Debug.WriteLine($"Error preparing image stream for new comment: {ex}");
                            await ToastAsync($"Error preparing image: {ex.Message}");
                            return;
                        }
                    }

                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"Sending API request to save comment for PostId: {Post.PostId}, Content: {Comment}, HasImage: {_selectedFiles.Count > 0}");
                        var result = await PostsApi.SaveCommentWithImagesAsync(
                            Post.PostId,
                            imgPart,
                            serialized
                        );
                        if (!result.IsSuccess)
                        {
                            await ShowErrorAlertAsync(result.Error);
                            System.Diagnostics.Debug.WriteLine($"API save failed: {result.Error}");
                            return;
                        }

                        // Ensure UserPhotoUrl is set, with fallback to default avatar
                        var userPhotoUrl = _authService.User?.PhotoUrl ?? "default_avatar.png";
                        System.Diagnostics.Debug.WriteLine($"Setting UserPhotoUrl for new comment: {userPhotoUrl}");

                        var newComment = new CommentDto
                        {
                            CommentId = result.Data!.CommentId,
                            PostId = Post.PostId,
                            Content = Comment ?? "",
                            PhotoUrl = result.Data?.PhotoUrl,
                            UserId = _authService.User?.Id ?? Guid.Empty,
                            UserName = _authService.User?.Name,
                            UserPhotoUrl = userPhotoUrl, // Always use current user avatar or default
                            AddedOn = DateTime.Now,
                            IsOwnComment = true,
                            Replies = new List<CommentDto>()
                        };

                        System.Diagnostics.Debug.WriteLine($"Created new comment: CommentId: {newComment.CommentId}, Content: {newComment.Content}, PhotoUrl: {newComment.PhotoUrl}, UserPhotoUrl: {newComment.UserPhotoUrl}");

                        // Add comment and refresh UI, mirroring EditAndUpdateCommentAsync
                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            var existingComment = Comments.FirstOrDefault(c => c.CommentId == newComment.CommentId);
                            if (existingComment != null)
                            {
                                int index = Comments.IndexOf(existingComment);
                                if (index >= 0)
                                {
                                    Comments[index] = newComment;
                                    System.Diagnostics.Debug.WriteLine($"Replaced existing comment in UI: {newComment.CommentId}, Content: {newComment.Content}, PhotoUrl: {newComment.PhotoUrl}, UserPhotoUrl: {newComment.UserPhotoUrl}");
                                }
                            }
                            else
                            {
                                Comments.Insert(0, newComment);
                                System.Diagnostics.Debug.WriteLine($"Added new comment to UI: {newComment.CommentId}, Content: {newComment.Content}, PhotoUrl: {newComment.PhotoUrl}, UserPhotoUrl: {newComment.UserPhotoUrl}");
                            }
                            OnPropertyChanged(nameof(Comments)); // Ensure UI refresh
                        });
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error saving comment via API: {ex}");
                        await ToastAsync($"Error saving comment: {ex.Message}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    Comment = string.Empty;
                    await ClearPhotos();
                    await ToastAsync("Comment added");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error processing comment: {ex}");
                await ShowErrorAlertAsync($"Error with comment: {ex.Message}");
            }
            finally
            {
                IsBusy = false;
            }
        }

        [RelayCommand]
        private async Task EditAndUpdateCommentAsync(CommentDto? commentDto)
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
                    System.Diagnostics.Debug.WriteLine($"Starting edit for comment: {commentDto.CommentId}, Content: {commentDto.Content}, PhotoUrl: {commentDto.PhotoUrl}");

                    Comment = commentDto.Content;
                    IsEditing = true;
                    CommentBeingEdited = commentDto;

                    await ClearPhotos();

                    if (!string.IsNullOrEmpty(commentDto.PhotoUrl))
                    {
                        try
                        {
                            System.Diagnostics.Debug.WriteLine($"Downloading existing image from PhotoUrl: {commentDto.PhotoUrl}");
                            var httpClient = new HttpClient();
                            var imageBytes = await httpClient.GetByteArrayAsync(commentDto.PhotoUrl);
                            if (imageBytes == null || imageBytes.Length == 0)
                            {
                                throw new Exception("Downloaded image data is empty or null");
                            }

                            var fileName = $"{Guid.NewGuid()}.jpg";
                            var tempPath = Path.Combine(FileSystem.CacheDirectory, fileName);
                            if (!Directory.Exists(FileSystem.CacheDirectory))
                            {
                                Directory.CreateDirectory(FileSystem.CacheDirectory);
                                System.Diagnostics.Debug.WriteLine($"Created directory: {FileSystem.CacheDirectory}");
                            }
                            await File.WriteAllBytesAsync(tempPath, imageBytes);
                            System.Diagnostics.Debug.WriteLine($"Saved image to temp path: {tempPath}, Size: {new FileInfo(tempPath).Length} bytes");

                            if (!File.Exists(tempPath) || new FileInfo(tempPath).Length == 0)
                            {
                                throw new IOException($"Failed to save or read temp file at: {tempPath}");
                            }

                            var fileResult = new FileResult(tempPath, "image/jpeg")
                            {
                                FileName = fileName
                            };
                            using (var testStream = await fileResult.OpenReadAsync())
                            {
                                System.Diagnostics.Debug.WriteLine($"Successfully opened temp file for reading: {tempPath}");
                            }

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
                                System.Diagnostics.Debug.WriteLine($"Added existing image to preview. ID: {imageId}, Previews: {SelectedImagePreviews.Count}, Files: {_selectedFiles.Count}, Map: {_imageFileMap.Count}");
                            });

                            await ToastAsync("Editing comment with existing image. Select a new image to replace it.");
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Error loading comment image: {ex}");
                            await ToastAsync($"Error loading existing image: {ex.Message}");
                            await ClearPhotos();
                            return;
                        }
                    }

                    await ToastAsync("You are now editing a comment");
                }
                else if (CommentBeingEdited != null && Post != null)
                {
                    if (string.IsNullOrWhiteSpace(Comment) && _selectedFiles.Count == 0)
                    {
                        await ToastAsync("Please enter content or select an image.");
                        return;
                    }

                    System.Diagnostics.Debug.WriteLine($"Updating comment: {CommentBeingEdited.CommentId}, Content: {Comment}, HasImage: {_selectedFiles.Count > 0}");

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
                            System.Diagnostics.Debug.WriteLine($"Prepared image for update: {fileName}, Size: {memoryStream.Length}, Position: {memoryStream.Position}");
                        }
                        catch (Exception ex)
                        {
                            memoryStream?.Dispose();
                            System.Diagnostics.Debug.WriteLine($"Error preparing image stream for update: {ex}");
                            await ToastAsync($"Error preparing image for update: {ex.Message}");
                            return;
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("No new image selected; keeping existing image (if any)");
                    }

                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"Calling API to update comment {CommentBeingEdited.CommentId}, HasImage: {imgPart != null}");
                        var result = await PostsApi.UpdateCommentWithImagesAsync(
                            CommentBeingEdited.CommentId,
                            imgPart,
                            serialized
                        );
                        if (!result.IsSuccess)
                        {
                            await ShowErrorAlertAsync(result.Error);
                            System.Diagnostics.Debug.WriteLine($"API update failed: {result.Error}");
                            return;
                        }

                        System.Diagnostics.Debug.WriteLine($"API update successful. Result Data: {JsonSerializer.Serialize(result.Data)}");

                        if (result.Data?.CommentId != CommentBeingEdited.CommentId)
                        {
                            System.Diagnostics.Debug.WriteLine($"API returned different CommentId: {result.Data?.CommentId}, expected: {CommentBeingEdited.CommentId}");
                            await ToastAsync("Comment update failed: Invalid response from server.");
                            return;
                        }

                        var existingComment = Comments.FirstOrDefault(c => c.CommentId == CommentBeingEdited.CommentId);
                        if (existingComment != null)
                        {
                            int index = Comments.IndexOf(existingComment);
                            System.Diagnostics.Debug.WriteLine($"Found existing comment at index: {index}");
                            if (index >= 0)
                            {
                                var updatedComment = new CommentDto
                                {
                                    CommentId = CommentBeingEdited.CommentId,
                                    PostId = Post.PostId,
                                    Content = Comment ?? "",
                                    PhotoUrl = result.Data?.PhotoUrl ?? existingComment.PhotoUrl,
                                    UserId = _authService.User?.Id ?? Guid.Empty,
                                    UserName = _authService.User?.Name,
                                    UserPhotoUrl = _authService.User?.PhotoUrl, // Always use current user avatar
                                    AddedOn = existingComment.AddedOn,
                                    IsOwnComment = true,
                                    Replies = existingComment.Replies
                                };
                                Comments[index] = updatedComment;
                                System.Diagnostics.Debug.WriteLine($"Updated comment in UI: {updatedComment.CommentId}, Content: {updatedComment.Content}, PhotoUrl: {updatedComment.PhotoUrl}, UserPhotoUrl: {updatedComment.UserPhotoUrl}");
                                OnPropertyChanged(nameof(Comments)); // Ensure UI refresh
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine($"Comment {CommentBeingEdited.CommentId} index not found in Comments collection");
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"Comment {CommentBeingEdited.CommentId} not found in Comments collection, skipping UI update");
                            await ToastAsync("Comment not found in local list, update may not reflect.");
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error updating comment via API: {ex}");
                        await ToastAsync($"Error updating comment: {ex.Message}");
                        return;
                    }
                    finally
                    {
                        memoryStream?.Dispose();
                    }

                    Comment = "";
                    IsEditing = false;
                    CommentBeingEdited = null;
                    await ClearPhotos();
                    await ToastAsync("Comment updated");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("No comment selected for update or Post is null");
                    await ToastAsync("No comment selected for update.");
                }
            }
            catch (HttpRequestException ex)
            {
                await ShowErrorAlertAsync($"Failed to update comment: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync HttpRequestException: {ex}");
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync($"Error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"EditAndUpdateCommentAsync error: {ex}");
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
            System.Diagnostics.Debug.WriteLine("Edit cancelled");
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
                System.Diagnostics.Debug.WriteLine($"Comment deleted: {commentDto.CommentId}");
                OnPropertyChanged(nameof(Comments));
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
            System.Diagnostics.Debug.WriteLine($"Received UserPhotoChanged event: UserId: {dto.UserId}, NewPhotoUrl: {dto.PhotoUrl}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post?.UserId == dto.UserId)
                {
                    Post.UserPhotoUrl = dto.PhotoUrl;
                    System.Diagnostics.Debug.WriteLine($"Updated post user photo to: {dto.PhotoUrl}");
                }

                int updatedComments = 0;
                foreach (var c in Comments.Where(x => x.UserId == dto.UserId))
                {
                    c.UserPhotoUrl = dto.PhotoUrl;
                    updatedComments++;
                    System.Diagnostics.Debug.WriteLine($"Updated comment {c.CommentId} UserPhotoUrl to: {c.UserPhotoUrl}");
                }

                if (updatedComments > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"Updated {updatedComments} comment photos");
                    OnPropertyChanged(nameof(Comments));
                }
            });
        }

        private void OnCommentAdded(CommentDto comment)
        {
            System.Diagnostics.Debug.WriteLine($"Received CommentAdded event: CommentId: {comment.CommentId}, PostId: {comment.PostId}, UserPhotoUrl: {comment.UserPhotoUrl}");
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (Post != null && comment.PostId == Post.PostId)
                {
                    if (!Comments.Any(c => c.CommentId == comment.CommentId))
                    {
                        comment.IsOwnComment = comment.UserId == _authService.User?.Id;
                        Comments.Insert(0, comment);
                        System.Diagnostics.Debug.WriteLine($"Added new comment to UI via realtime: {comment.CommentId}, Content: {comment.Content}, PhotoUrl: {comment.PhotoUrl}");
                        OnPropertyChanged(nameof(Comments));
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Comment {comment.CommentId} already exists in UI, skipping add via realtime");
                    }
                }
            });
        }

        private void OnCommentUpdated(CommentDto comment)
        {
            System.Diagnostics.Debug.WriteLine($"Received CommentUpdated event: CommentId: {comment.CommentId}, PostId: {comment.PostId}, Content: {comment.Content}");
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
                            Comments[index] = comment;
                            System.Diagnostics.Debug.WriteLine($"Updated comment in UI: {comment.CommentId}, Content: {comment.Content}, PhotoUrl: {comment.PhotoUrl}");
                            OnPropertyChanged(nameof(Comments));
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"Comment {comment.CommentId} index not found in Comments collection");
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Comment {comment.CommentId} not found in Comments, ignoring update");
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
                    OnPropertyChanged(nameof(Comments));
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