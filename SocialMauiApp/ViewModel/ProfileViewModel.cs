using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using DocumentFormat.OpenXml.Drawing.Diagrams;
using Microsoft.Maui.Controls.PlatformConfiguration;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(CroppedPhotoSource), "new-src")]
    public partial class ProfileViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly IUserApi _userApi;
        private readonly RealtimeUpdatesService _realtimeUpdatesService;

        public ProfileViewModel(
            IPostApi postsApi,
            AuthService authService,
            IUserApi userApi,
            RealtimeUpdatesService realtimeUpdatesService)
            : base(postsApi, realtimeUpdatesService)
        {
            User = authService.User!;
            _authService = authService;
            _userApi = userApi;
            _realtimeUpdatesService = realtimeUpdatesService;

            // Đăng ký các handler realtime riêng của ProfileViewModel
            ConfigureRealtimeUpdates();
        }

        [ObservableProperty]
        private LoggedInUser _user;

        [RelayCommand]
        private async Task LogoutAsync()
        {
            if (await Shell.Current.DisplayAlert("Confirm Logout?", "Do you really want to logout?", "Yes", "No"))
            {
                _authService.Logout();
                await NavigateAsync($"//{nameof(LoginPage)}");
            }
        }

        [ObservableProperty, NotifyPropertyChangedFor(nameof(IsBookmarksTabSelected))]
        private bool _isMyPostsTabSelected = true;
        public bool IsBookmarksTabSelected => !IsMyPostsTabSelected;

        private int _myPostsStartIndex = 0;
        public ObservableCollection<PostModel> MyPosts { get; set; } = new ObservableCollection<PostModel>();
        private int _bookmarkedPostsStartIndex = 0;
        public ObservableCollection<PostModel> BookmarkedPosts { get; set; } = new ObservableCollection<PostModel>();
        private const int PageSize = 4;

        [RelayCommand]
        private async Task SelectMyPostsTabAsync()
        {
            IsMyPostsTabSelected = true;
            _myPostsStartIndex = 0;
            await FetchMyPostsAsync();
        }

        [RelayCommand]
        private async Task SelectBookmarkedPostsTabAsync()
        {
            IsMyPostsTabSelected = false;
            _bookmarkedPostsStartIndex = 0;
            await FetchBookmarkedPostsAsync();
        }

        [RelayCommand]
        private async Task FetchMyPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var posts = await _userApi.GetUserPostsAsync(token, _myPostsStartIndex, PageSize);

                if (posts.Length > 0)
                {
                    if (_myPostsStartIndex == 0)
                        MyPosts.Clear();
                    _myPostsStartIndex += posts.Length;
                    foreach (var p in posts.OrderByDescending(p=>p.PostedOn))
                    {
                        MyPosts.Add(PostModel.FromDto(p, PostsApi,_realtimeUpdatesService));
                    }
                }
            });
        }

        [RelayCommand]
        private async Task FetchBookmarkedPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;
                var posts = await _userApi.GetUserBookmarkedPostsAsync(token, _bookmarkedPostsStartIndex, PageSize);

                if (posts.Length > 0)
                {
                    // Nếu đang load trang đầu tiên, xoá danh sách cũ để tránh trùng
                    if (_bookmarkedPostsStartIndex == 0)
                        BookmarkedPosts.Clear();

                    _bookmarkedPostsStartIndex += posts.Length;
                    foreach (var p in posts.OrderByDescending(p => p.PostedOn))
                    {
                        // Tạo model từ DTO
                        var newPost = PostModel.FromDto(p, PostsApi, _realtimeUpdatesService);
                        // Kiểm tra nếu bài đăng chưa có trong danh sách thì mới thêm
                        if (!BookmarkedPosts.Any(existing => existing.PostId == newPost.PostId))
                        {
                            BookmarkedPosts.Add(newPost);
                        }
                    }
                }
            });
        }


        [RelayCommand]
        private async Task ChangePhotoAsync()
        {
            var selectedPhotoSource = await ChoosePhotoAsync();
            if (!string.IsNullOrWhiteSpace(selectedPhotoSource))
            {
                await NavigateAsync(nameof(CropPhotoPage), new Dictionary<string, object> { ["new-src"] = selectedPhotoSource });
            }
        }

        [ObservableProperty]
        private string? _croppedPhotoSource;

        async partial void OnCroppedPhotoSourceChanged(string? oldValue, string? newValue)
        {
            if (!string.IsNullOrWhiteSpace(newValue))
            {
                await MakeApiCall(async () =>
                {
                    using var fs = File.OpenRead(newValue);
                    var photoStreamPart = new StreamPart(fs, Path.GetFileName(newValue));
                    var token = "Bearer " + _authService.Token;
                    var result = await _userApi.ChangePhotoAsync(token, photoStreamPart);

                    if (!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }

                    User = User with { PhotoUrl = result.Data };
                    _authService.Login(new LoginResponseDto(User, _authService.Token));
                });
            }
        }

        /// <summary>
        /// Đăng ký các handler realtime cho ProfileViewModel.
        /// </summary>
        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddPostChangedHandler(nameof(ProfileViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(ProfileViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(ProfileViewModel), OnUserPhotoChanged);
        }

        private void OnPostChanged(PostDto post)
        {
            // Cập nhật bài viết trong danh sách MyPosts nếu có thay đổi nội dung hay ảnh
            var myPost = MyPosts.FirstOrDefault(p => p.PostId == post.PostId);
            if (myPost != null)
            {
                myPost.Content = post.Content;
                myPost.PhotoUrl = post.PhotoUrl;
                myPost.IsLiked = post.IsLiked;
                myPost.IsBookmarked = post.IsBookmarked;
            }
            // Ngoài ra, nếu bài viết trong danh sách BookmarkedPosts cũng có thay đổi thì cập nhật
            var bookmarkedPost = BookmarkedPosts.FirstOrDefault(p => p.PostId == post.PostId);
            if (bookmarkedPost != null)
            {
                bookmarkedPost.Content = post.Content;
                bookmarkedPost.PhotoUrl = post.PhotoUrl;
                bookmarkedPost.IsLiked = post.IsLiked;
                bookmarkedPost.IsBookmarked = post.IsBookmarked;
            }
        }

        private void OnPostDeleted(Guid postId)
        {
            // Xóa bài viết bị xóa khỏi cả MyPosts và BookmarkedPosts
            var postToRemove = MyPosts.FirstOrDefault(p => p.PostId == postId);
            if (postToRemove != null)
            {
                MyPosts.Remove(postToRemove);
            }
            postToRemove = BookmarkedPosts.FirstOrDefault(p => p.PostId == postId);
            if (postToRemove != null)
            {
                BookmarkedPosts.Remove(postToRemove);
            }
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
            // Cập nhật lại ảnh đại diện của người dùng cho các bài viết
            if (dto.UserId == User.Id)
            {
                foreach (var post in MyPosts)
                {
                    post.UserPhotoUrl = dto.PhotoUrl;
                }
            }
            foreach (var post in BookmarkedPosts.Where(p => p.UserId == dto.UserId))
            {
                post.UserPhotoUrl = dto.PhotoUrl;
            }
        }
    }
}
