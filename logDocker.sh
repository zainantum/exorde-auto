#!/bin/bash
source $HOME/.bash_profile
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    truncate -s 0 log.txt
    docker logs -f $pid -t --tail=25 >> log.txt
    sleep 1
    echo "Log worker $pid"
    tail -n7 log.txt
    sleep 2
done
