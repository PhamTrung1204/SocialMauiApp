using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
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

        [ObservableProperty]
        private bool _isCommentsExpanded;

        [ObservableProperty]
        private bool _isCommentsVisible;

        [ObservableProperty]
        private string _commentInput;

        private readonly HashSet<Guid> _processedCommentIds = new HashSet<Guid>();
        private bool _isInDetailsView;

        public PostModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
            : base(postApi, realtimeUpdatesService)
        {
            ConfigureRealtimeUpdates();
            Task.Run(() => LoadCommentsAsync(1)); // Load 1 comment initially
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

        public static PostModel FromDto(PostDto dto, IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService) =>
            new PostModel(postApi, realtimeUpdatesService)
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
                await _realtimeUpdatesService.EnsureConnectedAsync();
                var dto = new SaveCommentDto
                {
                    PostId = PostId,
                    Content = CommentInput,
                    ParentCommentId = null
                };
                var serialized = JsonSerializer.Serialize(dto);
                var result = await PostsApi.SaveCommentWithImagesAsync(PostId, null, serialized);
                if (result.IsSuccess && result.Data != null)
                {
                    if (!_processedCommentIds.Contains(result.Data.CommentId))
                    {
                        result.Data.Level = 0;
                        result.Data.UserPhotoUrl = result.Data.UserPhotoUrl ?? "default_avatar.png";
                        result.Data.Replies = new ObservableCollection<CommentDto>();
                        await MainThread.InvokeOnMainThreadAsync(() =>
                        {
                            if (!_isInDetailsView)
                            {
                                Comments.Insert(0, result.Data);
                                _processedCommentIds.Add(result.Data.CommentId);
                            }
                            CommentInput = string.Empty;
                            OnPropertyChanged(nameof(CommentInput));
                            CommentCount++;
                            OnPropertyChanged(nameof(CommentCount));
                        });
                        _realtimeUpdatesService?.NotifyCommentAddedAsync(result.Data); // Notify for DetailsViewModel
                        Console.WriteLine($"Added comment {result.Data.CommentId} at 02:37 PM +07, 28/05/2025.");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error adding comment: {ex.Message} at 02:37 PM +07, 28/05/2025.");
            }
            finally
            {
                IsBusy = false;
            }
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
                            comment.Replies = new ObservableCollection<CommentDto>(
                                comment.Replies?.Where(r => !_processedCommentIds.Contains(r.CommentId)) ?? Enumerable.Empty<CommentDto>());
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
                    OnPropertyChanged(nameof(Comments));
                    Console.WriteLine($"Loaded {Comments.Count} comments for post {PostId} at 02:37 PM +07, 28/05/2025.");
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error loading comments: {ex.Message} at 02:37 PM +07, 28/05/2025.");
            }
            finally
            {
                IsBusy = false;
            }
        }

        private void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService?.AddCommentAddedHandler($"PostModel_{PostId}", OnCommentAdded);
            _realtimeUpdatesService?.AddPostCountsUpdatedHandler($"PostModel_{PostId}", OnPostCountsUpdated);
        }

        private void OnCommentAdded(CommentDto comment)
        {
            MainThread.BeginInvokeOnMainThread(() =>
            {
                if (_isInDetailsView || _processedCommentIds.Contains(comment.CommentId)) return;
                comment.Level = comment.ParentCommentId == null ? 0 : 1;
                comment.UserPhotoUrl = comment.UserPhotoUrl ?? "default_avatar.png";
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
                Console.WriteLine($"Added comment {comment.CommentId} via SignalR at 02:37 PM +07, 28/05/2025.");
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
    }
}