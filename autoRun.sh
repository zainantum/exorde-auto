clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde
echo -e '\e[35mTelegram :\e[35m' @znntm
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo "===================================================================================="
sleep 2
if [ ! $mainAddress ]; then
	read -p "Enter address for workers: " mainAddress
	echo 'export mainAddress='$mainAddress >> $HOME/.bash_profile
fi
source $HOME/.bash_profile

echo '================================================='
echo -e "Your Main Address: \e[1m\e[32m$mainAddress\e[0m"
echo '================================================='
sleep 2

echo -e "\e[1m\e[32m1. Create swap... \e[0m" && sleep 2
fallocate -l 38G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 2
sudo apt update && sudo apt install unzip -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 2
sudo apt install python3 python3-pip git screen -y && pip install --upgrade pip

wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh && bash Anaconda3-2022.10-Linux-x86_64.sh -b -u

echo -e "\e[1m\e[32m2. Cloning Exorde file... \e[0m" && sleep 2
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

echo -e "\e[1m\e[32m2. Create conda exorde enviroment... \e[0m" && sleep 2
cd exorde
source ~/anaconda3/etc/profile.d/conda.sh
conda create --name exorde-env python=3.9 -y
conda activate exorde-env
pip install -r requirements.txt -y
exit

echo -e "\e[1m\e[32m2. Create screen... \e[0m" && sleep 2

array=( "exorde1" "exorde2" "exorde3" "exorde4" "exorde5" "exorde6" "exorde7" "exorde8" "exorde9" "exorde10" )
for name in "${array[@]}"
do
        echo "create screen $name"
        screen -dm $name
        sleep 3
        screen -r $name -X stuff 'cd '${name}' && conda activate exorde-env && python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
done

echo -e "\e[1m\e[32m1. Downloading auto restart... \e[0m" && sleep 1
wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/stuck.sh && chmod 777 stuck.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/updater.sh && chmod 777 updater.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/createScreen.sh && chmod 777 createScreen.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/swap.sh && chmod 777 swap.sh && wget https://raw.githubusercontent.com/zainantum/checker/main/copyFile.sh && chmod 777 copyFile.sh

echo -e "\e[1m\e[32m1. Add auto restart to crontab... \e[0m" && sleep 1
pathFileRestart=$(realpath stuck.sh)
crontab -l | { cat; echo "*/1 * * * * $pathFileRestart/c1.sh"; } | crontab -
crontab -l | { cat; echo "*/5 * * * * $pathFileRestart/stuck.sh"; } | crontab -

echo '=============== DONE ==================='
echo -e "\e[1m\e[32m1. If auto restart doesnt exists in crontab, please report issue and add manually for now... \e[0m" && sleep 1

