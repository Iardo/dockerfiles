#!/bin/bash
set -e
set -o pipefail

docker-compose stop
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' planka-database)
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' planka-web)
docker-compose down -v
