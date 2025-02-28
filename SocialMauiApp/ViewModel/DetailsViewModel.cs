using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
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
        private PostDto _post = new();
        [ObservableProperty]
        private bool _isOwnPost;
        public ObservableCollection<CommentDto> Comments { get; set; } = [];
        partial void OnPostChanged(PostDto value)
        {
            _isOwnPost = value.UserId == _authService.User?.Id;
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
