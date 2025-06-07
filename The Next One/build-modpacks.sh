#!/bin/bash
set -e

echo "🧹 Ordner löschen..."
rm -rf modpack-client modpack-server

echo "📁 Ordner neu anlegen..."
mkdir modpack-client modpack-server

echo "📦 Kopiere shared → client..."
cp source-mods/shared/*.jar modpack-client/

echo "📦 Kopiere client..."
cp source-mods/client/*.jar modpack-client/

echo "📦 Kopiere shared → server..."
cp source-mods/shared/*.jar modpack-server/

echo "📦 Kopiere server..."
cp source-mods/server/*.jar modpack-server/

echo "✅ Fertig!"