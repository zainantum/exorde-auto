#!/bin/bash
pidList=$(docker ps -a -qf name="^exor" --filter status=exited --format "{{.Names}}")
for pid in ${pidList[@]};
do
  echo "Worker $pid stuck. Restarting worker";
  docker start $pid
done
