SELECT * FROM Posts
SELECT * FROM Likes
SELECT * FROM Bookmarks
/*
public Guid PostId { get; set; }
public Guid UserId { get; set; }
public string? Content { get; set; }
public string? PhotoUrl { get; set; }
public DateTime PostedOn { get; set; }
public DateTime? ModifiedOn { get; set; }
public bool IsLiked { get; set; }
public bool IsBookmarked { get; set; }
--- int startIndex, int pageSize, Guid currentUserId
*/
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
        CASE WHEN l.UserId IS NOT NULL THEN 1 ELSE 0 END AS IsLiked,
        CASE WHEN b.UserId IS NOT NULL THEN 1 ELSE 0 END AS IsBookmarked
    FROM Posts p
    INNER JOIN Users u ON p.UserId = u.Id
    LEFT JOIN Likes l ON p.Id = l.PostId AND l.UserId = @CurrentUserId
    LEFT JOIN Bookmarks b ON p.Id = b.PostId AND b.UserId = @CurrentUserId
    ORDER BY COALESCE(p.ModifiedOn, p.PostedOn) DESC
    OFFSET @StartIndex ROWS
    FETCH NEXT @PageSize ROWS ONLY
END
DROP PROC IF EXISTS GetPosts