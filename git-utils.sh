#!/bin/bash
set -e

list_uncommitted_repos() {    
    BASEDIR=$(pwd)
    #for DIR in $@ ; do
    #    cd $BASEDIR
    #    cd $DIR
    #    for REPO in 
    #done
    for REPO in $(find . -type d -name ".git") ; do
        REPONAME=${REPO::-4}
        cd $BASEDIR
        cd $REPONAME
        STATUS=$(git status | grep "nothing to commit, working tree clean" | wc -l)

        if [[ $STATUS -eq 1 ]] ; then
            echo "$REPONAME: OK"
        else 
            echo "$REPONAME: NEEDS A COMMIT"
        fi
    done
}

#list_uncommitted_repos $@