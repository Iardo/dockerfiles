#!/bin/bash
# set -o allexport; source .env; set +o allexport

# check if the folders exist before volume binding
if ! [[ -d ./playground ]]; then
  mkdir -p ./playground
  echo directory created \"playground\"
fi

# force to use BUILDKIT instead of the old Docker build system
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker-compose build --progress=plain --no-cache
docker-compose -f docker-compose.yml up -d

# change user:group permissions
# only if you want to be able to modify files inside the container
#docker exec -i bin-php chown root:root /playground


