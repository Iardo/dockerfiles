#!/bin/sh
set -e

sed 's|${APP_HOST}|'"$APP_HOST"'|g' /etc/caddy/caddyfile.template > /etc/caddy/Caddyfile
caddy run --config /etc/caddy/Caddyfile
