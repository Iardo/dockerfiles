#!/bin/bash
# set -o allexport; source .env; set +o allexport

# check if the folders exist before volume binding
if ! [[ -d ./binaries ]]; then
  mkdir -p ./binaries
  echo directory created \"binaries\"
fi
if ! [[ -d ./playground ]]; then
  mkdir -p ./playground
  echo directory created \"playground\"
fi

# force to use BUILDKIT instead of the old Docker build system
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker-compose build --progress=plain --no-cache
docker-compose -f docker-compose.yml up -d

# copy installed node versions inside the container on the bound folder to be able to see them outside the container
docker cp bin-nodejs:/usr/local/nvm/versions/node/. ./binaries

# change user:group permissions
# only if you want to be able to modify files inside the container
docker exec -i bin-python chown root:root /binaries
#docker exec -i bin-python chown root:root /playground


