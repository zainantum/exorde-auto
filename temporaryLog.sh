clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde
echo -e '\e[35mTelegram :\e[35m' @imrnmln
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo -e '\e[35mDiscord :\e[35m' @imrnmln#7847
echo "===================================================================================="
sleep 2

read -p "Enter your total worker in this vm: " worker
read -p "Enter your address for log: " address

pathnow=$(pwd)

echo -e "\e[1m\e[32m1. Add auto logging to cron job... \e[0m" && sleep 2
rm -rf workerLog* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/workerLog.py && chmod +x *
sed -i 's+pathreplace+'${pathnow}'+g' workerLog.py
ipserver=`dig +short myip.opendns.com @resolver1.opendns.com`
if ! crontab -l | grep -q 'workerLog';
then
    echo "Add script to cronjob"
    crontab -l > mycron
    echo "*/30 * * * * python3 $pathnow/workerLog.py $worker $ipserver $address 2>&1 | logger -t mycmd" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
