echo -e "\e[1m\e[32m1. Add auto create worker to cronjob... \e[0m" && sleep 2
rm -rf checkDiskEx* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/checkDiskEx.sh && chmod +x *
pathFileRestart=$(realpath checkDiskEx.sh)
if ! crontab -l | grep -q 'checkDiskEx';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
