using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Api.Data
{
    public static class PostQueryExtensions
    {
        // Thay cho ORDER BY COALESCE(ModifiedOn, PostedOn) DESC của stored procedure cũ.
        public static IQueryable<Post> OrderByMostRecent(this IQueryable<Post> posts) =>
            posts.OrderByDescending(p => p.ModifiedOn > p.PostedOn ? p.ModifiedOn : p.PostedOn);

        public static IQueryable<PostDto> ToPostDto(this IQueryable<Post> posts, DataContext context, Guid currentUserId) =>
            posts.Select(p => new PostDto
            {
                PostId = p.Id,
                UserId = p.UserId,
                UserName = p.User.Name,
                UserPhotoUrl = p.User.PhotoUrl,
                Content = p.Content,
                PhotoUrl = p.PhotoUrl,
                VideoUrl = p.VideoUrl,
                PostedOn = p.PostedOn,
                ModifiedOn = p.ModifiedOn,
                LikeCount = context.Likes.Count(l => l.PostId == p.Id),
                CommentCount = context.Comments.Count(c => c.PostId == p.Id),
                IsLiked = context.Likes.Any(l => l.PostId == p.Id && l.UserId == currentUserId),
                IsBookmarked = context.Bookmarks.Any(b => b.PostId == p.Id && b.UserId == currentUserId)
            });
    }
}
