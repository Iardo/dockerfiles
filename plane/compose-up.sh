#!/bin/bash

# Export for tr error in mac
export LC_ALL=C
export LC_CTYPE=C

if ! [ -d source ]; then
  git clone https://github.com/makeplane/plane.git
  mv plane source
fi

if ! [ -f .env ]; then
  cp .env.example ./source/.env
fi
if ! [ -f ./source/admin/.env ]; then
  cp .env.example.admin ./source/admin/.env
fi
if ! [ -f ./source/apiserver/.env ]; then
  cp .env.example.apiserver ./source/apiserver/.env
fi
if ! [ -f ./source/space/.env ]; then
  cp .env.example.space ./source/space/.env
fi
if ! [ -f ./source/web/.env ]; then
  cp .env.example.web ./source/web/.env
fi

# Generate the SECRET_KEY that will be used by django
echo "SECRET_KEY=\"$(tr -dc 'a-z0-9' < /dev/urandom | head -c50)\""  >> ./source/apiserver/.env

docker-compose up -d
