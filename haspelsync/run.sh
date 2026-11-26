#!/bin/sh
# ------------------------------------------
# Run script for HaspelSync
# Persistent storage for HaspelSync 1.4.0+
# ------------------------------------------

BASE_DIR="/config"
PRINTERS_DIR="$BASE_DIR/app/printers"
LOGS_DIR="$BASE_DIR/app/logs"

echo "[INFO] Checking/creating directories..."

mkdir -p "$PRINTERS_DIR" "$LOGS_DIR"

# Use persistent storage directly.
# HaspelSync supports DATA_DIR and LOG_DIR natively.
export DATA_DIR="$PRINTERS_DIR"
export LOG_DIR="$LOGS_DIR"

echo "[INFO] DATA_DIR=$DATA_DIR"
echo "[INFO] LOG_DIR=$LOG_DIR"

# Start NodeJS application
echo "[INFO] Starting HaspelSync (entrypoint.js)..."
exec node /app/entrypoint.js
