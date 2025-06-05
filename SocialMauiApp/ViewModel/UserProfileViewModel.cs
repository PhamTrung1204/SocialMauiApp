//using CommunityToolkit.Mvvm.ComponentModel;
//using CommunityToolkit.Mvvm.Input;
//using SocialMauiApp.Apis;
//using SocialMauiApp.Models;
//using SocialMauiApp.Services;
//using SocialMediaMaui.Shared.Dtos;
//using System;
//using System.Collections.ObjectModel;
//using System.Threading.Tasks;

//namespace SocialMauiApp.ViewModel
//{
//    [QueryProperty(nameof(TargetUserId), "userId")]
//    public partial class UserProfileViewModel : BasePostViewModel
//    {
//        private readonly IUserApi _userApi;
//        private readonly AuthService _authService;

//        [ObservableProperty]
//        private Guid _targetUserId;

//        [ObservableProperty]
//        private string _targetUserName;

//        [ObservableProperty]
//        private string _targetUserPhotoUrl;

//        [ObservableProperty]
//        private string _friendshipStatus;

//        [ObservableProperty]
//        private bool _isDataLoaded;

//        [ObservableProperty]
//        private bool _hasError;

//        [ObservableProperty]
//        private string _errorMessage;

//        public ObservableCollection<PostModel> UserPosts { get; } = new();

//        public UserProfileViewModel(IPostApi postApi, RealtimeUpdatesService realtimeUpdatesService, IUserApi userApi, AuthService authService)
//            : base(postApi, realtimeUpdatesService)
//        {
//            _userApi = userApi ?? throw new ArgumentNullException(nameof(userApi));
//            _authService = authService ?? throw new ArgumentNullException(nameof(authService));
//        }

//        partial void OnTargetUserIdChanged(Guid value)
//        {
//            if (value != Guid.Empty)
//            {
//                LoadUserProfileAsync();
//            }
//            else
//            {
//                HasError = true;
//                ErrorMessage = "ID người dùng không hợp lệ.";
//            }
//        }

//        private async void LoadUserProfileAsync()
//        {
//            IsBusy = true;
//            IsDataLoaded = false;
//            HasError = false;
//            ErrorMessage = string.Empty;

//            try
//            {
//                if (string.IsNullOrEmpty(_authService.Token))
//                {
//                    HasError = true;
//                    ErrorMessage = "Phiên đăng nhập không hợp lệ. Vui lòng đăng nhập lại.";
//                    return;
//                }

//                var token = "Bearer " + _authService.Token;

//                // Lấy thông tin người dùng
//                var userInfo = await _userApi.GetUserInfoAsync(token, TargetUserId);
//                if (userInfo == null)
//                {
//                    HasError = true;
//                    ErrorMessage = "Không thể tải thông tin người dùng.";
//                    return;
//                }
//                TargetUserName = userInfo.Name ?? "Không xác định";
//                TargetUserPhotoUrl = userInfo.PhotoUrl ?? string.Empty;

//                // Lấy trạng thái kết bạn
//                var statusResult = await _userApi.GetFriendshipStatusAsync(token, TargetUserId);
//                if (statusResult.IsSuccess && statusResult.Data != null)
//                {
//                    FriendshipStatus = statusResult.Data.Status ?? "NotFriends";
//                }
//                else
//                {
//                    FriendshipStatus = "NotFriends";
//                    HasError = true;
//                    ErrorMessage = statusResult.Error ?? "Không thể lấy trạng thái kết bạn.";
//                    return;
//                }

//                // Lấy bài viết
//                var posts = await _userApi.GetUserPostsAsync(token, TargetUserId, 0, 10);
//                UserPosts.Clear();
//                if (posts != null)
//                {
//                    foreach (var post in posts)
//                    {
//                        if (post != null)
//                        {
//                            UserPosts.Add(PostModel.FromDto(post, PostsApi, _realtimeUpdatesService, _authService));
//                        }
//                    }
//                }

//                IsDataLoaded = true;
//            }
//            catch (Exception ex)
//            {
//                HasError = true;
//                ErrorMessage = $"Lỗi khi tải hồ sơ: {ex.Message}";
//            }
//            finally
//            {
//                IsBusy = false;
//            }
//        }

//        [RelayCommand]
//        private async Task ManageFriendshipAsync()
//        {
//            if (string.IsNullOrEmpty(_authService.Token))
//            {
//                await ShowErrorAlertAsync("Phiên đăng nhập không hợp lệ. Vui lòng đăng nhập lại.");
//                return;
//            }

//            var token = "Bearer " + _authService.Token;
//            try
//            {
//                switch (FriendshipStatus)
//                {
//                    case "NotFriends":
//                        var sendResult = await _userApi.SendFriendRequestAsync(token, TargetUserId);
//                        if (sendResult.IsSuccess && sendResult.Data != null)
//                        {
//                            FriendshipStatus = sendResult.Data.Status ?? "Pending";
//                            await ToastAsync("Yêu cầu kết bạn đã được gửi.");
//                        }
//                        else
//                        {
//                            await ShowErrorAlertAsync(sendResult.Error ?? "Không thể gửi yêu cầu kết bạn.");
//                        }
//                        break;

//                    case "Pending":
//                        var cancelResult = await _userApi.CancelFriendRequestAsync(token, TargetUserId);
//                        if (cancelResult.IsSuccess && cancelResult.Data != null)
//                        {
//                            FriendshipStatus = cancelResult.Data.Status ?? "NotFriends";
//                            await ToastAsync("Đã hủy yêu cầu kết bạn.");
//                        }
//                        else
//                        {
//                            await ShowErrorAlertAsync(cancelResult.Error ?? "Không thể hủy yêu cầu kết bạn.");
//                        }
//                        break;

//                    case "Friends":
//                        var confirm = await Shell.Current.DisplayAlert("Xác nhận", "Bạn có chắc muốn hủy kết bạn?", "Có", "Không");
//                        if (confirm)
//                        {
//                            var unfriendResult = await _userApi.RemoveFriendAsync(token, TargetUserId);
//                            if (unfriendResult.IsSuccess && unfriendResult.Data != null)
//                            {
//                                FriendshipStatus = unfriendResult.Data.Status ?? "NotFriends";
//                                await ToastAsync("Đã hủy kết bạn thành công.");
//                            }
//                            else
//                            {
//                                await ShowErrorAlertAsync(unfriendResult.Error ?? "Không thể hủy kết bạn.");
//                            }
//                        }
//                        break;

//                    default:
//                        await ShowErrorAlertAsync("Trạng thái kết bạn không hợp lệ.");
//                        break;
//                }
//            }
//            catch (Exception ex)
//            {
//                await ShowErrorAlertAsync($"Lỗi khi quản lý kết bạn: {ex.Message}");
//            }
//        }

//        [RelayCommand]
//        private async Task RetryLoadAsync()
//        {
//            await Task.Run(LoadUserProfileAsync);
//        }
//    }
//}