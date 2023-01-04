#!/bin/bash
rm -rf exorde*
rm -rf c1.sh
rm -rf stuck.sh
rm -rf copyFile.sh
rm -rf createScreen.sh
wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/stuck.sh && chmod 777 stuck.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/updater.sh && chmod 777 updater.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/createScreen.sh && chmod 777 createScreen.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/swap.sh && chmod 777 swap.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/copyFile.sh && chmod 777 copyFile.sh
wget https://github.com/exorde-labs/ExordeModuleCLI/archive/refs/heads/main.zip \
--output-document=ExordeModuleCLI.zip \
&& unzip ExordeModuleCLI.zip \
&& rm ExordeModuleCLI.zip \
&& mv ExordeModuleCLI-main exorde
array=( "exorde1" "exorde2" "exorde3" "exorde4" "exorde5" "exorde6" "exorde7" "exorde8" "exorde9" "exorde10" )
for name in "${array[@]}"
do
        echo "copy folder to $name"
        cp -r exorde $name
        sleep 1
done
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