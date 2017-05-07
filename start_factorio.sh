#!/usr/bin/env bash

set -uxe

GAME_NAME="$1"
PORT="$2"

cd /home/game || exit
docker run -d --env FACTORIO_SERVER_NAME=$GAME_NAME -v $PWD/$GAME_NAME/saves:/opt/factorio/saves --env FACTORIO_VISIBILITY_PUBLIC=false -v $PWD/$GAME_NAME/mods:/opt/factorio/mods -p $PORT:34197/udp arma26/factorio:latest

cd /home/game/$GAME_NAME/mods || exit
zip --symlinks -r $GAME_NAME .
test -f  /home/game/packs/$GAME_NAME.zip && rm /home/game/packs/$GAME_NAME.zip
mv $GAME_NAME.zip /home/game/packs/

echo "server: fact1.noarc.net:$PORT modpack: http://fact1.noarc.net/$GAME_NAME.zip"
