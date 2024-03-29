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
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        sleep 15
        screen -r $name -X stuff 'python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
    else
        echo "Worker $name running perfectly";
    fi
    
        
done
