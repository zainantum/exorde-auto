rm -rf exorde*
rm -rf ExordeModule*
rm -rf c1.sh*
rm -rf stuck.sh*
rm -rf copyFile.sh*
rm -rf createScreen.sh*
rm -rf log.sh*
rm -rf swap.sh.*
rm -rf updater.sh.*
wget https://raw.githubusercontent.com/zainantum/checker/main/log.sh && chmod 777 log.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/stuck.sh && chmod 777 stuck.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/createScreen.sh && chmod 777 createScreen.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/swap.sh && chmod 777 swap.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/copyFile.sh && chmod 777 copyFile.sh

source $HOME/.bash_profile

wget https://github.com/exorde-labs/ExordeModuleCLI/archive/refs/heads/main.zip \
--output-document=ExordeModuleCLI.zip \
&& unzip ExordeModuleCLI.zip \
&& rm ExordeModuleCLI.zip \
&& mv ExordeModuleCLI-main exordeparam

for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "copy folder to $name"
   cp -r exordeparam $name
   sleep 1
done

for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "create screen $name"
   screen -dm $name
   sleep 2
   screen -r $name -X stuff 'cd '${name}' && source ~/anaconda3/etc/profile.d/conda.sh && conda activate exorde-env && python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
done
