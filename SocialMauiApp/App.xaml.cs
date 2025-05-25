using Microsoft.Maui.Controls;
using SocialMauiApp.Services;
using SocialMauiApp.ViewModel;

namespace SocialMauiApp
{
    public partial class App : Application
    {
        private readonly IDeepLinkService _deepLinkService;

        public App(IDeepLinkService deepLinkService)
        {
            Console.WriteLine("App constructor started.");
            InitializeComponent();
            Console.WriteLine("App constructor completed.");
            _deepLinkService = deepLinkService;
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            Console.WriteLine("CreateWindow called.");
            var window = new Window(new AppShell());

            // Process any pending deep link after Shell is initialized
            var pendingDeepLink = _deepLinkService.GetPendingDeepLink();
            if (pendingDeepLink != null)
            {
                Console.WriteLine($"Pending deep link detected: {pendingDeepLink}");
                Console.WriteLine($"Scheme: {pendingDeepLink.Scheme}, Host: {pendingDeepLink.Host}, Path: {pendingDeepLink.AbsolutePath}, Query: {pendingDeepLink.Query}");
                OnAppLinkRequestReceived(pendingDeepLink);
                _deepLinkService.ClearPendingDeepLink();
            }
            else
            {
                Console.WriteLine("No pending deep link found.");
            }

            return window;
        }

        protected override void OnAppLinkRequestReceived(Uri uri)
        {
            base.OnAppLinkRequestReceived(uri);
            MainThread.BeginInvokeOnMainThread(async () =>
            {
                Console.WriteLine($"OnAppLinkRequestReceived triggered with URI: {uri?.AbsoluteUri}");
                Console.WriteLine($"Scheme: {uri?.Scheme}, Host: {uri?.Host}, Path: {uri?.AbsolutePath}, Query: {uri?.Query}");
                if (Shell.Current == null)
                {
                    Console.WriteLine("Error: Shell.Current is null. Cannot process deep link.");
                    return;
                }

                try
                {
                    if (uri == null || string.IsNullOrWhiteSpace(uri.OriginalString))
                    {
                        Console.WriteLine("Invalid deep link: URI is null or empty.");
                        await Shell.Current.DisplayAlert("Error", "Invalid deep link: URI is null or empty.", "OK");
                        return;
                    }

                    Dictionary<string, string> ParseQuery(Uri uri)
                    {
                        Console.WriteLine($"Parsing query for URI: {uri.AbsoluteUri}");
                        var queryDict = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
                        if (!string.IsNullOrWhiteSpace(uri.Query))
                        {
                            var queryString = uri.Query.TrimStart('?');
                            Console.WriteLine($"Query string: {queryString}");
                            foreach (var param in queryString.Split('&', StringSplitOptions.RemoveEmptyEntries))
                            {
                                var parts = param.Split('=', 2, StringSplitOptions.None);
                                if (parts.Length == 2)
                                {
                                    var key = Uri.UnescapeDataString(parts[0]);
                                    var value = Uri.UnescapeDataString(parts[1]);
                                    Console.WriteLine($"Parsed parameter: {key}={value}");
                                    queryDict[key] = value;
                                }
                                else
                                {
                                    Console.WriteLine($"Skipping invalid parameter: {param}");
                                }
                            }
                        }
                        else
                        {
                            Console.WriteLine("No query parameters found.");
                        }
                        return queryDict;
                    }

                    var uriString = uri.AbsoluteUri.ToLowerInvariant();
                    if (uriString.Contains("socialmauiapp://resetpasswordpage"))
                    {
                        var query = ParseQuery(uri);
                        if (query.TryGetValue("resetToken", out var resetToken) && !string.IsNullOrEmpty(resetToken))
                        {
                            Console.WriteLine($"Found resetToken: {resetToken}");
                            await Shell.Current.Navigation.PopToRootAsync(); // Clear navigation stack
                            var route = $"//ResetPasswordPage?resetToken={Uri.EscapeDataString(resetToken)}";
                            Console.WriteLine($"Navigating to route: {route}");
                            try
                            {
                                await Shell.Current.GoToAsync(route);
                                Console.WriteLine("Navigation to ResetPasswordPage completed successfully.");
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Navigation failed: {ex.Message}\nStack Trace: {ex.StackTrace}");
                                await Shell.Current.DisplayAlert("Navigation Error", $"Failed to navigate: {ex.Message}", "OK");
                                throw;
                            }
                        }
                        else
                        {
                            Console.WriteLine("No valid resetToken found in query.");
                            await Shell.Current.DisplayAlert("Error", "Invalid reset link: Missing resetToken parameter.", "OK");
                        }
                    }
                    else if (uriString.Contains("socialmauiapp://registerpage"))
                    {
                        var query = ParseQuery(uri);
                        var verified = query.ContainsKey("verified") && bool.TryParse(query["verified"], out var v) && v;
                        var route = $"//RegisterPage?ShowSuccessMessage={verified}";
                        Console.WriteLine($"Navigating to route: {route}");
                        try
                        {
                            await Shell.Current.GoToAsync(route);
                            Console.WriteLine("Navigation to RegisterPage completed successfully.");
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Navigation failed: {ex.Message}\nStack Trace: {ex.StackTrace}");
                            throw;
                        }
                    }
                    else if (uriString.Contains("/verify-email") || uriString.Contains("/api/auth/verify-email"))
                    {
                        var query = ParseQuery(uri);
                        if (query.TryGetValue("token", out var token) && !string.IsNullOrEmpty(token))
                        {
                            var route = $"//RegisterPage?token={Uri.EscapeDataString(token)}";
                            Console.WriteLine($"Navigating to RegisterPage with verification token: {token}");
                            try
                            {
                                await Shell.Current.GoToAsync(route);
                                Console.WriteLine("Navigation to RegisterPage completed successfully.");
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Navigation failed: {ex.Message}\nStack Trace: {ex.StackTrace}");
                                throw;
                            }
                        }
                        else
                        {
                            Console.WriteLine("Invalid verification link: Missing token parameter.");
                            await Shell.Current.DisplayAlert("Error", "Invalid verification link: Missing token parameter.", "OK");
                        }
                    }
                    else if (uriString.Contains("/api/auth/verify-reset-token"))
                    {
                        var query = ParseQuery(uri);
                        if (query.TryGetValue("token", out var token) && !string.IsNullOrEmpty(token))
                        {
                            await Shell.Current.Navigation.PopToRootAsync(); // Clear navigation stack
                            var route = $"//ResetPasswordPage?resetToken={Uri.EscapeDataString(token)}";
                            Console.WriteLine($"Navigating to ResetPasswordPage with resetToken: {token}");
                            try
                            {
                                await Shell.Current.GoToAsync(route);
                                Console.WriteLine("Navigation to ResetPasswordPage completed successfully.");
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Navigation failed: {ex.Message}\nStack Trace: {ex.StackTrace}");
                                throw;
                            }
                        }
                        else
                        {
                            Console.WriteLine("Invalid reset link: Missing token parameter.");
                            await Shell.Current.DisplayAlert("Error", "Invalid reset link: Missing token parameter.", "OK");
                        }
                    }
                    else
                    {
                        Console.WriteLine($"Unsupported deep link: {uri.AbsoluteUri}");
                        await Shell.Current.DisplayAlert("Error", "Unsupported deep link.", "OK");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Deep link processing error: {ex.Message}\nStack Trace: {ex.StackTrace}");
                    await Shell.Current.DisplayAlert("Error", $"Failed to process link: {ex.Message}", "OK");
                }
            });
        }
    }
}