#!/bin/bash
source $HOME/.bash_profile
pidList=$(screen -ls | grep "exorde" | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    truncate -s 0 log.txt
    sleep 5
    screen -X -S $name hardcopy log.txt
    if tail -n100 log.txt | grep 'Not registered'
    then
        echo "Restart worker $name. Worker Stuck";
    else
        echo "Worker $name running perfectly";
    fi
    
        
done
