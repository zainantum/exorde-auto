#!/bin/bash
if [ ! $mainAddress ]; then
	read -p "Enter address for workers: " mainAddress
	echo 'export mainAddress='$mainAddress >> $HOME/.bash_profile
fi

if [ ! $maxWorker ]; then
        read -p "Enter maximum worker do you want: " maxWorker
        echo 'export maxWorker='$maxWorker >> $HOME/.bash_profile
fi

source $HOME/.bash_profile

for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "create screen $name"
   screen -dm $name
   sleep 2
   screen -r $name -X stuff 'cd '${name}' && source ~/anaconda3/etc/profile.d/conda.sh && conda activate exorde-env && python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
done
