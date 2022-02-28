#!/bin/bash
# set -o allexport; source .env; set +o allexport

# pull the last version of the repository locally
if (-Not (Test-Path -Path outline)) {
  wget https://github.com/outline/outline/archive/refs/heads/main.zip
  unzip -a main.zip -o .
  rm -rf main.zip
  #\cp -r Dockerfile ./outline-main/Dockerfile
  #\cp -r package.json ./outline-main/package.json
  echo cloned outline repo
}

# force to use BUILDKIT instead of the old Docker build system
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker-compose build --progress=plain --no-cache
docker-compose -f docker-compose.yml up -d

