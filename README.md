# this script only work for conda/python. its doesnt work for docker for now
# if using new vps just run autoRun.sh. this script include auto install python, conda and any library
1. run autoRun.sh
```wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && ./autoRun.sh```
2. after script autoRun.sh complete you can check your worker with ```screen -ls```
3. to see every worker log, you can use ``` ./log.sh ``` command. it will display log in all worker.
4. cronjob will restart your worker automatically if your worker not running or stuck. you can check with ``` crontab -e ``` command to make sure ```c1.sh``` and ```stuck.sh``` is setting up
5. if you want to update all worker:
- kill all exorde screen, exclude other project. if you're only run exorde screen you can use ```pkill screen``` command
- run ```./updater.sh```
# now you can send a log report to your telegram
- search ```@report_exorde_bot``` and click start. after that check your chat ID in ```https://api.telegram.org/bot5717312084:AAFYl4qrYosNPojHPy6MWZb8W16ab_fR0VI/getUpdates``` copy your chat ID and run installReport.sh.
- download and run the script ```wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/installReport.sh && chmod 777 installReport.sh && ./installReport.sh```
# if you have an error like "strtonum never defined"
- download c1_alt.sh, stuck_alt.sh and log_alt.sh. Make sure you're using this file in cronjob for auto restart
# if already run worker
download c1.sh, stuck.sh and updater.sh from this repo. add c1.sh and stuck.sh to cronjob. only run updater.sh if you want to restart every worker. dont forget to change my address with your address

# additional
- install pstree
```apt-get install psmisc```
