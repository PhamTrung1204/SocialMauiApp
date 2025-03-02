using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using DocumentFormat.OpenXml.Drawing.Diagrams;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(CroppedPhotoSource),"new-src")]
    public partial class ProfileViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly IUserApi _userApi;
        public ProfileViewModel(IPostApi postsApi, AuthService authService, IUserApi userApi) : base(postsApi)
        {
            User = authService.User!;
            _authService = authService;
            _userApi = userApi;
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
        private int _bookmarkedPostsStartIndex = 0;
        public ObservableCollection<PostModel> MyPosts { get; set; } = [];
        private int _myPostsStartIndex = 0;
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
                var posts = await _userApi.GetUserPostsAsync(_myPostsStartIndex, PageSize);
                if(posts.Length > 0)
                {
                    if(_myPostsStartIndex == 0 && MyPosts.Count > 0)
                    {
                        MyPosts.Clear();
                    }
                    _myPostsStartIndex += posts.Length;
                    foreach(var p in posts)
                    {
                        MyPosts.Add(PostModel.FromDto(p));
                    }
                }
            });
        }
        [RelayCommand]
        private async Task FetchBookmarkedPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var posts = await _userApi.GetUserBookmarkedPostsAsync(_bookmarkedPostsStartIndex, PageSize);
                if (posts.Length > 0)
                {
                    if(_bookmarkedPostsStartIndex == 0 && BookmarkedPosts.Count > 0)
                    {
                        BookmarkedPosts.Clear();
                    }
                    _bookmarkedPostsStartIndex += posts.Length;
                    foreach (var p in posts)
                    {
                        BookmarkedPosts.Add(PostModel.FromDto(p));
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
                var param = new Dictionary<string, object>
                {
                    [nameof(CropPhotoPage)] = selectedPhotoSource
                };
                await NavigateAsync(nameof(CropPhotoPage), param);
            }
        }
        [ObservableProperty]
        private string? _croppedPhotoSource;
       
        async partial void OnCroppedPhotoSourceChanged(string? oldValue, string? newValue)
        {
            if(!string.IsNullOrWhiteSpace(newValue))
            {
                await MakeApiCall(async () =>
                {
                    var photoName = Path.GetFileName(newValue);
                    using var fs = File.OpenRead(photoName);
                    var photoStreamPart = new StreamPart(fs, photoName);
                    var result = await _userApi.ChangePhotoAsync(photoStreamPart);
                    if(!result.IsSuccess)
                    {
                        await ShowErrorAlertAsync(result.Error);
                        return;
                    }
                    var newPhotoUrl = result.Data;
                    User = User with { PhotoUrl = newPhotoUrl };
                    _authService.Login(new LoginResponseDto(User, _authService.Token));
                    foreach (var post in MyPosts)
                    {
                        post.UserPhotoUrl = newPhotoUrl;
                    }
                });
            }
        }
    }
}
