#!/bin/bash
# set -o allexport; source .env; set +o allexport

args="$1"
if [[ -f $args ]]; then
    docker exec -i bin-nodejs node < $args
fi
    docker exec -i bin-nodejs node -e $args
    

