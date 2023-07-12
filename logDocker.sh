#!/bin/bash
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    sleep 1
    echo "Log worker $pid: new item"
    docker logs $pid -t --tail=50
done
