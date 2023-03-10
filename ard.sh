clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde Docker
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

read -p "Enter log of worker do you want: " maxLog
echo 'export maxLog='$maxLog >> $HOME/.bash_profile

read -p "Install docker? y or n: " dockerInstall
echo 'export dockerInstall='$dockerInstall >> $HOME/.bash_profile

if [ ! $makeSwap ]; then
        read -p "Create swap? y or n: " makeSwap
        echo 'export makeSwap='$makeSwap >> $HOME/.bash_profile
fi

if [ $makeSwap == "y" ]; then
        read -p "Enter swap do you want with G(exp: 4G): " maxSwap
        echo 'export maxSwap='$maxSwap >> $HOME/.bash_profile
fi

source $HOME/.bash_profile
echo -e "\e[1m\e[32mYour Detail\e[0m"
echo '================================================='
echo -e "Your Main Address: \e[1m\e[32m$mainAddress\e[0m"
echo -e "Worker Log: \e[1m\e[32m$maxLog\e[0m"
echo -e "Install Docker: \e[1m\e[32m$dockerInstall\e[0m"
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

if [ $dockerInstall == "y" ]; then
	echo -e "\e[1m\e[32m1a. Installing Docker... \e[0m" && sleep 2
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  sleep 1
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sleep 1
  sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
  sleep 1
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y
  sleep 1
  sudo usermod -aG docker $USER
  sleep 1
  docker version
fi

echo -e "\e[1m\e[32m2. Cloning exorde container... \e[0m" && sleep 2
for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   echo "copy container $name"
   docker run -d --restart unless-stopped --pull always --name $name --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m $mainAddress -l $maxLog
   sleep 1
done

echo -e "\e[1m\e[32m3. Downloading auto restart and report... \e[0m" && sleep 2
wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/installReportDocker.sh && chmod 777 installReportDocker.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sendLogDocker.sh && chmod 777 sendLogDocker.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sendReport.py && chmod 777 sendReport.py && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/stuckDocker.sh && chmod 777 stuckDocker.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/updaterDocker.sh && chmod 777 updaterDocker.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/logDocker.sh && chmod 777 logDocker.sh

echo -e "\e[1m\e[32m4. Add auto restart to cronjob... \e[0m" && sleep 2
pathFileRestart=$(realpath stuckDocker.sh)
if ! crontab -l | grep -q 'stuckDocker';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/5 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
