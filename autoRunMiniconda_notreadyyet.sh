clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde
echo -e '\e[35mTelegram :\e[35m' @imrnmln
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo -e '\e[35mDiscord :\e[35m' @imrnmln#7847
echo "===================================================================================="
sleep 2

if [ ! $mainAddress ]; then
	read -p "Enter address for workers: " mainAddress
	echo 'export mainAddress='$mainAddress >> $HOME/.bash_profile
fi

read -p "Enter maximum worker do you want: " maxWorker
echo 'export maxWorker='$maxWorker >> $HOME/.bash_profile

if [ ! $makeSwap ]; then
        read -p "Create swap? y or n " makeSwap
        echo 'export makeSwap='$makeSwap >> $HOME/.bash_profile
fi

if [ $makeSwap == "y" ]; then
        read -p "Enter swap do you want with G(exp: 4G): " maxSwap
        echo 'export maxSwap='$maxSwap >> $HOME/.bash_profile
fi

source $HOME/.bash_profile

echo '================================================='
echo -e "Your Main Address: \e[1m\e[32m$mainAddress\e[0m"
echo -e "Maximum Worker: \e[1m\e[32m$maxWorker\e[0m"
echo -e "Swap: \e[1m\e[32m$maxSwap\e[0m"
echo '================================================='
sleep 2

if [ $makeSwap == "y" ]; then
	echo -e "\e[1m\e[32m1. Create swap... \e[0m" && sleep 2
	swapoff -a
	fallocate -l $maxSwap /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	sudo cp /etc/fstab /etc/fstab.bak
	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

echo -e "\e[1m\e[32m2. Updating packages... \e[0m" && sleep 2
sudo apt update && sudo apt install unzip -y

echo -e "\e[1m\e[32m3. Installing dependencies... \e[0m" && sleep 2
sudo apt install python3 python3-pip git screen -y && pip install --upgrade pip

curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh && chmod +x Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh -b -u

echo -e "\e[1m\e[32m4. Cloning Exorde file... \e[0m" && sleep 2
wget https://github.com/exorde-labs/ExordeModuleCLI/archive/refs/heads/main.zip \
--output-document=ExordeModuleCLI.zip \
&& unzip ExordeModuleCLI.zip \
&& rm ExordeModuleCLI.zip \
&& mv ExordeModuleCLI-main exorde

for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "copy folder to $name"
   cp -r exorde $name
   sleep 1
done


echo -e "\e[1m\e[32m5. Create conda exorde enviroment... \e[0m" && sleep 2
cd exorde
source ~/miniconda3/etc/profile.d/conda.sh
conda create --name exorde-env python=3.9 -y
conda activate exorde-env
yes | pip install -r requirements.txt
conda deactivate
cd ..
echo -e "\e[1m\e[32m6. Create screen... \e[0m" && sleep 2

for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "create screen $name"
   screen -dm $name
   sleep 2
   screen -r $name -X stuff 'cd '${name}' && source ~/anaconda3/etc/profile.d/conda.sh && conda activate exorde-env && python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
done


echo -e "\e[1m\e[32m7. Downloading auto restart... \e[0m" && sleep 2
wget https://raw.githubusercontent.com/zainantum/checker/main/log.sh && chmod 777 log.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/stuck.sh && chmod 777 stuck.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/updater.sh && chmod 777 updater.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/createScreen.sh && chmod 777 createScreen.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/swap.sh && chmod 777 swap.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/copyFile.sh && chmod 777 copyFile.sh

echo -e "\e[1m\e[32m8. Add auto restart to crontab... \e[0m" && sleep 2
pathFileRestart=$(realpath stuck.sh)
pathFileRestart1=$(realpath c1.sh)
if ! crontab -l | grep -q 'stuck';
then
    echo "Add script to cronjob"
    crontab -l > mycron
    echo "*/5 * * * * $pathFileRestart" >> mycron
    echo "*/1 * * * * $pathFileRestart1" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
rm -rf Anaconda3-2022.10-Linux-x86_64.sh
echo -e "\e[1m\e[32m If auto restart doesnt exists in crontab, please report issue and add manually for now... \e[0m" && sleep 1
