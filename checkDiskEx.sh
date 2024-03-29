#!/usr/bin/bash
source $HOME/.bash_profile
size=$(df -m / | grep -vE '^Filesystem|tmpfs|cdrom|loop|overlay|sda' | awk '{ print $4*1}')
echo "disk space "$size
size1=300
if [ $size -gt $size1 ]; then
    echo "space disk enough"
else
    echo "disk space more than 99%. reinstall all docker container"
    docker stop $(docker ps -qf "name=^exorde")
    sleep 5
    docker rm -f $(docker ps -a -qf "name=^exorde")
    sleep 5
    echo "installing new worker by bash profile variable"
    for (( i=1; i<=$maxWorker; i++ ))
    do
        name="exorde"$i
        echo "Create container $name"
        docker run -d --restart unless-stopped --pull always --name $name --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m $mainAddress -l 0
        sleep 1
    done
fi
