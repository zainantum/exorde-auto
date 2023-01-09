#!/bin/bash
source $HOME/.bash_profile
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    truncate -s 0 log.txt
    docker logs $pid >> log.txt
    sleep 3
    if tail -n5 log.txt | grep 'Safety Sleep' || tail -n8 log.txt | grep '[Init] Current Config' || tail -n5 log.txt | grep 'Init Worker Master' || tail -n5 log.txt | grep 'Init Version Check' || tail -n5 log.txt | grep 'Claiming Master' || tail -n5 log.txt | grep 'stakeChecking' || tail -n5 log.txt | grep 'Could not read ConfigRegistry' || tail -n5 log.txt | grep 'Network seems to have stopped block production'   
    then
        echo "Worker $pid stuck. Restarting worker";
        docker stop $pid && docker start $pid
    elif tail -n5 log.txt | grep 'sub routine initialized' || tail -n20 log.txt | grep 'Initialization error Something went' || tail -n20 log.txt | grep 'Read timed out'
    then
        echo "There is something wrong with worker $pid. Re-installing worker";
        docker stop $pid && docker rm $pid
        docker run -d --restart unless-stopped --pull always --name $pid exordelabs/exorde-cli -m $mainAddress -l $maxLog
    elif ! pstree $pid | grep python
    then
        echo "Worker $pid stuck. Restarting worker";
        docker stop $pid && docker start $pid
    else
        echo "Worker $pid running perfectly";
    fi
    
        
done
