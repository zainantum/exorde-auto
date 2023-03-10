#!/bin/bash
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
  if docker logs $pid -t --tail=1 | grep "Auto-Faucet critical Failure" 
  then 
      echo "Worker $pid stuck. Restarting worker";
      docker restart $pid
  fi
done
