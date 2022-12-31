#!/bin/bash
array=( "exorde1" "exorde2" "exorde3" "exorde4" "exorde5" "exorde6" "exorde7" "exorde8" "exorde9" "exorde10" )
for name in "${array[@]}"
do
        tid=$(screen -dm -S $name & echo $!)
        if pstree $tid | grep python
    then
        echo "Worker $name is working";
    else
        echo "Worker $name is not working";
	      echo $name;
	      screen -r $name -X stuff 'python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
    fi
done
