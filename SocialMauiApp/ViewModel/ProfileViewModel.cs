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
       
        public ProfileViewModel(IPostApi postsApi, AuthService authService, IUserApi userApi, RealtimeUpdatesService realtimeUpdatesService) : base(postsApi)
        {
            User = authService.User!;
            _authService = authService;
            _userApi = userApi;
            _realtimeUpdatesService = realtimeUpdatesService;
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
        public ObservableCollection<PostModel> MyPosts { get; set; } = [];
        private int _bookmarkedPostsStartIndex = 0;
        public ObservableCollection<PostModel> BookmarkedPosts { get; set; } = [];
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
                    if (_myPostsStartIndex == 0) MyPosts.Clear();
                    _myPostsStartIndex += posts.Length;
                    foreach (var p in posts)
                    {
                        MyPosts.Add(PostModel.FromDto(p, PostsApi));
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
                    if (_bookmarkedPostsStartIndex == 0) BookmarkedPosts.Clear();
                    _bookmarkedPostsStartIndex += posts.Length;
                    foreach (var p in posts)
                    {
                        BookmarkedPosts.Add(PostModel.FromDto(p, PostsApi));
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

        public void ConfigureRealtimeUpdates()
        {
            _realtimeUpdatesService.AddPostChangedHandler(nameof(ProfileViewModel), OnPostChanged);
            _realtimeUpdatesService.AddPostDeletedHandler(nameof(ProfileViewModel), OnPostDeleted);
            _realtimeUpdatesService.AddUserPhotoChangedHandler(nameof(ProfileViewModel), OnUserPhotoChanged);
        }

        private void OnPostChanged(PostDto post)
        {
            var myPost = MyPosts.FirstOrDefault(p => p.PostId == post.PostId);
            if (myPost != null)
            {
                myPost.Content = post.Content;
                myPost.PhotoUrl = post.PhotoUrl;
            }
        }

        private void OnPostDeleted(Guid postId)
        {
            MyPosts.Remove(MyPosts.FirstOrDefault(p => p.PostId == postId));
            BookmarkedPosts.Remove(BookmarkedPosts.FirstOrDefault(p => p.PostId == postId));
        }

        private void OnUserPhotoChanged(UserPhotoChangedDto dto)
        {
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