using Microsoft.Data.SqlClient;
using Npgsql;

namespace SocialMauiApp.DataMigration;

internal sealed class Program
{
    private static async Task<int> Main(string[] args)
    {
        var options = MigrationOptions.Parse(args);
        if (options is null)
        {
            Console.WriteLine("""
                Usage:
                  --source  "<SQL Server connection string>"
                  --target  "<PostgreSQL connection string>"
                 [--source-timezone "SE Asia Standard Time"]   default: machine local zone
                 [--include-friendships]
                 [--dry-run]
                """);
            return 1;
        }

        var migrator = new Migrator(options);
        try
        {
            await migrator.RunAsync();
            return 0;
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"\nMigration FAILED: {ex.Message}");
            Console.Error.WriteLine(ex);
            return 1;
        }
    }
}

internal sealed record MigrationOptions(
    string Source,
    string Target,
    TimeZoneInfo SourceTimeZone,
    bool IncludeFriendships,
    bool DryRun)
{
    public static MigrationOptions? Parse(string[] args)
    {
        string? source = null, target = null, tz = null;
        bool friendships = false, dryRun = false;

        for (var i = 0; i < args.Length; i++)
        {
            switch (args[i])
            {
                case "--source" when i + 1 < args.Length: source = args[++i]; break;
                case "--target" when i + 1 < args.Length: target = args[++i]; break;
                case "--source-timezone" when i + 1 < args.Length: tz = args[++i]; break;
                case "--include-friendships": friendships = true; break;
                case "--dry-run": dryRun = true; break;
            }
        }

        if (string.IsNullOrWhiteSpace(source) || string.IsNullOrWhiteSpace(target))
        {
            return null;
        }

        var zone = TimeZoneInfo.Local;
        if (!string.IsNullOrWhiteSpace(tz))
        {
            try
            {
                zone = TimeZoneInfo.FindSystemTimeZoneById(tz);
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Unknown timezone '{tz}': {ex.Message}. Falling back to {TimeZoneInfo.Local.Id}.");
            }
        }

        return new MigrationOptions(source, target, zone, friendships, dryRun);
    }
}

internal sealed class Migrator(MigrationOptions options)
{
    private readonly MigrationOptions _options = options;

    public async Task RunAsync()
    {
        Console.WriteLine($"Source timezone : {_options.SourceTimeZone.Id}");
        Console.WriteLine($"Mode            : {(_options.DryRun ? "DRY RUN (nothing is written)" : "WRITE")}");
        Console.WriteLine();

        await using var sql = new SqlConnection(_options.Source);
        await sql.OpenAsync();

        await using var pg = new NpgsqlConnection(_options.Target);
        await pg.OpenAsync();

        await AssertTargetIsReadyAsync(pg);

        var users = await CopyUsersAsync(sql, pg);
        var posts = await CopyPostsAsync(sql, pg);
        var comments = await CopyCommentsAsync(sql, pg);
        var likes = await CopyJoinTableAsync(sql, pg, "Likes");
        var bookmarks = await CopyJoinTableAsync(sql, pg, "Bookmarks");
        var notifications = await CopyNotificationsAsync(sql, pg);
        var friendships = _options.IncludeFriendships ? await CopyFriendshipsAsync(sql, pg) : 0;

        if (!_options.DryRun)
        {
            await ResetIdentitySequencesAsync(pg);
        }

        Console.WriteLine();
        Console.WriteLine("Summary");
        Console.WriteLine($"  Users         {users}");
        Console.WriteLine($"  Posts         {posts}");
        Console.WriteLine($"  Comments      {comments}");
        Console.WriteLine($"  Likes         {likes}");
        Console.WriteLine($"  Bookmarks     {bookmarks}");
        Console.WriteLine($"  Notifications {notifications}");
        if (_options.IncludeFriendships)
        {
            Console.WriteLine($"  Friendships   {friendships}");
        }
        Console.WriteLine(_options.DryRun ? "\nDry run complete - nothing was written." : "\nMigration complete.");
    }

