# SQL Server -> PostgreSQL data migration

Copies the live data out of the old SQL Server database into the new PostgreSQL
schema created by `dotnet ef database update`.

Run it **after** the PostgreSQL schema exists and **before** anyone starts using
the app, from a machine that can reach both databases (normally the Windows box
where SQL Server lives).

```bash
dotnet run --project SocialMauiApp.DataMigration -- \
  --source "Data Source=.\SQLEXPRESS;Initial Catalog=SocialMaui;User ID=sa;Password=***;Trust Server Certificate=True" \
  --target "Host=localhost;Port=5432;Database=socialmaui;Username=socialmaui;Password=***" \
  --source-timezone "SE Asia Standard Time" \
  --dry-run
```

Drop `--dry-run` to actually write.

## What it handles

| Concern | Handling |
| --- | --- |
| `uniqueidentifier` -> `uuid` | native `Guid` round-trip |
| `bit` -> `boolean` | native `bool` |
| `datetime2` (**local time**) -> `timestamptz` | converted to UTC using `--source-timezone` |
| Self-referencing `Comments.ParentCommentId` | inserted flat, parents linked in a second pass |
| `SyncMetadata.Id` identity | sequence reset after copy |
| Re-runs | every insert is `ON CONFLICT DO NOTHING` |

## The timezone flag matters

The old code wrote timestamps with `DateTime.Now`, so SQL Server holds **local**
time. The PostgreSQL columns are `timestamp with time zone` and the app now
works in UTC. Passing the wrong `--source-timezone` shifts every post, comment
and notification by that offset. Default is the machine's local zone.

## Not copied

`Friendships` from the old schema. That table was created by a migration but no
code ever wrote to it, so there is nothing to move. If yours does contain rows,
see `MigrateFriendshipsAsync` in `Program.cs` - it is written but disabled
behind `--include-friendships`, because the old shape (`Id`, `UserId`,
`FriendId`, `Status`) has no `AcceptedAt` and its `Status` strings are unknown.
