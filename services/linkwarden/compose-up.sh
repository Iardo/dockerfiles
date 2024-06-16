#!/bin/bash
set -e
set -o pipefail

if ! [ -f .env ]; then
  cp .env.example .env

  secret=$(openssl rand -hex 32)
  sed -i "s/=secret/=$secret/" .env
fi

if ! [ -d source ]; then
  git clone https://github.com/linkwarden/linkwarden source
fi

chmod -R 755 ./*
docker-compose up -d
