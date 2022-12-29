# add checker to crontab
*/5 * * * * /root/c1.sh 2>&1 | logger -t mycmd

# check log
journalctl -u cron.service

# download
wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh
