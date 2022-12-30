# add checker to crontab
``` */1 * * * * /root/c1.sh 2>&1 | logger -t mycmd ```
``` */5 * * * * /root/stuck.sh 2>&1 | logger -t mycmd ```
# check log
``` journalctl -u cron.service ```

# download checker
``` wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh ```

# download stuck
``` wget https://raw.githubusercontent.com/zainantum/checker/main/stuck.sh && chmod 777 stuck.sh ```

# download updater
``` wget https://raw.githubusercontent.com/zainantum/checker/main/updater.sh && chmod 777 updater.sh ```

