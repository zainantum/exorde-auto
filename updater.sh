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
        #/usr/bin/screen -SX $pid quit;
	echo $name;
	if [[ "$name" == "exorde1" ]]
	then
		screen -r $name -X stuff 'cd exorde1 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde2" ]]
	then
		screen -r $name -X stuff 'cd exorde2 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde3" ]]
	then
		screen -r $name -X stuff 'cd exorde3 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde4" ]]
	then
		screen -r $name -X stuff 'cd exorde4 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde5" ]]
	then
		screen -r $name -X stuff 'cd exorde5 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde6" ]]
	then
		screen -r $name -X stuff 'cd exorde6 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde7" ]]
	then
		screen -r $name -X stuff 'cd exorde7 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde8" ]]
	then
		screen -r $name -X stuff 'cd exorde8 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde9" ]]
	then
		screen -r $name -X stuff 'cd exorde9 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	elif [[ "$name" == "exorde10" ]]
	then
		screen -r $name -X stuff 'cd exorde10 && conda activate exorde-env && python Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3'`echo -ne '\015'`
	fi
	
    fi
done
