#!/bin/bash
set -e

remove_container() {
    NAME=$1
    # remove old container
    if [[ $(docker ps -q --filter "name=$NAME"  | wc -l) -gt 0 ]]
    then
        echo "Remove $NAME"
        docker rm -f $NAME
    fi
}

prune_images() {
    docker image prune -f
}

build_and_up() {
    TAG=$1
    cd container
    docker build -t $TAG .
    cd ..
    docker-compose up --detach
}

assert_var() {
     MSG=$1
     VAR=$2

     if [[ $VAR == "" ]]
     then
          echo $MSG
          exit 1
     fi
}