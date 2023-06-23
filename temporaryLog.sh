clear
echo -e "\e[35m"
echo "====================================================================================" 

echo -e '\e[35mNode :\e[35m' Exorde
echo -e '\e[35mTelegram :\e[35m' @imrnmln
echo -e '\e[35mTwitter :\e[35m' @zainantum
echo -e '\e[35mDiscord :\e[35m' @imrnmln#7847
echo "===================================================================================="
sleep 2

pathnow=$(pwd)
echo $pathnow

echo -e "\e[1m\e[32m7. Add auto logging to cron job... \e[0m" && sleep 2
rm -rf workerLog* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/workerLog.py && chmod +x *
if ! crontab -l | grep -q 'workerLog';
then
    echo "Add script to cronjob"
    crontab -l > mycron
    echo "*/30 * * * * python3 $pathnow/workerLog.py $worker `hostname` $address" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
