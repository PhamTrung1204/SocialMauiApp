using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Collections.ObjectModel;

namespace SocialMauiApp.ViewModel
{
    [QueryProperty(nameof(TargetUserId), "userId")]
    public partial class UserProfileViewModel : BasePostViewModel
    {
        private const int PageSize = 10;

        private readonly IUserApi _userApi;
        private readonly IFriendApi _friendApi;
        private readonly AuthService _authService;

        [ObservableProperty]
        private Guid _targetUserId;

        [ObservableProperty]
        private string _targetUserName = string.Empty;

        [ObservableProperty]
        private string? _targetUserPhotoUrl;

        [ObservableProperty]
        [NotifyPropertyChangedFor(nameof(CanManageFriendship))]
        [NotifyPropertyChangedFor(nameof(IsIncomingRequest))]
        private string _friendshipStatus = FriendshipStatuses.NotFriends;

        [ObservableProperty]
        private bool _isDataLoaded;

        [ObservableProperty]
        private bool _hasError;

        [ObservableProperty]
        private string _errorMessage = string.Empty;

        public bool CanManageFriendship => FriendshipStatus != FriendshipStatuses.Self;

        public bool IsIncomingRequest => FriendshipStatus == FriendshipStatuses.RequestReceived;

        public ObservableCollection<PostModel> UserPosts { get; } = new();

        public UserProfileViewModel(
            IPostApi postApi,
            RealtimeUpdatesService realtimeUpdatesService,
            IUserApi userApi,
            IFriendApi friendApi,
            AuthService authService)
            : base(postApi, realtimeUpdatesService)
        {
            _userApi = userApi;
            _friendApi = friendApi;
            _authService = authService;
        }

        partial void OnTargetUserIdChanged(Guid value)
        {
            if (value == Guid.Empty)
            {
                HasError = true;
                ErrorMessage = LocalizationService.Instance.Get("Error_InvalidUserId");
                return;
            }
            _ = LoadUserProfileAsync();
        }

        [RelayCommand]
        private async Task LoadUserProfileAsync()
        {
            if (string.IsNullOrEmpty(_authService.Token))
            {
                HasError = true;
                ErrorMessage = LocalizationService.Instance.Get("Error_SessionInvalid");
                return;
            }

            IsDataLoaded = false;
            HasError = false;
            ErrorMessage = string.Empty;

            await MakeApiCall(async () =>
            {
                var token = "Bearer " + _authService.Token;

                var userInfo = await _userApi.GetUserInfoAsync(token, TargetUserId);
                TargetUserName = userInfo?.Name ?? string.Empty;
                TargetUserPhotoUrl = userInfo?.PhotoUrl;

                var statusResult = await _friendApi.GetFriendshipStatusAsync(TargetUserId);
                FriendshipStatus = statusResult.IsSuccess && statusResult.Data is not null
                    ? statusResult.Data.Status
                    : FriendshipStatuses.NotFriends;

                var posts = await _userApi.GetPostsOfUserAsync(token, TargetUserId, 0, PageSize);
                UserPosts.Clear();
                foreach (var post in posts ?? Array.Empty<PostDto>())
                {
                    UserPosts.Add(PostModel.FromDto(post, PostsApi, _realtimeUpdatesService!, _authService));
                }

                IsDataLoaded = true;
            });
        }

        [RelayCommand]
        private async Task ManageFriendshipAsync()
        {
            await MakeApiCall(async () =>
            {
                ApiResult<FriendshipStatusDto> result;

                switch (FriendshipStatus)
                {
                    case FriendshipStatuses.NotFriends:
                        result = await _friendApi.SendFriendRequestAsync(TargetUserId);
                        if (result.IsSuccess) await ToastAsync(LocalizationService.Instance.Get("Friends_RequestSent"));
                        break;

                    case FriendshipStatuses.Pending:
                        result = await _friendApi.CancelFriendRequestAsync(TargetUserId);
                        if (result.IsSuccess) await ToastAsync(LocalizationService.Instance.Get("Friends_RequestCancelled"));
                        break;

                    case FriendshipStatuses.RequestReceived:
                        result = await _friendApi.AcceptFriendRequestAsync(TargetUserId);
                        if (result.IsSuccess) await ToastAsync(LocalizationService.Instance.Get("Friends_RequestAccepted"));
                        break;

                    case FriendshipStatuses.Friends:
                        if (!await Shell.Current.DisplayAlert(LocalizationService.Instance.Get("Common_Confirm"), LocalizationService.Instance.Get("Friends_ConfirmUnfriendPlain"), LocalizationService.Instance.Get("Common_Yes"), LocalizationService.Instance.Get("Common_No")))
                        {
                            return;
                        }
                        result = await _friendApi.RemoveFriendAsync(TargetUserId);
                        if (result.IsSuccess) await ToastAsync(LocalizationService.Instance.Get("Friends_Unfriended"));
                        break;

                    default:
                        return;
                }

                if (result.IsSuccess && result.Data is not null)
                {
                    FriendshipStatus = result.Data.Status;
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? LocalizationService.Instance.Get("Error_FriendshipUpdate"));
                }
            });
        }

        [RelayCommand]
        private async Task RejectRequestAsync()
        {
            await MakeApiCall(async () =>
            {
                var result = await _friendApi.RejectFriendRequestAsync(TargetUserId);
                if (result.IsSuccess && result.Data is not null)
                {
                    FriendshipStatus = result.Data.Status;
                    await ToastAsync(LocalizationService.Instance.Get("Friends_RequestDeclined"));
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? LocalizationService.Instance.Get("Error_DeclineRequest"));
                }
            });
        }
    }
}
