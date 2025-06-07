#!/bin/bash
set -e

# ==== Konfiguration ====
SERVER_HOST="136.243.82.116"
SERVER_MOD_DIR="/opt/minecraft/mods"
LOCAL_MOD_DIR="./modpack-server"

# ==== 1. Alte Mods löschen ====
echo "🧹 Lösche alte Mods auf dem Server..."
ssh root@${SERVER_HOST} "rm -f ${SERVER_MOD_DIR}/*.jar"

# ==== 2. Neue Mods hochladen ====
echo "⬆️  Lade neue Mods hoch..."
scp ${LOCAL_MOD_DIR}/*.jar root@${SERVER_HOST}:${SERVER_MOD_DIR}/

# ==== 3. Server neu starten ====
echo "🔄 Starte Server neu (alte Instanz beenden)..."
ssh root@${SERVER_HOST} <<'EOF'
su - minecraft <<'INNER'
cd /opt/minecraft

# Alte screen-Session beenden, falls vorhanden
if screen -list | grep -q mcserver; then
  echo "🛑 Beende alte screen-Session..."
  screen -S mcserver -X quit
  sleep 2
fi

# Eventuell hängende Java-Prozesse beenden
pkill -u minecraft -f java || true

# Neue Serverinstanz starten
echo "🚀 Starte neue Serverinstanz..."
screen -S mcserver -dm bash run.sh
INNER
EOF

echo "✅ Deployment abgeschlossen!"
