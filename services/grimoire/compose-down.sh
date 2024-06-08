#!/bin/bash
set -e
set -o pipefail

docker-compose stop
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' grimoire-pocketbase)
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' grimoire-web)
docker-compose down -v
