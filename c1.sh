#!/bin/bash
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    echo $pid;
    if pstree $pid | grep python
    then
        echo "OK";
    else
        echo "NOT OK";
	name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
	echo $name;
	echo $data;
    fi
done
