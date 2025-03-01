using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
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
    [QueryProperty(nameof(Post), nameof(Post))]
    public partial class DetailsViewModel : BasePostViewModel
    {
        private readonly AuthService _authService;
        private readonly IPostApi PostApi;
        public DetailsViewModel(AuthService authService, IPostApi postApi):base(postApi)
        {
            _authService = authService;
            SkipGoToDetailsCommandAction = true;
        }
      
        [ObservableProperty]
        private PostModel _post = new();
        [ObservableProperty]
        private bool _isOwnPost;
        public ObservableCollection<CommentDto> Comments { get; set; } = [];
        async partial void OnPostChanged(PostModel value)
        {
            IsOwnPost = value.UserId == _authService.User?.Id;
            await FetchCommentsAsync();
        }
        private int _startIndex = 0;
        private const int PageSize = 10;
        private async Task FetchCommentsAsync()
        {
            await MakeApiCall(async () =>
            {
                var comments = await PostsApi.GetPostsCommentAsync(Post.PostId, _startIndex, PageSize);
                if(comments.Length > 0)
                {
                    _startIndex += comments.Length;
                    foreach(var c in comments)
                    {
                        Comments.Add(c);
                    }
                }
            });
        }
        [ObservableProperty] 
        private string? _comment;
        [RelayCommand]
        private async Task AddCommentAsync()
        {
            if(string.IsNullOrWhiteSpace(Comment))
            {
                await ToastAsync("Please enter comment");
                return;
            }
            await MakeApiCall(async () =>
            {
                var dto = new SaveCommentDto
                {
                    PostId = Post.PostId,
                    Content = Comment
                };
                var result = await PostApi.SaveCommentAsync(Post.PostId, dto);
                if(!result.IsSuccess)
                {
                    await ShowErrorAlertAsync(result.Error);
                    return;
                }
                var newComment = result.Data;
                Comments = [newComment, ..Comments];
                OnPropertyChanged(nameof(Comments));
            });
        }
    }
}