    // The schema must already exist (dotnet ef database update) and be empty-ish.
    private async Task AssertTargetIsReadyAsync(NpgsqlConnection pg)
    {
        await using var check = new NpgsqlCommand(
            """SELECT to_regclass('public."Users"') IS NOT NULL""", pg);
        if (await check.ExecuteScalarAsync() is not true)
        {
            throw new InvalidOperationException(
                "Target has no \"Users\" table. Run 'dotnet ef database update' against PostgreSQL first.");
        }

        await using var count = new NpgsqlCommand("""SELECT COUNT(*) FROM "Users" """, pg);
        var existing = Convert.ToInt64(await count.ExecuteScalarAsync());
        if (existing > 0)
        {
            Console.WriteLine($"NOTE: target already has {existing} user(s). Inserts use ON CONFLICT DO NOTHING, so this run is additive.");
        }
    }

    // SQL Server holds LOCAL time (the old code used DateTime.Now); PostgreSQL
    // columns are timestamptz and the app now reasons in UTC.
    private DateTime ToUtc(DateTime value)
    {
        var unspecified = DateTime.SpecifyKind(value, DateTimeKind.Unspecified);
        return TimeZoneInfo.ConvertTimeToUtc(unspecified, _options.SourceTimeZone);
    }

    private DateTime? ToUtc(DateTime? value) => value.HasValue ? ToUtc(value.Value) : null;

    private static T? Read<T>(SqlDataReader r, string column)
    {
        var i = r.GetOrdinal(column);
        return r.IsDBNull(i) ? default : r.GetFieldValue<T>(i);
    }

    private async Task<int> ExecuteAsync(NpgsqlConnection pg, string sql, Action<NpgsqlParameterCollection> bind)
    {
        if (_options.DryRun)
        {
            return 1;
        }
        await using var cmd = new NpgsqlCommand(sql, pg);
        bind(cmd.Parameters);
        return await cmd.ExecuteNonQueryAsync();
    }

