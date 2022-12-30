#!/bin/bash
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    screen -X -S $name hardcopy log.txt
    mail -s $name emailbuatnyariuang@gmail.com < log.txt
done
