using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
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
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        // Constructor yêu cầu cả IPostApi và RealtimeUpdatesService
        public BasePostViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService)
        {
            PostsApi = postApi;
            _realtimeUpdatesService = realtimeUpdatesService;
        }

        public IPostApi PostsApi { get; }
        protected virtual bool SkipGoToDetailsCommandAction { get; set; }

        [RelayCommand]
        private async Task GoToDetailsPageAsync(PostModel post)
        {
            var param = new Dictionary<string, object>
            {
                [nameof(DetailsViewModel.Post)] = post
            };
            await NavigateAsync(nameof(PostDetailsPage), param);
        }

        // Toggle Like: Cập nhật ngay thuộc tính và gọi API, nếu thành công thông báo realtime
        [RelayCommand]
        private async Task ToggleLikeAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                // Cập nhật trạng thái UI ngay lập tức
                var originalStatus = post.IsLiked;
                post.IsLiked = !post.IsLiked;

                var result = await PostsApi.ToggleLikeAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    post.IsLiked = originalStatus;
                    return;
                }

                // Sau khi API thành công, gửi thông báo realtime
                _realtimeUpdatesService.NotifyPostChanged(post.PostId);
            });
        }

        protected virtual async void OnToggleBookmarkAsync(PostModel post)
        {
            // Nếu cần xử lý bổ sung sau khi bookmark, override ở lớp con.
            await Task.CompletedTask;
        }

        // Toggle Bookmark: Cập nhật trạng thái UI ngay lập tức
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
                // Sau khi API thành công, gửi thông báo realtime
                _realtimeUpdatesService.NotifyPostChanged(post.PostId);
            });
        }

        // Phương thức SharePostAsync được giữ nguyên (nếu dùng)
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
