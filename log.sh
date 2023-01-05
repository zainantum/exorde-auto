#!/bin/bash
source $HOME/.bash_profile
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    truncate -s 0 log.txt
    sleep 2
    screen -X -S $name hardcopy log.txt
    tail -n20 log.txt
done
