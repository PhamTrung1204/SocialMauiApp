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
## Deploying to Koyeb

Koyeb has no blueprint file, so nothing in this repo configures it — the service
is created in the dashboard and every variable below has to be supplied
explicitly. `deploy-koyeb.sh` does that in one shot.

1. **Create the database first.** Koyeb has no managed Postgres; use Neon,
   Supabase or Aiven and copy the connection URI. `Program.cs` accepts the
   `postgres://` form as-is.
2. **Create the service** from the GitHub repo, builder **Dockerfile**, path
   `SocialMauiApp.Api/Dockerfile`, build context the repo root.
3. **Fill in the config and apply it:**
   ```bash
   cp .env.koyeb.example .env.koyeb   # gitignored
   ./deploy-koyeb.sh
   ```
   The first apply can use a placeholder `PUBLIC_BASE_URL`; once Koyeb assigns
   the real `*.koyeb.app` URL, put it in `.env.koyeb` and re-run the script.
4. **Verify:** `curl -fsS "$PUBLIC_BASE_URL/health"` returns
   `{"status":"healthy"}`. Anything else, read `koyeb services logs <app>/<svc>`.
5. **Point the client at it**: set `AppConstants.ApiBaseUrl` and rebuild the app.

### Koyeb specifics that bite

| Thing | Why it matters |
| --- | --- |
| Missing `ConnectionStrings__SocialConnection` | `Program.cs` throws before the port opens; the instance never becomes healthy and the deploy is rolled back. This is the single most common cause of a failed first deploy |
| Unreachable database | `InitializeDatabasesAsync` retries 10 × 3s and *then* rethrows — the port stays shut for 30s and the crash looks like a health-check timeout, not a database error |
| Neon scale-to-zero | the first connect to a cold compute times out and burns a retry; measured 45s from container start to a healthy `/health` |
| Health check grace period | must exceed that 30s window, or Koyeb kills the instance mid-migration. `deploy-koyeb.sh` sets 120s |
| Health check must be `http:/health` | the default TCP check passes before the app can serve, and every `/api/*` route returns 401 |
| `Hosting__UseHttpsRedirection: false` | Koyeb terminates TLS at the edge and forwards plain HTTP |
| No persistent disk by default | Koyeb volumes are region-limited and cannot be attached to a service that scales to zero. Without one, `/app/wwwroot/uploads` is wiped on every deploy — move uploads to object storage before production |
| Scale-to-zero | SignalR clients disconnect and the first request after a sleep is slow |

## Order of operations

1. Create the PostgreSQL database.
2. Deploy the API - it applies migrations on boot (`Database__AutoMigrate`).
3. If you have legacy SQL Server data, run the one-off migration **before**
   anyone uses the app - see `SocialMauiApp.DataMigration/README.md`.
4. Update `AppConstants.ApiBaseUrl` and rebuild the client.
