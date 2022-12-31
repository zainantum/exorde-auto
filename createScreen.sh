#!/bin/bash
array=( "exorde1" "exorde2" "exorde3" "exorde4" "exorde5" "exorde6" "exorde7" "exorde8" "exorde9" "exorde10" >
for name in "${array[@]}"
do
        echo "create screen $name"
        screen -dm $name
        sleep 1
        screen -r $name -X stuff 'cd '${name}' && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
done

