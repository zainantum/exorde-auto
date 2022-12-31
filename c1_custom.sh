#!/bin/bash
array=( "exorde1" "exorde2" "exorde3" "exorde4" "exorde5" "exorde6" "exorde7" "exorde8" "exorde9" "exorde10" )
for name in "${array[@]}"
do
        id = $(screen -dm -S $name & echo $!)
        pid = tail -n1 $id
        echo "create $id screen $pid $name"
        sleep 3
done
