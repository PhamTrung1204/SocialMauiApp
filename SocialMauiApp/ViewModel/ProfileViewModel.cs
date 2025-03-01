using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.ViewModel
{
    public partial class ProfileViewModel : BasePostViewModel
    {
        public ProfileViewModel(IPostApi postsApi, AuthService authService) : base(postsApi)
        {
            User = authService.User!;
        }
        [ObservableProperty]
        private LoggedInUser _user;

        [RelayCommand]
        private async Task LogoutAsync()
        {

        }
        [ObservableProperty, NotifyPropertyChangedFor(nameof(IsBookmarksTabSelected))]
      
        private bool _isMyPostsTabSelected = true;
        public bool IsBookmarksTabSelected => !IsMyPostsTabSelected;
        [RelayCommand]
        private async Task SelectMyPostsTabAsync()
        {
            IsMyPostsTabSelected = true;
        }
        [RelayCommand]
        private async Task SelectBookmarkedPostsTabAsync()
        {
            IsMyPostsTabSelected = false;
        }
    }
}
