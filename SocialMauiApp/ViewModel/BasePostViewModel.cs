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
        public readonly RealtimeUpdatesService? _realtimeUpdatesService;
        private readonly Dictionary<string, string> _downloadedPhotos = new();
        private HttpClient? _httpClient;

        public IPostApi PostsApi { get; }

        protected virtual bool SkipGoToDetailsCommandAction { get; set; }

        public BasePostViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            PostsApi = postApi;
            _realtimeUpdatesService = realtimeUpdatesService;
        }

        public BasePostViewModel(IPostApi postApi)
        {
            PostsApi = postApi;
        }

        [RelayCommand]
        private async Task GoToDetailsPageAsync(PostModel post)
        {
            if (SkipGoToDetailsCommandAction) return;

            var currentRoute = Shell.Current.CurrentState.Location.OriginalString;
            if (currentRoute.EndsWith(nameof(PostDetailsPage), StringComparison.OrdinalIgnoreCase)) return;

            var param = new Dictionary<string, object>
            {
                [nameof(DetailsViewModel.Post)] = post
            };

            await Shell.Current.GoToAsync(nameof(PostDetailsPage), true, param);
        }

        [RelayCommand]
        private async Task ToggleLikeAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                var originalStatus = post.IsLiked;
                post.IsLiked = !originalStatus;

                var result = await PostsApi.ToggleLikeAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    post.IsLiked = originalStatus;
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }

                post.NotifyIsLikeIconChanged();
                await OnPostLikedAsync(post);
                _realtimeUpdatesService?.NotifyPostChanged(post.PostId);
            });
        }

        protected virtual Task OnPostLikedAsync(PostModel post) => Task.CompletedTask;

        [RelayCommand]
        private async Task ToggleBookmarkAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                var originalStatus = post.IsBookmarked;
                post.IsBookmarked = !originalStatus;

                var result = await PostsApi.ToggleBookmarkAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    post.IsBookmarked = originalStatus;
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }

                post.NotifyIsBookmarkIconChanged();
                await OnPostBookmarkedAsync(post);
                _realtimeUpdatesService?.NotifyPostChanged(post.PostId);
            });
        }

        protected virtual Task OnPostBookmarkedAsync(PostModel post) => Task.CompletedTask;

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

        private async Task<string?> DownloadPhotoAsync(string photoUrl)
        {
            if (_downloadedPhotos.TryGetValue(photoUrl, out var localPath) && File.Exists(localPath))
                return localPath;

            IsBusy = true;
            try
            {
                _httpClient ??= new HttpClient();
                var photoBytes = await _httpClient.GetByteArrayAsync(photoUrl);

                var cacheFolder = Path.Combine(FileSystem.CacheDirectory, "share");
                Directory.CreateDirectory(cacheFolder);
                var fileName = Path.GetFileName(photoUrl);
                var filePath = Path.Combine(cacheFolder, fileName);
                File.WriteAllBytes(filePath, photoBytes);

                _downloadedPhotos[photoUrl] = filePath;
                return filePath;
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
            foreach (var path in _downloadedPhotos.Values)
            {
                if (File.Exists(path))
                    File.Delete(path);
            }
        }
    }
}
