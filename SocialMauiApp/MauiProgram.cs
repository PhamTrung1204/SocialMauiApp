using CommunityToolkit.Maui;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Refit;
using SocialMauiApp.Apis;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;
using Syncfusion.Maui.Toolkit.Hosting;

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
                });

#if DEBUG
            builder.Logging.AddDebug();
            builder.Services.AddLogging(configure => configure.AddDebug());
#endif

            builder.Services.AddSingleton<AuthService>();
            builder.Services.AddTransient<LoginViewModel>().AddTransient<LoginPage>();
            builder.Services.AddTransient<RegisterViewModel>().AddTransient<RegisterPage>();

            ConfigureRefit(builder.Services);
            return builder.Build();
        }
        private static void ConfigureRefit(IServiceCollection services)
        {
            var baseApiUrl = "https://8tdthlzc-7022.asse.devtunnels.ms";
            services.AddRefitClient<IAuthApi>()
                .ConfigureHttpClient(SetHttpClient);
            services.AddRefitClient<IPostApi>(GetRefitSettings)
                .ConfigureHttpClient(SetHttpClient);
            services.AddRefitClient<IUserApi>(GetRefitSettings)
                .ConfigureHttpClient(SetHttpClient);
            void SetHttpClient(HttpClient httpClient) => httpClient.BaseAddress = new Uri(baseApiUrl);

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
