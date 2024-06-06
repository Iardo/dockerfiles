#!/bin/bash
set -e
set -o pipefail

if ! [ -f .env ]; then
  cp .env.example .env
fi

chmod -R 755 ./*
docker compose pull
docker-compose up -d
