#!/bin/bash
# set -o allexport; source .env; set +o allexport

args="$1"
if [[ -f $args ]]; then
    docker exec -i bin-python python < $args
fi
    docker exec -i bin-python python -e $args
    

