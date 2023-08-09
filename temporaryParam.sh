clear
echo 'export mainAddress='$1 >> $HOME/.bash_profile
echo 'export maxWorker='$2 >> $HOME/.bash_profile

if [ $4 == "y" ]; then
	swapoff -a
	fallocate -l $6 /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	sudo cp /etc/fstab /etc/fstab.bak
	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
 	sysctl vm.swappiness=5
fi

if [ $3 == "y" ]; then
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

for (( i=1; i<=$2; i++ ))
do
   name="exorde"$i
   if [ $5 == "c" ]; then
        docker run -d --cpus="2" --memory="8g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $1
   elif [ $5 == "d" ]; then
        docker run -d --cpus="4" --memory="16g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $1
   elif [ $5 == "e" ]; then
        docker run -d --cpus="2" --memory="16g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $1
   else
        docker run -d --cpus="2" --memory="8g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $1
   fi
   sleep 1
done

docker run -d --restart unless-stopped --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower exorde1 -i 1800 --cleanup

rm -rf checkDisk* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/checkDisk.sh && chmod +x *
pathFileRestart=$(realpath checkDisk.sh)
if ! crontab -l | grep -q 'checkDisk';
then
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