    private async Task<int> CopyUsersAsync(SqlConnection sql, NpgsqlConnection pg)
    {
        const string select = """
            SELECT Id, Email, Name, PasswordHash, Role, EmailConfirmed, VerificationToken,
                   VerificationTokenExpiry, ResetToken, ResetTokenExpiry, PhotoPath, PhotoUrl,
                   IsLocked, RefreshToken, RefreshTokenExpiry
            FROM Users
            """;
        const string insert = """
            INSERT INTO "Users" ("Id","Email","Name","PasswordHash","Role","EmailConfirmed",
                                 "VerificationToken","VerificationTokenExpiry","ResetToken","ResetTokenExpiry",
                                 "PhotoPath","PhotoUrl","IsLocked","RefreshToken","RefreshTokenExpiry")
            VALUES (@id,@email,@name,@hash,@role,@confirmed,
                    @vtoken,@vexp,@rtoken,@rexp,@ppath,@purl,@locked,@refresh,@refexp)
            ON CONFLICT ("Id") DO NOTHING
            """;

        var copied = 0;
        await using var cmd = new SqlCommand(select, sql);
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync())
        {
            // Refresh tokens are now stored hashed; legacy plaintext values would
            // never match, so drop them and make everyone sign in once.
            copied += await ExecuteAsync(pg, insert, p =>
            {
                p.AddWithValue("id", Read<Guid>(r, "Id"));
                p.AddWithValue("email", Read<string>(r, "Email") ?? string.Empty);
                p.AddWithValue("name", Read<string>(r, "Name") ?? string.Empty);
                p.AddWithValue("hash", Read<string>(r, "PasswordHash") ?? string.Empty);
                p.AddWithValue("role", Read<string>(r, "Role") ?? "Client");
                p.AddWithValue("confirmed", Read<bool>(r, "EmailConfirmed"));
                p.AddWithValue("vtoken", (object?)Read<string>(r, "VerificationToken") ?? DBNull.Value);
                p.AddWithValue("vexp", (object?)ToUtc(Read<DateTime?>(r, "VerificationTokenExpiry")) ?? DBNull.Value);
                p.AddWithValue("rtoken", (object?)Read<string>(r, "ResetToken") ?? DBNull.Value);
                p.AddWithValue("rexp", (object?)ToUtc(Read<DateTime?>(r, "ResetTokenExpiry")) ?? DBNull.Value);
                p.AddWithValue("ppath", (object?)Read<string>(r, "PhotoPath") ?? DBNull.Value);
                p.AddWithValue("purl", (object?)Read<string>(r, "PhotoUrl") ?? DBNull.Value);
                p.AddWithValue("locked", Read<bool>(r, "IsLocked"));
                p.AddWithValue("refresh", DBNull.Value);
                p.AddWithValue("refexp", DBNull.Value);
            });
        }
        Console.WriteLine($"Users          -> {copied}");
        return copied;
    }

    private async Task<int> CopyPostsAsync(SqlConnection sql, NpgsqlConnection pg)
    {
        const string select = """
            SELECT Id, UserId, LikeCount, CommentCount, Content, PhotoPath, PhotoUrl,
                   PostedOn, ModifiedOn, IsDeleted, IsSynced
            FROM Posts
            """;
        const string insert = """
            INSERT INTO "Posts" ("Id","UserId","LikeCount","CommentCount","Content","PhotoPath","PhotoUrl",
                                 "VideoPath","VideoUrl","PostedOn","ModifiedOn","IsDeleted","IsSynced")
            VALUES (@id,@uid,@likes,@comments,@content,@ppath,@purl,NULL,NULL,@posted,@modified,@deleted,@synced)
            ON CONFLICT ("Id") DO NOTHING
            """;

        var copied = 0;
        await using var cmd = new SqlCommand(select, sql);
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync())
        {
            copied += await ExecuteAsync(pg, insert, p =>
            {
                p.AddWithValue("id", Read<Guid>(r, "Id"));
                p.AddWithValue("uid", Read<Guid>(r, "UserId"));
                p.AddWithValue("likes", Read<int>(r, "LikeCount"));
                p.AddWithValue("comments", Read<int>(r, "CommentCount"));
                p.AddWithValue("content", (object?)Read<string>(r, "Content") ?? DBNull.Value);
                p.AddWithValue("ppath", (object?)Read<string>(r, "PhotoPath") ?? DBNull.Value);
                p.AddWithValue("purl", (object?)Read<string>(r, "PhotoUrl") ?? DBNull.Value);
                p.AddWithValue("posted", ToUtc(Read<DateTime>(r, "PostedOn")));
                p.AddWithValue("modified", ToUtc(Read<DateTime>(r, "ModifiedOn")));
                p.AddWithValue("deleted", Read<bool>(r, "IsDeleted"));
                p.AddWithValue("synced", Read<bool>(r, "IsSynced"));
            });
        }
        Console.WriteLine($"Posts          -> {copied}");
        return copied;
    }

    // Comments self-reference. Insert every row with a null parent first, then
    // link parents in a second pass so nesting depth never matters.
    private async Task<int> CopyCommentsAsync(SqlConnection sql, NpgsqlConnection pg)
    {
        const string select = """
            SELECT Id, PostId, Content, PhotoPath, PhotoUrl, UserId, AddedOn, ParentCommentId, IsSynced
            FROM Comments
            """;
        const string insert = """
            INSERT INTO "Comments" ("Id","PostId","Content","PhotoPath","PhotoUrl","UserId","AddedOn","ParentCommentId","IsSynced")
            VALUES (@id,@postId,@content,@ppath,@purl,@uid,@added,NULL,@synced)
            ON CONFLICT ("Id") DO NOTHING
            """;
        const string link = """UPDATE "Comments" SET "ParentCommentId" = @parent WHERE "Id" = @id""";

        var parents = new List<(Guid Id, Guid Parent)>();
        var copied = 0;

        await using (var cmd = new SqlCommand(select, sql))
        await using (var r = await cmd.ExecuteReaderAsync())
        {
            while (await r.ReadAsync())
            {
                var id = Read<Guid>(r, "Id");
                var parent = Read<Guid?>(r, "ParentCommentId");
                if (parent.HasValue)
                {
                    parents.Add((id, parent.Value));
                }

                copied += await ExecuteAsync(pg, insert, p =>
                {
                    p.AddWithValue("id", id);
                    p.AddWithValue("postId", Read<Guid>(r, "PostId"));
                    p.AddWithValue("content", Read<string>(r, "Content") ?? string.Empty);
                    p.AddWithValue("ppath", (object?)Read<string>(r, "PhotoPath") ?? DBNull.Value);
                    p.AddWithValue("purl", (object?)Read<string>(r, "PhotoUrl") ?? DBNull.Value);
                    p.AddWithValue("uid", Read<Guid>(r, "UserId"));
                    p.AddWithValue("added", ToUtc(Read<DateTime>(r, "AddedOn")));
                    p.AddWithValue("synced", Read<bool>(r, "IsSynced"));
                });
            }
        }

        foreach (var (id, parent) in parents)
        {
            await ExecuteAsync(pg, link, p =>
            {
                p.AddWithValue("parent", parent);
                p.AddWithValue("id", id);
            });
        }

        Console.WriteLine($"Comments       -> {copied} ({parents.Count} reply link(s))");
        return copied;
    }

    private async Task<int> CopyJoinTableAsync(SqlConnection sql, NpgsqlConnection pg, string table)
    {
        var select = $"SELECT PostId, UserId FROM {table}";
        var insert = $"""
            INSERT INTO "{table}" ("PostId","UserId") VALUES (@postId,@userId)
            ON CONFLICT ("PostId","UserId") DO NOTHING
            """;

        var copied = 0;
        await using var cmd = new SqlCommand(select, sql);
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync())
        {
            copied += await ExecuteAsync(pg, insert, p =>
            {
                p.AddWithValue("postId", Read<Guid>(r, "PostId"));
                p.AddWithValue("userId", Read<Guid>(r, "UserId"));
            });
        }
        Console.WriteLine($"{table,-14} -> {copied}");
        return copied;
    }

    private async Task<int> CopyNotificationsAsync(SqlConnection sql, NpgsqlConnection pg)
    {
        const string select = """SELECT Id, ForUserId, [When], PostId, Text FROM Notifications""";
        const string insert = """
            INSERT INTO "Notifications" ("Id","ForUserId","When","PostId","Text")
            VALUES (@id,@forUser,@when,@postId,@text)
            ON CONFLICT ("Id") DO NOTHING
            """;

        var copied = 0;
        await using var cmd = new SqlCommand(select, sql);
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync())
        {
            copied += await ExecuteAsync(pg, insert, p =>
            {
                p.AddWithValue("id", Read<Guid>(r, "Id"));
                p.AddWithValue("forUser", Read<Guid>(r, "ForUserId"));
                p.AddWithValue("when", ToUtc(Read<DateTime>(r, "When")));
                p.AddWithValue("postId", (object?)Read<Guid?>(r, "PostId") ?? DBNull.Value);
                p.AddWithValue("text", (object?)Read<string>(r, "Text") ?? DBNull.Value);
            });
        }
        Console.WriteLine($"Notifications  -> {copied}");
        return copied;
    }

    // Old shape: Id, UserId, FriendId, Status, CreatedAt. New shape is one
    // directional row keyed on (RequesterId, AddresseeId).
    private async Task<int> CopyFriendshipsAsync(SqlConnection sql, NpgsqlConnection pg)
    {
        const string select = "SELECT UserId, FriendId, Status, CreatedAt FROM Friendships";
        const string insert = """
            INSERT INTO "Friendships" ("RequesterId","AddresseeId","Status","CreatedAt","AcceptedAt")
            VALUES (@requester,@addressee,@status,@created,@accepted)
            ON CONFLICT ("RequesterId","AddresseeId") DO NOTHING
            """;

        var copied = 0;
        await using var cmd = new SqlCommand(select, sql);
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync())
        {
            var legacyStatus = Read<string>(r, "Status") ?? string.Empty;
            var accepted = legacyStatus.Contains("accept", StringComparison.OrdinalIgnoreCase)
                        || legacyStatus.Equals("Friends", StringComparison.OrdinalIgnoreCase);
            var createdAt = ToUtc(Read<DateTime>(r, "CreatedAt"));

            copied += await ExecuteAsync(pg, insert, p =>
            {
                p.AddWithValue("requester", Read<Guid>(r, "UserId"));
                p.AddWithValue("addressee", Read<Guid>(r, "FriendId"));
                p.AddWithValue("status", accepted ? "Accepted" : "Pending");
                p.AddWithValue("created", createdAt);
                p.AddWithValue("accepted", accepted ? createdAt : (object)DBNull.Value);
            });
        }
        Console.WriteLine($"Friendships    -> {copied}");
        return copied;
    }

    // SyncMetadata.Id is an identity column; without this the next insert collides.
    private async Task ResetIdentitySequencesAsync(NpgsqlConnection pg)
    {
        const string sql = """
            SELECT setval(
                pg_get_serial_sequence('"SyncMetadata"', 'Id'),
                GREATEST(COALESCE((SELECT MAX("Id") FROM "SyncMetadata"), 0), 1),
                true)
            """;
        await using var cmd = new NpgsqlCommand(sql, pg);
        await cmd.ExecuteScalarAsync();
        Console.WriteLine("Identity sequences reset.");
    }
}
