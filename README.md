# this script only work for conda/python. its doesnt work for docker for now
# if using new vps just run autoRun.sh. this script include auto install python, conda and any library
1. run autoRun.sh
```wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && ./autoRun.sh```
2. after script autoRun.sh complete you can check your worker with screen -ls
3. to see every worker log, you can use ./log.sh command. it will display log in all worker.
4. cronjob will restart your worker automatically if your worker not running or stuck. you can check with crontab -e command to make sure c1.sh and stuck.sh is setting up
5. if you want to update all worker:
- kill all exorde screen, exclude other project. if you're only run exorde screen you can use pkill screen command
- run ./updater.sh
# if you have already run worker
download c1.sh, stuck.sh and updater.sh from this repo. add c1.sh and stuck.sh to cronjob. only run updater.sh if you want to restart every worker. dont forget to change my address with your address

# additional
- install pstree
```apt-get install psmisc```
