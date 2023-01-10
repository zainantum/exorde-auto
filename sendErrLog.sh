#!/bin/bash
source $HOME/.bash_profile
pidList=$(screen -ls | grep "exorde" | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    truncate -s 0 logErr1.txt
    sleep 5
    screen -X -S $name hardcopy logErr1.txt
    if tail -n10 logErr1.txt | grep 'Initialization error Something went' || tail -n20 logErr1.txt | grep 'Read timed out' || tail -n5 logErr1.txt | grep 'Safety Sleep' || tail -n8 logErr1.txt | grep '[Init] Current Config' || tail -n5 logErr1.txt | grep 'Init Worker Master' || tail -n5 logErr1.txt | grep 'Init Version Check' || tail -n5 logErr1.txt | grep 'Claiming Master' || tail -n5 logErr1.txt | grep 'stakeChecking' || tail -n5 logErr1.txt | grep 'Could not read ConfigRegistry' || tail -n5 logErr1.txt | grep 'Network seems to have stopped block production'   
    then
        tail -n10 logErr1.txt > log1.txt
        python3 sendReport.py $name `hostname -s` $chatid
        sleep 2
    fi        
done
