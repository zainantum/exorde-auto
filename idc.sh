echo -e "\e[1m\e[32m1. Add auto restart to cronjob... \e[0m" && sleep 2
rm -rf checkDisk* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/checkDisk.sh && chmod +x *
pathFileRestart=$(realpath checkDisk.sh)
if ! crontab -l | grep -q 'checkDisk';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
