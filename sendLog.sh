#!/bin/bash
source $HOME/.bash_profile
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    truncate -s 0 pathreplace/log.txt
    sleep 1
    echo "Log worker $name";
    screen -X -S $name hardcopy pathreplace/log.txt
    sleep 2
    tail -n7 pathreplace/log.txt > pathreplace/log1.txt
    python3 pathreplace/sendReport.py $name `hostname -s` $chatid
    sleep 2
done

