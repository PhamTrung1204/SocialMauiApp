#!/usr/bin/env bash
# Sets every environment variable the API needs on Koyeb, fixes the port and
# health check, and lets Koyeb roll out the new configuration.
#
#   cp .env.koyeb.example .env.koyeb   # then fill it in (gitignored)
#   ./deploy-koyeb.sh
#
# Requires the Koyeb CLI: curl -fsSL https://raw.githubusercontent.com/koyeb/koyeb-cli/master/install.sh | sh
set -euo pipefail

cd "$(dirname "$0")"
[ -f .env.koyeb ] && set -a && . ./.env.koyeb && set +a

require() {
    if [ -z "${!1:-}" ]; then
        echo "error: $1 is not set (see .env.koyeb.example)" >&2
        exit 1
    fi
}

require KOYEB_TOKEN
require KOYEB_SERVICE      # APP/SERVICE, e.g. socialmaui/api
require DATABASE_URL
require JWT_SECRET_KEY
require PUBLIC_BASE_URL    # https://<name>-<org>.koyeb.app, no trailing slash

export KOYEB_TOKEN
PORT_NUMBER="${PORT_NUMBER:-8000}"

# Values that must not show up in `koyeb services describe` output.
upsert_secret() {
    koyeb secrets create "$1" --value "$2" >/dev/null 2>&1 \
        || koyeb secrets update "$1" --value "$2" >/dev/null
    echo "  secret $1"
}

echo "Secrets:"
upsert_secret socialmaui-db-url "$DATABASE_URL"
upsert_secret socialmaui-jwt-secret "$JWT_SECRET_KEY"
[ -n "${SMTP_APP_PASSWORD:-}" ] && upsert_secret socialmaui-smtp-password "$SMTP_APP_PASSWORD"

args=(
    # Koyeb defaults to the buildpack builder, which has no .NET support - every
    # build failed here before this flag existed. The Dockerfile is the whole build.
    --git-builder docker
    --git-docker-dockerfile SocialMauiApp.Api/Dockerfile

    --port "${PORT_NUMBER}:http"

    # The default TCP check passes before the app can serve, and every /api/* route
    # is 401. /health is anonymous and pings Postgres.
    --checks "${PORT_NUMBER}:http:/health"

    # Migrations run before app.Run(), so the port stays shut until they finish.
    # Measured 45s against a cold Neon compute (first connect times out, the retry
    # loop absorbs it). A short grace period kills the instance mid-migration.
    --checks-grace-period "${PORT_NUMBER}=120"

    --env "ConnectionStrings__SocialConnection={{ secret.socialmaui-db-url }}"
    --env "Jwt__SecretKey={{ secret.socialmaui-jwt-secret }}"
    --env "ASPNETCORE_ENVIRONMENT=Production"

    # Koyeb injects PORT, but pin it too so binding never depends on that.
    --env "ASPNETCORE_HTTP_PORTS=${PORT_NUMBER}"
    --env "Database__AutoMigrate=true"

    # Koyeb terminates TLS at the edge and forwards plain HTTP.
    --env "Hosting__UseHttpsRedirection=false"

    # All three must be the public URL: tokens are validated against the issuer and
    # uploaded media URLs are built from the base.
    --env "Domain=${PUBLIC_BASE_URL}"
    --env "AppSettings__BaseUrl=${PUBLIC_BASE_URL}"
    --env "Jwt__Issuer=${PUBLIC_BASE_URL}"

    --env "Jwt__ExpireInMinutes=${JWT_EXPIRE_MINUTES:-60}"
    --env "Jwt__RefreshTokenExpiryInDays=${JWT_REFRESH_TOKEN_EXPIRY_DAYS:-30}"

    --env "SmtpSettings__Host=${SMTP_HOST:-smtp.gmail.com}"
    --env "SmtpSettings__Port=${SMTP_PORT:-587}"
    --env "SmtpSettings__EnableSsl=${SMTP_ENABLE_SSL:-true}"
    --env "SmtpSettings__SenderEmail=${SMTP_SENDER_EMAIL:-}"
)

if [ -n "${SMTP_APP_PASSWORD:-}" ]; then
    args+=(--env "SmtpSettings__AppPassword={{ secret.socialmaui-smtp-password }}")
fi

echo "Updating ${KOYEB_SERVICE} ..."
koyeb services update "$KOYEB_SERVICE" "${args[@]}"

echo
echo "Rollout started. Follow it with:"
echo "  koyeb services logs ${KOYEB_SERVICE}"
echo "Then verify:"
echo "  curl -fsS ${PUBLIC_BASE_URL}/health"
