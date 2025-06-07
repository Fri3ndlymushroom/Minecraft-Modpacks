rm -rf build-client build-server
mkdir build-client build-server

cp source-mods/shared/*.jar build-client/
cp source-mods/client/*.jar build-client/

cp source-mods/shared/*.jar build-server/
cp source-mods/server/*.jar build-server/