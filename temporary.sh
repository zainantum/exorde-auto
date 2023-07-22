clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde Docker
echo -e '\e[35mTelegram :\e[35m' @imrnmln
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo -e '\e[35mDiscord :\e[35m' @imrnmln#7847
echo "===================================================================================="
sleep 2

read -p "Enter address for workers: " mainAddress
echo 'export mainAddress='$mainAddress >> $HOME/.bash_profile
read -p "Enter maximum worker do you want: " maxWorker
echo 'export maxWorker='$maxWorker >> $HOME/.bash_profile
read -p "Install docker? y or n: " dockerInstall
read -p "Create swap? y or n " makeSwap
read -p "Use Twitter? y or n " useTwitter
if [ $makeSwap == "y" ]; then
        read -p "Enter swap do you want with G(exp: 4G): " maxSwap
fi

if [ $useTwitter == "y" ]; then
        read -p "Enter Twitter Username: " ust
	read -p "Enter Twitter Password: " pwt
        read -p "Enter Twitter Email: " mailt
fi

source $HOME/.bash_profile
echo -e "\e[1m\e[32mYour Detail\e[0m"
echo '================================================='
echo -e "Your Main Address: \e[1m\e[32m$mainAddress\e[0m"
echo -e "Install Docker: \e[1m\e[32m$dockerInstall\e[0m"
echo -e "Maximum Worker: \e[1m\e[32m$maxWorker\e[0m"
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
   if [ $useTwitter == "y" ]; then
   	docker run -d --cpus="2" --memory="8g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $mainAddress --twitter_username "$ust" --twitter_password "$pwt" --twitter_email "$mailt"
   elif [ $useTwitter == "c" ]; then
        docker run -d --cpus="2" --memory="8g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $mainAddress
   elif [ $useTwitter == "d" ]; then
        docker run -d --cpus="4" --memory="16g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $mainAddress
   else
        docker run -d --cpus="2" --memory="8g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $mainAddress
   fi
   sleep 1
done

echo -e "\e[1m\e[32m3. Add auto update to newest version... \e[0m" && sleep 2
docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower exorde1 -i 1800

echo -e "\e[1m\e[32m4. Add auto re-create container to cronjob... \e[0m" && sleep 2
rm -rf checkDisk* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/checkDisk.sh && chmod +x *
pathFileRestart=$(realpath checkDisk.sh)
if ! crontab -l | grep -q 'checkDisk';
then
    echo "Adding auto re-create container if space disk less than 300MB to cronjob"
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
