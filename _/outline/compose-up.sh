#!/bin/bash

if ! [ -f .env ]; then
  cp .env.sample .env
fi

# docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}'
docker-compose up -d
# docker compose run --rm outline yarn db:create --env=production-ssl-disabled
docker compose run --rm outline yarn db:migrate --env=production-ssl-disabled
