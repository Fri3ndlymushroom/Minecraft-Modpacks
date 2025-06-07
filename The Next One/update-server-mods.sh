#!/bin/bash

# ==== Konfiguration ====
SERVER_USER="minecraft"
SERVER_HOST="136.243.82.116"
SERVER_MOD_DIR="/opt/minecraft/mods"
LOCAL_MOD_DIR="./build-server"
START_CMD="cd /opt/minecraft && screen -S mcserver -dm java -Xmx8G -Xms4G -jar neoforge-*.jar nogui"

# ==== 1. Alte Mods auf Server löschen ====
echo "🧹 Lösche alte Mods auf dem Server..."
ssh ${SERVER_USER}@${SERVER_HOST} "rm -f ${SERVER_MOD_DIR}/*.jar"

# ==== 2. Neue Mods hochladen ====
echo "⬆️  Lade neue Mods hoch..."
scp ${LOCAL_MOD_DIR}/*.jar ${SERVER_USER}@${SERVER_HOST}:${SERVER_MOD_DIR}/

# ==== 3. Server neu starten ====
echo "🔄 Starte Server neu (in screen)..."
ssh ${SERVER_USER}@${SERVER_HOST} "${START_CMD}"

echo "✅ Deployment abgeschlossen!"