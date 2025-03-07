using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class HomeViewModel : BasePostViewModel
    {
        public HomeViewModel(IPostApi postApi):base(postApi) 
        {
            FetchPostsAsync();
        }
        public ObservableCollection<PostModel> Posts { get; set; } = [];
        private int _startIndex = 0;
        private const int PageSize = 7;
        [RelayCommand]
        private async Task FetchPostsAsync()
        {
            await MakeApiCall(async () =>
            {
                var posts = await PostsApi.GetPostsAsync(_startIndex, PageSize);
                if(posts.Length > 0)
                {
                    if(_startIndex == 0 && Posts.Count > 0)
                    {
                        Posts.Clear();
                    }
                    _startIndex += posts.Length;
                    foreach (var p in posts)
                    {
                        Posts.Add(PostModel.FromDto(p, PostsApi));
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
        
    }
}
