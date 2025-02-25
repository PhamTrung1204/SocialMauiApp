using CommunityToolkit.Mvvm.ComponentModel;
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
    public partial class DetailsViewModel : BaseViewModel
    {
        private readonly AuthService _authService;
        public DetailsViewModel(AuthService authService)
        {
            _authService = authService;
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
    }
}
