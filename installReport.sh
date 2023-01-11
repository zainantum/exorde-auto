source $HOME/.bash_profile
clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde
echo -e '\e[35mTelegram :\e[35m' @imrnmln
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo -e '\e[35mDiscord :\e[35m' @imrnmln#7847
echo "===================================================================================="
sleep 2

if [ ! $chatid ]; then
	read -p "Enter your Chat ID: " chatid
	echo 'export chatid='$chatid >> $HOME/.bash_profile
fi

source $HOME/.bash_profile

echo '================================================='
echo -e "Your Chat ID: \e[1m\e[32m$chatid\e[0m"
echo '================================================='
sleep 2
echo -e "\e[1m\e[32m1. Downloading auto send log... \e[0m" && sleep 2

rm -rf sendLog*
rm -rf sendReport*

wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sendReport.py && chmod 777 sendReport.py && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sendLog.sh && chmod 777 sendLog.sh

sleep 2
pathNow=$(realpath $(dirname $0))
echo pathNow
sed -i -e "s|^sendReport.py|${pathNow}/sendReport.py|" sendLog.sh
pathFileRestart=$(realpath sendLog.sh)
if ! crontab -l | grep -q pathFileRestart;
then
    echo "Add script to cronjob"
    crontab -l > mycron
    echo "0 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi

echo -e "\e[1m\e[32m2. Successfully ... \e[0m" && sleep 2
