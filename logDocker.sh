#!/bin/bash
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    echo "Log worker $pid"
    docker logs $pid -t --tail=50
    sleep 1
done
