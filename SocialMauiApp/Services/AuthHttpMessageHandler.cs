using System.Net.Http.Headers;

namespace SocialMauiApp.Services
{
    public partial class AuthHttpMessageHandler : DelegatingHandler
    {
        private readonly AuthService _authService;

        public AuthHttpMessageHandler(AuthService authService)
        {
            _authService = authService;
        }

        protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            // Log toàn bộ header để kiểm tra
            foreach (var header in request.Headers)
            {
                Console.WriteLine($"{header.Key}: {string.Join(", ", header.Value)}");
            }

            if (!string.IsNullOrWhiteSpace(_authService.Token) && !request.Headers.Contains("Authorization"))
            {
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", _authService.Token);
                Console.WriteLine($"Added Authorization: Bearer {_authService.Token}");
            }
            else
            {
                Console.WriteLine("Authorization header already exists or token is empty.");
            }

            return await base.SendAsync(request, cancellationToken);
        }

    }
}
