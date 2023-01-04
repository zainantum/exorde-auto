#!/bin/bash
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    #echo $pid;
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    echo "Restart worker $name";
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
    screen -r $name -X stuff $'\003'
done

