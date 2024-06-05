#!/bin/bash

if ! [ -f .env ]; then
  cp ../deploy/.env.example .env
fi

chmod -R 755 ./*
docker-compose build
docker-compose up -d
