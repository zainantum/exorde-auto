#!/bin/bash
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    #echo $pid;
    screen -X -S $name hardcopy log.txt
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    echo "Restart worker $name";
    screen -r $name -X stuff $'\003'
    sleep 15
    screen -r $name -X stuff 'python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
done
