#!/usr/bin/env bash
# Resume existing Compose services when a Codespace is restarted.
set -euo pipefail
cd "$(dirname "$0")/.."
if [[ -f .env.local ]] && docker info > /dev/null 2>&1; then
  docker compose up -d || echo "[OpenMAIC] Could not resume automatically. See CODESPACES.md and retry bash .devcontainer/bootstrap.sh"
else
  echo "[OpenMAIC] Docker or .env.local unavailable. See CODESPACES.md."
fi
