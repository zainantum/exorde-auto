# this script only work for conda/python. its doesnt work for docker for now
# if using new vps just run autoRun.sh. this script include auto install python, conda and any library
```wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && ./autoRun.sh```
# if you have already run worker
download c1.sh, stuck.sh and updater.sh from this repo. add c1.sh and stuck.sh to cronjob. only run updater.sh if you want to restart every worker. dont forget to change my address with your address

# additional
- install pstree
```apt-get install psmisc```
