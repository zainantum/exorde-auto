#!/bin/bash

source $HOME/.bash_profile

echo "Stop and delete all exists docker container"
docker stop $(docker ps -qf "name=^exorde")
docker rm $(docker ps -a -qf "name=^exorde")

echo "Re-create docker container"

for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "Create container $name"
   docker run -d --restart unless-stopped --pull always --name $name exordelabs/exorde-cli -m $mainAddress -l $maxLog
   sleep 1
done
