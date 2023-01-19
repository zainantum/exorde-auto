wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sd.sh && chmod +x sd.sh
echo -e "\e[1m\e[32m4. Add auto restart to cronjob... \e[0m" && sleep 2
pathFileRestart=$(realpath sd.sh)
if ! crontab -l | grep -q 'sd.sh';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
