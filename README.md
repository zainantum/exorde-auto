# add checker to crontab
*/5 * * * * /root/c1.sh 2>&1 | logger -t mycmd
