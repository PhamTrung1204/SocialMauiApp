using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Pages;
using SocialMauiApp.Services;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Maui.ApplicationModel.DataTransfer;

namespace SocialMauiApp.ViewModel
{
    public partial class BasePostViewModel : BaseViewModel, IDisposable
    {
        private readonly RealtimeUpdatesService? _realtimeUpdatesService;

        // Constructor with both dependencies
        public BasePostViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            PostsApi = postApi;
            _realtimeUpdatesService = realtimeUpdatesService;
        }

        // Alternative constructor for scenarios where RealtimeUpdatesService isn't needed
        public BasePostViewModel(IPostApi postApi)
        {
            PostsApi = postApi;
            _realtimeUpdatesService = null;
        }

        public IPostApi PostsApi { get; }
        protected virtual bool SkipGoToDetailsCommandAction { get; set; }

        [RelayCommand]
        private async Task GoToDetailsPageAsync(PostModel post)
        {
            if (SkipGoToDetailsCommandAction) return;

            // Check if we're already on the details page
            var currentRoute = Shell.Current.CurrentState.Location.OriginalString;
            if (currentRoute.EndsWith(nameof(PostDetailsPage), StringComparison.OrdinalIgnoreCase))
            {
                return;
            }

            var param = new Dictionary<string, object>
            {
                [nameof(DetailsViewModel.Post)] = post
            };

            await Shell.Current.GoToAsync(nameof(PostDetailsPage), true, param);
        }

        // Toggle Like: update UI immediately and call API, then send realtime notification
        [RelayCommand]
        private async Task ToggleLikeAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                // Save original status for rollback if error
                var originalStatus = post.IsLiked;
                post.IsLiked = !post.IsLiked;

                // Call API to update like status
                var result = await PostsApi.ToggleLikeAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    post.IsLiked = originalStatus;
                    return;
                }

                // Notify icon update immediately
                post.NotifyIsLikeIconChanged();

                // Send realtime notification for other clients
                _realtimeUpdatesService?.NotifyPostChanged(post.PostId);
            });
        }

        protected virtual async void OnToggleBookmarkAsync(PostModel post)
        {
            // Can be overridden in child classes for additional processing after bookmark
            await Task.CompletedTask;
        }

        // Toggle Bookmark: update UI status immediately and call API
        [RelayCommand]
        private async Task ToggleBookmarkAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                var originalStatus = post.IsBookmarked;
                post.IsBookmarked = !post.IsBookmarked;

                var result = await PostsApi.ToggleBookmarkAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    post.IsBookmarked = originalStatus;
                    return;
                }

                OnToggleBookmarkAsync(post);
                post.NotifyIsBookmarkIconChanged();
                _realtimeUpdatesService?.NotifyPostChanged(post.PostId);
            });
        }

        [RelayCommand]
        private async Task SharePostAsync(PostModel post)
        {
            if (string.IsNullOrWhiteSpace(post.PhotoUrl))
            {
                await Share.Default.RequestAsync(new ShareTextRequest
                {
                    Title = "Maui Social",
                    Text = post.Content
                });
            }
            else
            {
                var tempPhotoPath = await DownloadPhotoAsync(post.PhotoUrl);
                if (!string.IsNullOrWhiteSpace(tempPhotoPath))
                {
                    var shareFile = new ShareFile(tempPhotoPath);
                    var shareFileRequest = new ShareFileRequest("Maui Social", shareFile);
                    await Share.Default.RequestAsync(shareFileRequest);
                }
            }
        }

        private Dictionary<string, string> _downloadedPhotos = new();
        private HttpClient? _httpClient;
        private async Task<string?> DownloadPhotoAsync(string photoUrl)
        {
            if (_downloadedPhotos.TryGetValue(photoUrl, out var localPhotoUrl))
            {
                return localPhotoUrl;
            }
            IsBusy = true;
            try
            {
                _httpClient ??= new HttpClient();
                var photoBytes = await _httpClient.GetByteArrayAsync(photoUrl);

                var localPath = Path.Combine(FileSystem.CacheDirectory, "share");
                if (!Directory.Exists(localPath))
                    Directory.CreateDirectory(localPath);
                var photoName = Path.GetFileName(photoUrl);
                var localPhotoPath = Path.Combine(localPath, photoName);
                File.WriteAllBytes(localPhotoPath, photoBytes);

                _downloadedPhotos[photoUrl] = localPhotoPath;
                return localPhotoPath;
            }
            catch (Exception ex)
            {
                await ShowErrorAlertAsync(ex.Message);
                return null;
            }
            finally
            {
                IsBusy = false;
            }
        }

        public void Dispose()
        {
            _httpClient?.Dispose();
            foreach (var (_, localPhotoPath) in _downloadedPhotos)
            {
                if (File.Exists(localPhotoPath))
                    File.Delete(localPhotoPath);
            }
        }
    }
}