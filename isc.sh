rm -rf stuck.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/stuck.sh && chmod +x stuck.sh
rm -rf c1.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/c1.sh && chmod +x c1.sh
echo -e "\e[1m\e[32m4. Add auto restart to cronjob... \e[0m" && sleep 2
pathFileRestart=$(realpath c1.sh)
if ! crontab -l | grep -q 'c1.sh';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/1 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
sleep 5
pathFileRestart=$(realpath stuck.sh)
if ! crontab -l | grep -q 'stuck.sh';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/15 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
