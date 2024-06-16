#!/bin/bash
set -e
set -o pipefail

docker-compose stop
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' azimutt-web)
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' azimutt-database)
docker-compose down -v
