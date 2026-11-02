# OpenMAIC on GitHub Codespaces (personal trial)

This fork can be launched on a GitHub Codespace **without installing OpenMAIC on a local Mac**. It uses Docker-in-Docker to run OpenMAIC and PostgreSQL via the repository's upstream Docker Compose file.

## Start from GitHub

1. Open https://github.com/Diavn/OpenMAIC
2. Select **Code → Codespaces → Create codespace on main**. If prompted, use a 4-core machine for the initial heavy build if the 2-core machine runs out of memory. A larger machine consumes the free compute quota faster.
3. The Codespace uses `.devcontainer/devcontainer.json`. The **first creation** only copies `.env.example` to the **git-ignored** `.env.local`. It deliberately does **not** attempt the large OpenMAIC Docker build during dev-container startup; this avoids putting the Codespace in recovery mode if application compilation fails. No API key is generated or requested.
4. After the terminal is ready, **manually start the application**:
   ```bash
   cd /workspaces/OpenMAIC
   bash .devcontainer/bootstrap.sh
   ```
   This builds and runs OpenMAIC and PostgreSQL. It may take substantial resources, especially on 2-core Codespaces; a failed application build should not prevent opening the development environment.
5. Check the running services:
   ```bash
   docker compose ps
   docker compose logs --tail=100 openmaic
   ```
   If the first build failed, inspect the log and retry:
   ```bash
   bash .devcontainer/bootstrap.sh
   ```
6. Open the **PORTS** panel, find port **3000**, make sure visibility is **Private**, then select **Open in Browser**. Do **not** make the port Public. The forwarded URL is unique to the actual Codespace.
7. In the OpenMAIC web UI, configure an AI provider in **Settings → Model Services** (or **Settings → Token Plan**). The AI API may have its own separate costs. Do not paste API keys into the public repository.

## Manage the trial

```bash
docker compose ps
docker compose logs -f openmaic
docker compose restart
docker compose down         # stop containers, preserve named volumes
docker compose up -d        # resume
```

**Never run `docker compose down -v` unless you intentionally want to erase the database and stored classrooms.**

The Compose stack defaults to **single-user mode**. A private GitHub Codespaces port adds access control at the port-forwarding boundary, but this is **not** a multi-tenant student portal. Keep it private.

GitHub Codespaces is a development environment, not a 24/7 cloud hosting service. It can stop automatically after inactivity, and the free usage allowance is limited. Check https://github.com/settings/billing and https://github.com/codespaces for current consumption and to stop/delete idle environments. Deleting a Codespace also deletes its local Docker data unless it is backed up elsewhere.

## Troubleshooting

- **No container**: run `docker info` then `bash .devcontainer/bootstrap.sh`.
- **OOM / exit 137**: stop the build, choose a larger Codespaces machine (uses more core-hours), retry. Do not assume the free quota covers it.
- **App boots but generation fails**: configure a model provider/key in the UI, and inspect `docker compose logs --tail=100 openmaic`.
- **Port 3000 missing**: check `docker compose ps`; confirm OpenMAIC is running; in the PORTS panel manually forward port 3000 and keep it **Private**.
- **Data missing after recreation**: Docker volumes belong to the particular Codespace and are not copied automatically when you create a new Codespace.

Upstream deployment documentation: https://github.com/THU-MAIC/OpenMAIC/blob/main/packages/docs/content/docs/deployment.mdx
