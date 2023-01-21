rm -rf sd.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sd.sh && chmod +x sd.sh
rm -rf sd1.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sd1.sh && chmod +x sd1.sh
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
sleep 5
pathFileRestart=$(realpath sd1.sh)
if ! crontab -l | grep -q 'sd1.sh';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
