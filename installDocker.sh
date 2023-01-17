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
