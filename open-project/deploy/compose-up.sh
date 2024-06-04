#!/bin/bash

if ! [ -f .env ]; then
  cp .env.example .env
fi

docker-compose up -d
docker exec -i openproject-web chown -R app:app /var/openproject/assets
