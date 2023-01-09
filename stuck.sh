#!/bin/bash
source $HOME/.bash_profile
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    truncate -s 0 log.txt
    sleep 5
    screen -X -S $name hardcopy log.txt
    if tail -n5 log.txt | grep 'Safety Sleep' || tail -n8 log.txt | grep '[Init] Current Config' || tail -n5 log.txt | grep 'Init Worker Master' || tail -n5 log.txt | grep 'Init Version Check' || tail -n5 log.txt | grep 'Claiming Master' || tail -n5 log.txt | grep 'stakeChecking' || tail -n5 log.txt | grep 'Could not read ConfigRegistry' || tail -n5 log.txt | grep 'Network seems to have stopped block production'   
    then
        echo "Restart worker $name. Worker Stuck";
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        sleep 15
        screen -r $name -X stuff 'python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
    elif (tail -n45 log.txt | grep 'No new work' | wc -l) > "5" || tail -n5 log.txt | grep 'python: not found' || tail -n5 log.txt | grep 'sub routine initialized' || tail -n20 log.txt | grep 'Initialization error Something went' || tail -n20 log.txt | grep 'Read timed out'
    then
        echo "Worker stuck too long. Re-install worker"
        kill -9 $pid
        sleep 5
        echo "Close $name screen done"
        screen -dm $name
        sleep 2
        screen -r $name -X stuff 'cd '${name}' && source ~/anaconda3/etc/profile.d/conda.sh && conda activate exorde-env && python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
    elif ! pstree $pid | grep python
    then 
        screen -r $name -X stuff 'python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
    else
        echo "Worker $name running perfectly";
    fi
    
        
done
