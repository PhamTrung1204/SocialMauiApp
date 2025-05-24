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
                    fonts.AddFont("FluentSystemIcons-Regular.ttf", FluentUI.FontFamily);
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
            builder.Services.AddTransient<RealtimeUpdatesService>();

            // Cấu hình Refit
            ConfigureRefit(builder.Services);

            // Cấu hình deep link
            builder.ConfigureLifecycleEvents(events =>
            {
#if ANDROID
                events.AddAndroid(android => android.OnCreate((activity, bundle) =>
                {
                    var intent = activity.Intent;
                    if (intent?.Data != null)
                    {
                        var uri = intent.Data.ToString();
                        Console.WriteLine($"Deep link received: {uri}");
                        if (uri.Contains("socialmauiapp://RegisterPage"))
                        {
                            Application.Current.Dispatcher.Dispatch(async () =>
                            {
                                try
                                {
                                    if (Shell.Current != null)
                                    {
                                        var navigationParameters = new Dictionary<string, object>
                                        {
                                            { "ShowSuccessMessage", uri.Contains("verified=true") }
                                        };
                                        await Shell.Current.GoToAsync("//RegisterPage", navigationParameters);
                                    }
                                    else
                                    {
                                        Console.WriteLine("Shell.Current is null, delaying navigation...");
                                        await Task.Delay(1000);
                                        if (Shell.Current != null)
                                        {
                                            var navigationParameters = new Dictionary<string, object>
                                            {
                                                { "ShowSuccessMessage", uri.Contains("verified=true") }
                                            };
                                            await Shell.Current.GoToAsync("//RegisterPage", navigationParameters);
                                        }
                                        else
                                        {
                                            Console.WriteLine("Shell still not ready, navigation failed.");
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine($"Navigation error: {ex.Message}");
                                }
                            });
                        }
                    }
                }));
#endif
            });

            return builder.Build();
        }

        private static void ConfigureRefit(IServiceCollection services)
        {
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