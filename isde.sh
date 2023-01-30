rm -rf sde.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/sde.sh && chmod +x sde.sh
echo -e "\e[1m\e[32m1. Add auto restart to cronjob... \e[0m" && sleep 2
pathFileRestart=$(realpath sde.sh)
if ! crontab -l | grep -q 'sde.sh';
then
    echo "Adding auto restart script to cronjob"
    crontab -l > mycron
    echo "*/30 * * * * $pathFileRestart" >> mycron
    crontab mycron
    rm mycron
fi
echo '=============== DONE ==================='
