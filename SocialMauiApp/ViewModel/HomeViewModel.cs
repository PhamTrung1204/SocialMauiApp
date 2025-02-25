using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class HomeViewModel : BaseViewModel
    {
        private readonly IPostApi _postApi;
        public HomeViewModel(IPostApi postApi)
        {
            _postApi = postApi;
            FetchPostsAsync();
        }
        public ObservableCollection<PostDto> Posts { get; set; } = [];
        private int _startIndex = 0;
        private const int PageSize = 7;
        [RelayCommand]
        private async Task FetchPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var posts = await _postApi.GetPostsAsync(_startIndex, PageSize);
                if(posts .Length > 0)
                {
                    if(_startIndex == 0 && Posts.Count > 0)
                    {
                        Posts.Clear();
                    }
                    _startIndex += posts.Length;
                    foreach (var p in posts)
                    {
                        Posts.Add(p);
                    }
                }
            });
        }
        [ObservableProperty]
        private bool _isRefreshing;
        [RelayCommand]
        private async Task RefreshPostsAsync()
        {
            _startIndex = 0;
            await FetchPostsAsync();
            IsRefreshing = false;
        }
        [RelayCommand]
        private async Task GoToAddPostAsync() => await NavigateAsync(nameof(AddPostPage));
        [RelayCommand]
        private async Task GoToDetailsPageAsync(PostDto post)
        {
            var param = new Dictionary<string, object>
            {
                [nameof(DetailsViewModel.Post)] = post
            };
            await NavigateAsync(nameof(PostDetailsPage), param);
        }
    }
}
