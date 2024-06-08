#!/bin/bash
set -e
set -o pipefail

docker-compose stop
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' linkwarden-database)
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' linkwarden-web)
docker-compose down -v
