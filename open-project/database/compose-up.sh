#!/bin/bash

chmod -R 755 ./*
docker-compose build
docker-compose up -d
