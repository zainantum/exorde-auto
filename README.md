# 1. Exorde Testnet using python and conda
# if using new vps just run autoRun.sh. this script include auto install python, conda and any library. Us
1. run autoRun.sh
```wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && ./autoRun.sh```
2. after script autoRun.sh complete you can check your worker with ```screen -ls```
3. to see every worker log, you can use ``` ./log.sh ``` command. it will display log in all worker.
4. cronjob will restart your worker automatically if your worker not running or stuck. you can check with ``` crontab -e ``` command to make sure ```c1.sh``` and ```stuck.sh``` is setting up
5. if you want to update all worker:
- kill all exorde screen, exclude other project. if you're only run exorde screen you can use ```pkill screen``` command
- run ```./updater.sh```
# now you can send a screen log report to your telegram
- search ```@report_exorde_bot``` and click start. after that check your chat ID in ```https://api.telegram.org/bot5717312084:AAFYl4qrYosNPojHPy6MWZb8W16ab_fR0VI/getUpdates``` copy your chat ID and run installReport.sh.
- download and run the script ```wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/installReport.sh && chmod 777 installReport.sh && ./installReport.sh``` and paste your chat id. this script will send you worker log every hours.
# if you have an error like "strtonum never defined"
- download c1_alt.sh, stuck_alt.sh and log_alt.sh. Make sure you're using this file in cronjob for auto restart
# if already run worker
download c1.sh, stuck.sh and updater.sh from this repo. add c1.sh and stuck.sh to cronjob. only run updater.sh if you want to restart every worker. dont forget to change my address with your address

# 2. Exorde Testnet using docker
1. run autoRunDocker.sh
```wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/autoRunDocker.sh && chmod 777 autoRunDocker.sh && ./autoRunDocker.sh```
2. after script autoRun.sh complete you can check your worker with ```docker ps```
3. to see every worker log, you can use ``` ./logDocker.sh ``` command. it will display log in all worker.
4. cronjob will restart your worker automatically if your worker not running or stuck. you can check with ``` crontab -e ``` command to make sure ```stuckDocker.sh``` is setting up
5. if you want to update all worker:
- run ```./updaterDocker.sh``` it will delete are existing container and reinstalling container.
# now you can send a docker log report to your telegram
- search ```@report_exorde_bot``` and click start. after that check your chat ID in ```https://api.telegram.org/bot5717312084:AAFYl4qrYosNPojHPy6MWZb8W16ab_fR0VI/getUpdates``` copy your chat ID and run installReportDocker.sh.
- download and run the script ```rm -rf installReportDocker* && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/installReportDocker.sh && chmod 777 installReportDocker.sh && ./installReportDocker.sh``` and paste your chat id. this script will send you worker log every hours.

# additional
- install pstree
```apt-get install psmisc```

# add new user to vps
- download and run ```rm -rf addUser.sh && wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/addUser.sh && chmod 777 addUser.sh && ./addUser.sh```
- if you are using google cloud. access your terminal using this https://prnt.sc/4GUMySlIIGhh after that you can run above script

# update file on all vps at once
- you can run this script in local computer or vps only because this script will update every script in all ip vps list
- download ```wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/listIp.txt``` or create listIp.txt
- edit listIp.txt and input your all vps ip, username and password with this format ipvps;username;password;  enter for new vps
- ```pip install paramiko```
- download and run ```wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/exordeUpdaterScript.py && chmod 777 exordeUpdaterScript.py```
- run ```python3 exordeUpdaterScript.py``` then input file name to update
