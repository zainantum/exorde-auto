#!/bin/bash
source $HOME/.bash_profile
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
    if docker logs $pid -t --tail=1 | grep "Auto-Faucet critical Failure" || docker logs $pid -t --tail=3 | grep 'Initialization error Something went' || docker logs $pid -t --tail=3 | grep 'Read timed out' || docker logs $pid -t --tail=3 | grep 'Safety Sleep' || docker logs $pid -t --tail=3 | grep 'Could not read ConfigRegistry' || docker logs $pid -t --tail=3 | grep 'Network seems to have stopped block production'   
    then
        echo "Worker $pid stuck. Restarting worker";
        docker stop $pid && docker start $pid
    else
        echo "Worker $pid running perfectly";
    fi
    
        
done
