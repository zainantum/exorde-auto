#!/bin/bash
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    echo $pid;
    if pstree $pid | grep python
    then
        echo "NOT OK";
    else
        echo "NOT OK";
	name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
        #/usr/bin/screen -SX $pid quit;
	#rand=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 5 | head -n 1);
	#echo $rand;
	data="python /root/$name/Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3"
	echo $name;
	echo $data;
	#/usr/bin/screen -S $rand;
	#screen -d -S $name -m;
        #screen -dm $rand sh /root/script.sh;
	#screen -dmS $name python "Launcher.py -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 3";
	/usr/bin/screen -d -S $name -m -X stuff 'conda activate exorde-env'`echo -ne '\015'`
        #screen -d -S $rand -m;
        #screen -dm $rand sh -c "source ~/anaconda3/etc/profile.d/conda.sh";
        #screen -dm $rand -X bash "/root/script.sh; sleep(3); echo 'haiii'";
    fi
done
