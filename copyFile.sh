#!/bin/bash
array=( "exorde1" "exorde2" "exorde3" "exorde4" "exorde5" "exorde6" "exorde7" "exorde8" "exorde9" "exorde10" )
for name in "${array[@]}"
do
        echo "copy folder to $name"
        cp -r exorde $name
        sleep 1
done
