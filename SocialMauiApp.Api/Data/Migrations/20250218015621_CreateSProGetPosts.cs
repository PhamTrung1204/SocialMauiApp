using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SocialMauiApp.Api.Data.Migrations
{
    /// <inheritdoc />
    public partial class CreateSProGetPosts : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
CREATE OR ALTER PROC GetPosts
    @StartIndex INT,
    @PageSize INT,
    @CurrentUserId UNIQUEIDENTIFIER
AS
BEGIN
    SELECT 
        p.Id AS PostId,
        p.UserId,
        u.[Name] AS UserName,
        u.PhotoUrl AS UserPhotoUrl,
        p.Content,
        p.PhotoUrl,
        p.PostedOn,
        p.ModifiedOn,
        CASE WHEN l.UserId IS NOT NULL THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS IsLiked,
        CASE WHEN b.UserId IS NOT NULL THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS IsBookmarked
    FROM Posts p
    INNER JOIN Users u ON p.UserId = u.Id
    LEFT JOIN Likes l ON p.Id = l.PostId AND l.UserId = @CurrentUserId
    LEFT JOIN Bookmarks b ON p.Id = b.PostId AND b.UserId = @CurrentUserId
    ORDER BY COALESCE(p.ModifiedOn, p.PostedOn) DESC
    OFFSET @StartIndex ROWS
    FETCH NEXT @PageSize ROWS ONLY
END

");
        }

        /// <inheritdoc />  
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"DROP PROC IF EXISTS GetPosts");
        }
    }
}
