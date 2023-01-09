#!/bin/bash
source $HOME/.bash_profile
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    truncate -s 0 log2.txt
    docker logs $pid >> log2.txt
    tail -n7 log2.txt > log1.txt
    sleep 1
    python3 sendReport.py $pid `hostname -s` $chatid
done
