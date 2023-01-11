#!/bin/bash
source $HOME/.bash_profile
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    truncate -s 0 pathreplace/log2.txt
    docker logs $pid >> pathreplace/log2.txt
    tail -n15 pathreplace/log2.txt > pathreplace/log1.txt
    sleep 1
    python3 pathreplace/sendReport.py $pid `hostname -s` $chatid
done
