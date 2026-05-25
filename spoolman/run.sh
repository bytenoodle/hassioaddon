#!/usr/bin/env bash
set -e

echo "[INFO] Starting Spoolman add-on..."

CONFIG_DIR="/config"
SPOOLMAN_DIR_DATA="$CONFIG_DIR"
SPOOLMAN_DIR_BACKUPS="$CONFIG_DIR/backups"
SPOOLMAN_DIR_LOGS="$CONFIG_DIR/logs"
SPOOLMAN_DIR_CACHE="$CONFIG_DIR/cache"
OPTIONS_FILE="/data/options.json"

SPOOLMAN_DEBUG_MODE="false"
if [ -f "$OPTIONS_FILE" ]; then
    SPOOLMAN_DEBUG_MODE=$(grep -Po '"SPOOLMAN_DEBUG_MODE"\s*:\s*\K(true|false)' "$OPTIONS_FILE" || echo "false")
fi
export SPOOLMAN_DEBUG_MODE
echo "[INFO] Debug mode: ${SPOOLMAN_DEBUG_MODE}"

echo "[INFO] Ensuring data directories exist..."
mkdir -p "$SPOOLMAN_DIR_DATA" "$SPOOLMAN_DIR_BACKUPS" "$SPOOLMAN_DIR_LOGS" "$SPOOLMAN_DIR_CACHE"

echo "[INFO] Setting correct permissions on add-on directories..."
chown -R 1000:1000 "$CONFIG_DIR" || echo "[WARN] Could not change owner (possibly already correct)"
chmod -R 755 "$CONFIG_DIR" || echo "[WARN] Could not change permissions (possibly already correct)"

echo "[INFO] --- Timezone diagnostic ---"
echo "[INFO] Host-provided TZ value: ${TZ:-<not set>}"
if [ -n "${TZ}" ]; then
    echo "[INFO] Using Home Assistant system timezone: ${TZ}"
else
    export TZ="Europe/Stockholm"
    echo "[INFO] No TZ provided by HA, defaulting to: ${TZ}"
fi
echo "[INFO] Effective timezone in container: ${TZ}"
echo "[INFO] -------------------------------"

export SPOOLMAN_DIR_DATA
export SPOOLMAN_DIR_BACKUPS
export SPOOLMAN_DIR_LOGS
export SPOOLMAN_DIR_CACHE

# Detect HA ingress path
if [ -n "$SUPERVISOR_TOKEN" ]; then
    echo "[INFO] Querying Supervisor API for ingress URL..."
    INGRESS_URL=$(curl -s \
        -H "Authorization: Bearer $SUPERVISOR_TOKEN" \
        http://supervisor/addons/self/info \
        | python3 -c "import sys, json; d = json.load(sys.stdin); print(d.get('data', {}).get('ingress_url', ''))" 2>/dev/null || echo "")

    if [ -n "$INGRESS_URL" ]; then
        export SPOOLMAN_BASE_PATH="${INGRESS_URL%/}"
        echo "[INFO] SPOOLMAN_BASE_PATH set to: ${SPOOLMAN_BASE_PATH}"

        # Generate nginx config with the ingress path restored
        sed "s|__INGRESS_PATH__|${SPOOLMAN_BASE_PATH}|g" /nginx.conf.template > /etc/nginx/nginx.conf
        echo "[INFO] Starting nginx prefix-restorer on port 7912..."
        nginx -c /etc/nginx/nginx.conf
        echo "[INFO] nginx started."

        # Spoolman runs on internal port 7913; nginx fronts it on 7912
        export SPOOLMAN_PORT=7913
    else
        echo "[WARN] Could not determine ingress URL — running Spoolman directly on 7912"
    fi
fi

echo "[INFO] Launching Spoolman..."
if [ -x /entrypoint.sh ]; then
    exec /entrypoint.sh
elif [ -x /docker-entrypoint.sh ]; then
    exec /docker-entrypoint.sh
else
    echo "[INFO] Starting manually via Uvicorn..."
    exec uvicorn spoolman.main:app \
        --host 0.0.0.0 \
        --port "${SPOOLMAN_PORT:-7912}" \
        --workers 1 \
        --log-level info \
        --no-access-log
fi
