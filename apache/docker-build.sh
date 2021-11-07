#!/bin/bash
# set -o allexport; source .env; set +o allexport

# check if the folders exist before volume binding
if ! [[ -d ./www ]]; then
  mkdir -p ./www
  echo directory created \"www\"
fi

# force to use BUILDKIT instead of the old Docker build system
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker-compose build --progress=plain --no-cache
docker-compose -f docker-compose.yml up -d


# create static phpinfo.php
if ! [[ -d ./www/phpinfo ]]; then
    mkdir -p ./www/phpinfo
  {
    echo "<?php phpinfo();"
  } >> ./www/phpinfo/index.php
fi

# create a default static file index.html
if ! [[ -f ./www/index.html ]]; then
  {
    echo "<html><body><h1>It works!</h1>"
    echo "<p>This is the default web page for this server.</p>"
    echo "<p>The web server software is running but no content has been added, yet.</p>"
    echo "</body></html>"
  } >> ./www/index.html
fi


