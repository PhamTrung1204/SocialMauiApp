using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMediaMaui.Shared.Dtos;
using System.Collections.ObjectModel;

namespace SocialMauiApp.ViewModel
{
    public partial class FriendsViewModel : BaseViewModel
    {
        private const int PageSize = 20;

        private readonly IFriendApi _friendApi;

        [ObservableProperty]
        [NotifyPropertyChangedFor(nameof(IsFriendsTab))]
        [NotifyPropertyChangedFor(nameof(IsRequestsTab))]
        [NotifyPropertyChangedFor(nameof(IsSuggestionsTab))]
        private int _selectedTab;

        [ObservableProperty]
        private bool _isRefreshing;

        [ObservableProperty]
        private string? _searchText;

        public bool IsFriendsTab => SelectedTab == 0;
        public bool IsRequestsTab => SelectedTab == 1;
        public bool IsSuggestionsTab => SelectedTab == 2;

        public ObservableCollection<FriendshipDto> Friends { get; } = new();
        public ObservableCollection<FriendshipDto> Requests { get; } = new();
        public ObservableCollection<UserDto> Suggestions { get; } = new();

        public FriendsViewModel(IFriendApi friendApi)
        {
            _friendApi = friendApi;
        }

        [RelayCommand]
        private async Task AppearingAsync() => await RefreshAsync();

        [RelayCommand]
        private async Task RefreshAsync()
        {
            IsRefreshing = true;
            try
            {
                await MakeApiCall(async () =>
                {
                    switch (SelectedTab)
                    {
                        case 0:
                            Replace(Friends, await _friendApi.GetFriendsAsync(0, PageSize));
                            break;
                        case 1:
                            Replace(Requests, await _friendApi.GetIncomingRequestsAsync(0, PageSize));
                            break;
                        default:
                            Replace(Suggestions, await _friendApi.GetSuggestionsAsync(SearchText, 0, PageSize));
                            break;
                    }
                });
            }
            finally
            {
                IsRefreshing = false;
            }
        }

        [RelayCommand]
        private async Task SelectTabAsync(string tabIndex)
        {
            if (int.TryParse(tabIndex, out var index) && index != SelectedTab)
            {
                SelectedTab = index;
                await RefreshAsync();
            }
        }

        [RelayCommand]
        private async Task SearchAsync() 
        {
            SelectedTab = 2;
            await RefreshAsync();
        }

        [RelayCommand]
        private async Task AcceptAsync(FriendshipDto request)
        {
            if (request is null) return;
            await MakeApiCall(async () =>
            {
                var result = await _friendApi.AcceptFriendRequestAsync(request.FriendId);
                if (result.IsSuccess)
                {
                    Requests.Remove(request);
                    await ToastAsync(LocalizationService.Instance.Format("Friends_NowFriendsWith", request.FriendName));
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? LocalizationService.Instance.Get("Error_AcceptRequest"));
                }
            });
        }

        [RelayCommand]
        private async Task RejectAsync(FriendshipDto request)
        {
            if (request is null) return;
            await MakeApiCall(async () =>
            {
                var result = await _friendApi.RejectFriendRequestAsync(request.FriendId);
                if (result.IsSuccess)
                {
                    Requests.Remove(request);
                    await ToastAsync(LocalizationService.Instance.Get("Friends_RequestDeclined"));
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? LocalizationService.Instance.Get("Error_DeclineRequest"));
                }
            });
        }

        [RelayCommand]
        private async Task AddFriendAsync(UserDto user)
        {
            if (user is null) return;
            await MakeApiCall(async () =>
            {
                var result = await _friendApi.SendFriendRequestAsync(user.Id);
                if (result.IsSuccess)
                {
                    Suggestions.Remove(user);
                    await ToastAsync(LocalizationService.Instance.Format("Friends_RequestSentTo", user.Name));
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? LocalizationService.Instance.Get("Error_SendRequest"));
                }
            });
        }

        [RelayCommand]
        private async Task RemoveFriendAsync(FriendshipDto friend)
        {
            if (friend is null) return;
            if (!await Shell.Current.DisplayAlert(LocalizationService.Instance.Get("Common_Confirm"), LocalizationService.Instance.Format("Friends_ConfirmUnfriend", friend.FriendName), LocalizationService.Instance.Get("Common_Yes"), LocalizationService.Instance.Get("Common_No")))
            {
                return;
            }
            await MakeApiCall(async () =>
            {
                var result = await _friendApi.RemoveFriendAsync(friend.FriendId);
                if (result.IsSuccess)
                {
                    Friends.Remove(friend);
                    await ToastAsync(LocalizationService.Instance.Get("Friends_Unfriended"));
                }
                else
                {
                    await ShowErrorAlertAsync(result.Error ?? LocalizationService.Instance.Get("Error_Unfriend"));
                }
            });
        }

        [RelayCommand]
        private async Task OpenProfileAsync(Guid userId)
        {
            if (userId == Guid.Empty) return;
            await NavigateAsync($"{nameof(UserProfilePage)}?userId={userId}");
        }

        private static void Replace<T>(ObservableCollection<T> target, IEnumerable<T>? items)
        {
            target.Clear();
            foreach (var item in items ?? Enumerable.Empty<T>())
            {
                target.Add(item);
            }
        }
    }
}
