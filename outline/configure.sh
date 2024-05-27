#!/bin/bash

docker-compose up -d
cp .env.sample .env
docker compose run --rm outline yarn db:create --env=production-ssl-disabled
