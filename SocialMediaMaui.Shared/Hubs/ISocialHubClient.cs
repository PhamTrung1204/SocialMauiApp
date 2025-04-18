using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMediaMaui.Shared.Hubs
{
    public interface ISocialHubClient
    {
        Task PostChanged(PostDto post);
        Task PostDeleted(Guid postId);
        Task CommentAddedToThePost(CommentDto comment);
        Task CommentUpdated(CommentDto comment);
        Task CommentDeleted(Guid commentId);
        Task UserPhotoChanged(UserPhotoChangedDto userPhotoChangedDto);
        Task NotificationGenerated(NotificationDto notification);
        Task PostCountsUpdated(PostDto counts);
    }
    public record struct UserPhotoChangedDto(Guid UserId, string? PhotoUrl);
}
