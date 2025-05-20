using CommunityToolkit.Maui;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Models;
using SocialMauiApp.Controls;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using SocialMediaMaui.Shared;
using Syncfusion.Maui.Core.Hosting;
using Syncfusion.Maui.Toolkit.Hosting;
using Microsoft.Maui.Handlers;
using SocialMauiApp.Data;



namespace SocialMauiApp
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .UseMauiCommunityToolkit()
                .ConfigureSyncfusionToolkit()
                .ConfigureMauiHandlers(handlers =>
                {
                })
                .ConfigureFonts(fonts =>
                {
                    //fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    //fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                    //fonts.AddFont("SegoeUI-Semibold.ttf", "SegoeSemibold");
                    fonts.AddFont("Ubuntu-Bold.tff", "UbuntuBold");
                    fonts.AddFont("Ubuntu-Regular.ttf", "UbuntuRegular");
                    fonts.AddFont("FluentSystemIcons-Regular.ttf", FluentUI.FontFamily);
                })
                .ConfigureSyncfusionCore();


            builder.Services.AddSingleton<AuthService>();
            builder.Services.AddSingleton<LocalDatabase>();

            builder.Services.AddTransient<LoginViewModel>().AddTransient<LoginPage>();
            builder.Services.AddSingleton<IPreferencesService, PreferencesService>();
            builder.Services.AddTransient<AdminViewModel>().AddTransient<AdminDashboardPage>();
            builder.Services.AddTransient<PostManageViewModel>().AddTransient<PostManagementPage>();
            builder.Services.AddTransient<RegisterViewModel>().AddTransient<RegisterPage>();
            builder.Services.AddTransient<SavePostViewModel>().AddTransient<AddPostPage>();
            builder.Services.AddSingleton<HomeViewModel>().AddSingleton<HomePage>() ;
            builder.Services.AddTransient<DetailsViewModel>().AddTransient<PostDetailsPage>();
            builder.Services.AddTransient<ProfileViewModel>().AddTransient<ProfilePage>();
            builder.Services.AddTransient<NotificationViewModel>().AddTransient<NotificationPage>();
            builder.Services.AddTransient<RealtimeUpdatesService>();
            ConfigureRefit(builder.Services);
#if ANDROID
            // Đăng ký handler riêng cho NoUnderLine
            builder.ConfigureMauiHandlers(handlers =>
            {
                handlers.AddHandler(typeof(NoUnderLine), typeof(EntryHandler));
                EntryHandler.Mapper.AppendToMapping(nameof(NoUnderLine), (handler, view) =>
                {
                    // remove toàn bộ background mặc định của EditText (underline)
                    handler.PlatformView.Background = null;
                });
            });
#endif
            return builder.Build();
        }

        private static void ConfigureRefit(IServiceCollection services)
        {
            //var baseApiUrl = "https://r2dpzmzp-7022.asse.devtunnels.ms";
            services.AddRefitClient<IAuthApi>()
                .ConfigureHttpClient(SetHttpClient);
            services.AddRefitClient<IAdminApi>(GetRefitSettings)
                .ConfigureHttpClient(SetHttpClient);
            services.AddRefitClient<ISyncApi>(GetRefitSettings)
               .ConfigureHttpClient(SetHttpClient);
            services.AddRefitClient<IPostApi>(GetRefitSettings)
                .ConfigureHttpClient(SetHttpClient);
            services.AddRefitClient<IUserApi>(GetRefitSettings)
                .ConfigureHttpClient(SetHttpClient);
            void SetHttpClient(HttpClient httpClient) => httpClient.BaseAddress = new Uri(AppConstants.ApiBaseUrl);

            RefitSettings GetRefitSettings(IServiceProvider sp)
            {
                var authService = sp.GetRequiredService<AuthService>();
                return new RefitSettings
                {
                    AuthorizationHeaderValueGetter = (_, __) => Task.FromResult(authService.Token ?? "")
                };
            }
        }
    }
}
