using CommunityToolkit.Maui;
using CommunityToolkit.Maui.Views;
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
using Microsoft.Maui.LifecycleEvents;

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
                .UseMauiCommunityToolkitMediaElement()
                .ConfigureSyncfusionToolkit()
                .ConfigureMauiHandlers(handlers =>
                {
#if ANDROID
                    handlers.AddHandler(typeof(NoUnderLine), typeof(EntryHandler));
                    EntryHandler.Mapper.AppendToMapping(nameof(NoUnderLine), (handler, view) =>
                    {
                        handler.PlatformView.Background = null;
                    });
#endif
                })
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("Ubuntu-Bold.tff", "UbuntuBold");
                    fonts.AddFont("Ubuntu-Regular.ttf", "UbuntuRegular");
                    fonts.AddFont("FluentSystemIcons-Regular.ttf", "FluentUI");
                })
                .ConfigureSyncfusionCore();

            // Đăng ký dịch vụ
            builder.Services.AddSingleton<AuthService>();
            builder.Services.AddSingleton<LocalDatabase>();
            builder.Services.AddSingleton<IPreferencesService, PreferencesService>();
            builder.Services.AddTransient<LoginViewModel>().AddTransient<LoginPage>();
            builder.Services.AddTransient<AdminViewModel>().AddTransient<AdminDashboardPage>();
            builder.Services.AddTransient<PostManageViewModel>().AddTransient<PostManagementPage>();
            builder.Services.AddTransient<ResetPasswordViewModel>().AddTransient<ResetPasswordPage>();
            builder.Services.AddTransient<RegisterViewModel>().AddTransient<RegisterPage>();
            builder.Services.AddTransient<SavePostViewModel>().AddTransient<AddPostPage>();
            builder.Services.AddSingleton<HomeViewModel>().AddSingleton<HomePage>();
            builder.Services.AddTransient<DetailsViewModel>().AddTransient<PostDetailsPage>();
            builder.Services.AddTransient<ProfileViewModel>().AddTransient<ProfilePage>();
            builder.Services.AddTransient<NotificationViewModel>().AddTransient<NotificationPage>();
            builder.Services.AddTransient<FriendsViewModel>().AddTransient<FriendsPage>();
            builder.Services.AddTransient<SettingsViewModel>().AddTransient<SettingsPage>();
            builder.Services.AddTransient<UserProfileViewModel>().AddTransient<UserProfilePage>();
            builder.Services.AddTransient<RealtimeUpdatesService>();

            // Cấu hình Refit
            ConfigureRefit(builder.Services);

            // Đăng ký dịch vụ deep link
#if ANDROID
            builder.Services.AddSingleton<IDeepLinkService, Platforms.Android.DeepLinkService>();
#else
            builder.Services.AddSingleton<IDeepLinkService, DefaultDeepLinkService>();
#endif

            var app = builder.Build();

            // Khôi phục ngôn ngữ người dùng đã chọn; mặc định là tiếng Anh.
            var preferences = app.Services.GetRequiredService<IPreferencesService>();
            LocalizationService.Instance.SetLanguage(
                preferences.GetString(LocalizationService.PreferenceKey, LocalizationService.DefaultLanguage));

            return app;
        }

        private static void ConfigureRefit(IServiceCollection services)
        {
            services.AddRefitClient<IAuthApi>()
                .ConfigureHttpClient(c => c.BaseAddress = new Uri(AppConstants.ApiBaseUrl));
            services.AddRefitClient<IAdminApi>(GetRefitSettings)
                .ConfigureHttpClient(c => c.BaseAddress = new Uri(AppConstants.ApiBaseUrl));
            services.AddRefitClient<ISyncApi>(GetRefitSettings)
                .ConfigureHttpClient(c => c.BaseAddress = new Uri(AppConstants.ApiBaseUrl));
            services.AddRefitClient<IPostApi>(GetRefitSettings)
                .ConfigureHttpClient(c => c.BaseAddress = new Uri(AppConstants.ApiBaseUrl));
            services.AddRefitClient<IUserApi>(GetRefitSettings)
                .ConfigureHttpClient(c => c.BaseAddress = new Uri(AppConstants.ApiBaseUrl));
            services.AddRefitClient<IFriendApi>(GetRefitSettings)
                .ConfigureHttpClient(c => c.BaseAddress = new Uri(AppConstants.ApiBaseUrl));

            RefitSettings GetRefitSettings(IServiceProvider sp)
            {
                var authService = sp.GetRequiredService<AuthService>();
                return new RefitSettings
                {
                    AuthorizationHeaderValueGetter = (_, __) => Task.FromResult(authService.Token ?? string.Empty)
                };
            }
        }
    }

    // Default implementation for non-Android platforms
    public class DefaultDeepLinkService : IDeepLinkService
    {
        public Uri? GetPendingDeepLink() => null;
        public void ClearPendingDeepLink() { }
    }
}