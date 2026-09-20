using Microsoft.AspNetCore.SignalR;
using SocialMauiApp.Api.Data;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;
using SocialMediaMaui.Shared.Hubs;

namespace SocialMauiApp.Api.Services
{
    public class NotificationService
    {
        private readonly DataContext _context;
        private readonly IHubContext<SocialHub, ISocialHubClient> _hubContext;
        private readonly ILogger<NotificationService> _logger;

        public NotificationService(
            DataContext context,
            IHubContext<SocialHub, ISocialHubClient> hubContext,
            ILogger<NotificationService> logger)
        {
            _context = context;
            _hubContext = hubContext;
            _logger = logger;
        }

        public async Task SaveAsync(NotificationDto dto)
        {
            try
            {
                _context.Notifications.Add(new Notification
                {
                    ForUserId = dto.ForUserId,
                    PostId = dto.PostId,
                    Text = dto.Text,
                    When = dto.When
                });
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                // Thông báo hỏng không được làm hỏng hành động chính đã commit.
                _logger.LogError(ex, "Failed to save notification for user {UserId}.", dto.ForUserId);
            }
        }

        public async Task SaveAndBroadcastAsync(NotificationDto dto)
        {
            await SaveAsync(dto);
            await _hubContext.Clients.All.NotificationGenerated(dto);
        }
    }
}
