clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde Send Log Docker
echo -e '\e[35mTelegram :\e[35m' @imrnmln
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo -e '\e[35mDiscord :\e[35m' @imrnmln#7847
echo "===================================================================================="
sleep 2

source $HOME/.bash_profile

echo '================================================='
echo -e "Your Chat ID: \e[1m\e[32m$chatid\e[0m"
echo '================================================='
sleep 2
echo -e "\e[1m\e[32m1. Downloading auto send log... \e[0m" && sleep 2
rm -rf sendLogDocker.sh
rm -rf sendReport.sh

wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sendReport.py && chmod 777 sendReport.py && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sendLogDocker.sh && chmod 777 sendLogDocker.sh
sleep 2
pathFileRestart=$(realpath sendLogDocker.sh)

if ! crontab -l | grep -q 'sendLogDocker';
then
    echo "Add script to cronjob"
    crontab -l > mycron
    echo "0 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi

echo -e "\e[1m\e[32m2. Successfully ... \e[0m" && sleep 2
