#!/bin/bash
# set -o allexport; source .env; set +o allexport

# check if the folders exist before volume binding
if ! [[ -d ./web ]]; then
    mkdir -p ./web
    echo directory created \"web\"
fi

# force to use BUILDKIT instead of the old Docker build system
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker-compose build --progress=plain --no-cache
docker-compose -f docker-compose.yml up -d

# copy default index.html
if ! [[ -d ./web/html ]]; then
    mkdir -p ./web/html
    tar -xvzf ./default-html.tar.gz -C ./web/html
fi

# create static phpinfo.php
if ! [[ -d ./web/html/phpinfo ]]; then
    mkdir -p ./web/html/phpinfo
    {
        echo "<?php phpinfo();"
    } >>./www/html/phpinfo/index.php
fi
