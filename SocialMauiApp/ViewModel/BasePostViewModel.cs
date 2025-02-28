using CommunityToolkit.Mvvm.Input;
using SocialMauiApp.Apis;
using SocialMediaMaui.Shared.Dtos;


namespace SocialMauiApp.ViewModel
{
    public partial class BasePostViewModel : BaseViewModel
    {
        public BasePostViewModel(IPostApi postApi)
        {
            PostsApi = postApi;
        }

        public IPostApi PostsApi { get; }
        protected virtual bool SkipGoToDetailsCommandAction { get; set; }
        //[RelayCommand]
        //private async Task GoToDetailsPageAsync(PostDto post)
        //{
        //    if (!SkipGoToDetailsCommandAction) return;
        //    var param = new Dictionary<string, object>
        //    {
        //        [nameof(DetailsViewModel.Post)] = post
        //    };
        //    await NavigateAsync(nameof(DetailsViewModel.Post), param);
        //}
        private async Task ToggleLikeAsync(PostDto post)
        {
            await MakeApiCall(async () =>
            {

            });
        }
    }
}