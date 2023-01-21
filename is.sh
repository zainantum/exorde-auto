rm -rf stuck1.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/stuck1.sh && chmod +x stuck1.sh
echo -e "\e[1m\e[32m4. Add auto restart to cronjob... \e[0m" && sleep 2
pathFileRestart=$(realpath stuck1.sh)
if ! crontab -l | grep -q 'stuck1.sh';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/10 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
