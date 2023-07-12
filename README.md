# Exorde Testnet using docker
1. run autoRunDocker.sh
```wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/autoRunDocker.sh && chmod 777 autoRunDocker.sh && ./autoRunDocker.sh```
2. after script autoRunDocker.sh complete you can check your worker with ```docker ps```
3. auto update docker image using watchtower.
4. auto re-create container if your disk space to low (under 300MB)

# add new user to vps
- download and run ```rm -rf addUser.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/addUser.sh && chmod 777 addUser.sh && ./addUser.sh```
- if you are using google cloud. access your terminal using this https://prnt.sc/4GUMySlIIGhh after that you can run above script
