#!/bin/bash

cp .env.sample .env
docker-compose up -d
docker compose run --rm outline yarn db:create --env=production-ssl-disabled
docker compose run --rm outline yarn db:migrate --env=production-ssl-disabled
