# Deployment

## Why not Vercel

Vercel cannot host this API. Three hard blockers, any one of which is fatal:

| Requirement | Vercel |
| --- | --- |
| **.NET / ASP.NET Core runtime** | not supported (Node, Python, Go, Ruby only) |
| **SignalR** (`MapHub`, persistent WebSockets) | serverless functions cannot hold a long-lived socket |
| **60 MB video upload** | serverless request body limit is ~4.5 MB |
| **Writable disk** for `wwwroot/uploads` and the SQLite cache | filesystem is ephemeral and read-only except `/tmp` |

There is also no web frontend to host - the client is a .NET MAUI app that ships
to Android/iOS/Windows, not a website.

Use a container host instead. **`render.yaml` in this repo is the supported path**
(see *Deploying to Render* below). Railway and Azure App Service work the same
way from the same Dockerfile if you ever need to move.

## Parameters

Every setting is read from configuration, so any of these can be supplied as an
environment variable. Nested keys use `__` (double underscore).

| Variable | Required | Default | Notes |
| --- | --- | --- | --- |
| `ConnectionStrings__SocialConnection` | **yes** | - | Npgsql `Host=…;Port=…;Database=…;Username=…;Password=…` **or** a `postgres://` URI - both are accepted. Falls back to `DATABASE_URL` |
| `Jwt__SecretKey` | **yes** | - | `openssl rand -base64 64`. App refuses to start without it |
| `Domain` | **yes** | - | Public base URL. Uploaded photo/video URLs are built from it |
| `AppSettings__BaseUrl` | **yes** | - | Same value as `Domain` |
| `Jwt__Issuer` | **yes** | - | Same value as `Domain`; tokens are validated against it |
| `PORT` | no | - | Injected by Render; the app binds it automatically |
| `ASPNETCORE_HTTP_PORTS` | no | `8080` | Used when `PORT` is absent (e.g. docker compose) |
| `ASPNETCORE_ENVIRONMENT` | no | `Production` | `Development` also exposes OpenAPI at `/openapi/v1.json` |
| `Database__AutoMigrate` | no | `true` | Applies EF migrations on boot, with retry while Postgres warms up |
| `Hosting__UseHttpsRedirection` | no | `true` | **Set `false` behind a TLS-terminating proxy** |
| `Jwt__ExpireInMinutes` | no | `60` | Access token lifetime |
| `Jwt__RefreshTokenExpiryInDays` | no | `30` | Refresh token lifetime |
| `SmtpSettings__Host` | no | `smtp.gmail.com` | |
| `SmtpSettings__Port` | no | `587` | |
| `SmtpSettings__EnableSsl` | no | `true` | |
| `SmtpSettings__SenderEmail` | for email | - | Registration/reset mail fails without it |
| `SmtpSettings__AppPassword` | for email | - | Gmail app password, not the account password |

## Persistent storage

Uploads are written to `/app/wwwroot/uploads` on local disk. **Mount a volume
there** or every deploy loses user photos and videos. Both manifests do this
(Render `disk`, Fly `[[mounts]]`). On a host without volumes, move uploads to
object storage first - `PhotoUploadService` is the only place that touches disk.

## Client configuration

The MAUI app points at a hardcoded URL in `SocialMediaMaui.Shared/AppConstants.cs`:

```csharp
public const string ApiBaseUrl = "https://r2dpzmzp-7022.asse.devtunnels.ms";
```

Change it to the deployed URL and rebuild the app. It is compiled into the
client, so it is not an environment variable.

## Deploying to Render

1. **Push the repo to GitHub.**
2. **Render -> New -> Blueprint**, select the repo. It reads `render.yaml` and
   creates the Postgres database and the web service.
3. **First apply will ask for the `sync: false` values.** You do not know the URL
   yet - put a placeholder in `Domain` / `AppSettings__BaseUrl` / `Jwt__Issuer`,
   and fill the SMTP pair (or leave blank to disable email).
4. **After the first build**, copy the assigned URL
   (`https://socialmaui-api.onrender.com`) into those three variables and
   redeploy. They must match or JWT validation rejects every token and uploaded
   media URLs point at the wrong host.
5. **Migrate legacy data** if you have any - see
   `SocialMauiApp.DataMigration/README.md`. Use the database's *external*
   connection string.
6. **Point the client at it**: set `AppConstants.ApiBaseUrl` and rebuild the app.

### Render specifics that bite

| Thing | Why it matters |
| --- | --- |
| `plan: starter`, not `free` | free web services have **no persistent disk**, so every deploy would wipe uploaded photos and videos |
| Free Postgres expires after 30 days | upgrade the database plan before you rely on it |
| `healthCheckPath: /health` | every `/api/*` route needs auth and returns 401, which Render reads as unhealthy and rolls back the deploy |
| `Hosting__UseHttpsRedirection: false` | Render terminates TLS; leaving it on risks a redirect loop |
| Free/starter instances sleep when idle | SignalR clients disconnect; first request after a sleep is slow |

## Order of operations

1. Create the PostgreSQL database.
2. Deploy the API - it applies migrations on boot (`Database__AutoMigrate`).
3. If you have legacy SQL Server data, run the one-off migration **before**
   anyone uses the app - see `SocialMauiApp.DataMigration/README.md`.
4. Update `AppConstants.ApiBaseUrl` and rebuild the client.
