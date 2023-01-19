pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
  if docker logs $pid -t --tail=25 | grep "ERROR" || docker logs $pid -t --tail=25 | grep "Init Version Check";
  then 
      echo "Worker $pid stuck. Restarting worker";
      docker stop $pid
      sleep 5
      docker start $pid
  fi
done
