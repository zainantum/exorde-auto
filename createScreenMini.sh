#!/bin/bash
if [ ! $mainAddress ]; then
	read -p "Enter address for workers: " mainAddress
	echo 'export mainAddress='$mainAddress >> $HOME/.bash_profile
fi

read -p "Enter minimum worker do you want: " minWorker
read -p "Enter maximum worker do you want: " maxWorker


for (( i=$minWorker; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "create screen $name"
   cp -r exorde $name
   screen -dm $name
   sleep 2
   screen -r $name -X stuff 'cd '${name}' && source ~/miniconda3/etc/profile.d/conda.sh && conda activate exorde-env && python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
done
