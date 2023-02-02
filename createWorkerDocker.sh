#!/bin/bash

read -p "Enter address for workers: " mainAddress
read -p "Enter log of worker do you want: " maxLog
read -p "Enter minimum worker do you want: " minWorker
read -p "Enter maximum worker do you want: " maxWorker

sleep 3
for (( i=$minWorker; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "Create container $name"
   docker run -d --restart unless-stopped --pull always --name $name --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m $mainAddress -l $maxLog
   sleep 1
done
