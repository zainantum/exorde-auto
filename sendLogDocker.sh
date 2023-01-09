#!/bin/bash
source $HOME/.bash_profile
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    truncate -s 0 log1.txt
    docker logs $pid >> log1.txt
    sleep 1
    python3 sendReport.py $pid `hostname -s` $chatid
done
