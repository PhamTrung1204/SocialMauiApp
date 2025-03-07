using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;

namespace SocialMauiApp.ViewModel
{
    public partial class BasePostViewModel : BaseViewModel, IDisposable
    {
        public BasePostViewModel(IPostApi postApi)
        {
            PostsApi = postApi;
        }
        private bool IsInDetailPage = false;
        public IPostApi PostsApi { get; }
        protected virtual bool SkipGoToDetailsCommandAction { get; set; }

        [RelayCommand]
        private async Task GoToAddPostAsync() => await NavigateAsync(nameof(AddPostPage));

        [RelayCommand]
        private async Task GoToDetailsPageAsync(PostModel post)
        {
            var param = new Dictionary<string, object>
            {
                [nameof(DetailsViewModel.Post)] = post
            };
            await NavigateAsync(nameof(PostDetailsPage), param);
        }

        [RelayCommand]
        private async Task ToggleLikeAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                var orginalStatus = post.IsLiked;
                post.IsLiked = !post.IsLiked;

                var result = await PostsApi.ToggleLikeAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    post.IsLiked = orginalStatus;
                    return;
                }
            });
        }

        [RelayCommand]
        private async Task ToggleBookmarkAsync(PostModel post)
        {
            await MakeApiCall(async () =>
            {
                var orginalStatus = post.IsBookmarked;
                post.IsBookmarked = !post.IsBookmarked;

                var result = await PostsApi.ToggleBookmarkAsync(post.PostId);
                if (!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    post.IsBookmarked = orginalStatus;
                    return;
                }
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
