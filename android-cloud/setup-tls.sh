#!/usr/bin/env bash
# Generates a self-signed TLS cert for local/first-run testing so Safari
# has an https:// origin to connect to (required for the video/input APIs
# ws-scrcpy relies on). For real use, replace nginx/certs/*.pem with a
# certificate from Let's Encrypt (certbot) for your actual domain.
set -euo pipefail

cd "$(dirname "$0")"
mkdir -p nginx/certs

openssl req -x509 -nodes -newkey rsa:2048 \
  -keyout nginx/certs/privkey.pem \
  -out nginx/certs/fullchain.pem \
  -days 365 \
  -subj "/CN=android-cloud.local"

echo "Self-signed cert written to nginx/certs/. Safari will warn on first visit — that's expected for self-signed certs; use a real cert (e.g. certbot) for anything beyond local testing."
