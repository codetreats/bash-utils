#!/bin/bash
set -e

remove_container() {
    NAME=$1
    # remove old container
    if [[ $(docker ps -a -q --filter "name=$NAME"  | wc -l) -gt 0 ]]
    then
        echo "Remove $NAME"
        docker rm -f $NAME
    else
        echo "Nothing removed -> $NAME doesn't exist"
    fi
}

prune_images() {
    docker image prune -f
}

build_and_up() {
    TAG=$1
    FILE=$2
    cd container
    docker build -t $TAG .
    cd ..
    if [[ "$FILE" == "" ]]
    then
        docker-compose up --detach
    else
        docker-compose -f $FILE up --detach
    fi
}

pipeline_hostname() {
    echo $HOST_HOSTNAME | cut -d "." -f1
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