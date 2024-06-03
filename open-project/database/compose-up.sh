#!/bin/bash

docker-compose -f ../deploy/docker-compose.yml -f docker-compose.yml build
docker-compose up -d

