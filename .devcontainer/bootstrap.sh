#!/usr/bin/env bash
# First-run Codespaces setup. No API keys or credentials are committed to Git.
set -euo pipefail
cd "$(dirname "$0")/.."

if [[ ! -f .env.local ]]; then
  cp .env.example .env.local
  echo "[OpenMAIC] Created git-ignored .env.local (no API key configured)."
fi

echo "[OpenMAIC] Checking Docker daemon..."
docker info > /dev/null

echo "[OpenMAIC] Building and starting OpenMAIC + PostgreSQL..."
docker compose up -d --build

echo "[OpenMAIC] Current service status:"
docker compose ps
echo "[OpenMAIC] Open forwarded port 3000 in the Codespaces PORTS tab. Keep its visibility PRIVATE."
echo "[OpenMAIC] Set up an AI provider privately in Settings > Model Services."
echo "[OpenMAIC] Setup instructions: CODESPACES.md"
