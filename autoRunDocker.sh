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

read -p "Install docker? y or n: " dockerInstall
read -p "Use Twitter? y or n: " useTwitter
read -p "CPU Limit (2, 4, 8 etc): " limitCpu
read -p "RAM Limit (8g, 12g, 16g etc): " limitRam
read -p "choose resource twitter, reddit, youtube, 4chan etc. exp: twitter or twitter,reddit: " sourceUrl

source $HOME/.bash_profile
echo -e "\e[1m\e[32mYour Detail\e[0m"
echo '================================================='
echo -e "Your Main Address: \e[1m\e[32m$mainAddress\e[0m"
echo -e "Install Docker: \e[1m\e[32m$dockerInstall\e[0m"
echo -e "Use Twitter: \e[1m\e[32m$useTwitter\e[0m"
echo '================================================='
sleep 2

if [ $useTwitter == "y" ]; then
        read -p "Enter Twitter Username: " ust
	read -p "Enter Twitter Password: " pwt
        read -p "Enter Twitter Email: " mailt
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
	  wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/dockerscript.sh && chmod +x dockerscript.sh
fi

echo -e "\e[1m\e[32m2. Create worker Exorde1... \e[0m" && sleep 2
name="exorde1"
echo "copy container $name"
sed -i -e "s|replace_cpu*|$limitCpu|" dockerscript.sh
sed -i -e "s|replace_ram*|$limitRam|" dockerscript.sh
sed -i -e "s|replace_name*|$name|" dockerscript.sh
sed -i -e "s|replace_address*|$mainAddress|" dockerscript.sh
sed -i -e "s|replace_only*|$sourceUrl|" dockerscript.sh
if [ $useTwitter == "y" ]; then
	sed -i -e "s|replace_ustw*|$ust|" dockerscript.sh
	sed -i -e "s|replace_pwtw*|$pwt|" dockerscript.sh
	sed -i -e "s|replace_mailtw*|$mailt|" dockerscript.sh
fi
sleep 1
bash dockerscript.sh

echo -e "\e[1m\e[32m3. Add auto update to newest version... \e[0m" && sleep 2
docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower exorde1 -i 1800

echo '=============== DONE ==================='
