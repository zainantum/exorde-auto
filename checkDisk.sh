#!/usr/bin/bash
source $HOME/.bash_profile
size=$(df -m / | grep -vE '^Filesystem|tmpfs|cdrom|loop|overlay|sda' | awk '{ print $4*1}')
echo "disk space "$size
size1=300
if [ $size -gt $size1 ]; then
    echo "space disk enough"
else
    echo "disk space more then 99%. reinstall all docker container"
    docker stop $(docker ps -qf "name=^exorde")
    sleep 5
    docker rm -f $(docker ps -a -qf "name=^exorde")
    sleep 5
    if [ $size == 0 ]; then
        yes | docker system prune -a && yes | docker image prune && yes | docker rmi $(docker images -a -q) && yes | docker volume prune
    fi
    echo "installing new worker by bash profile variable"
    for (( i=1; i<=$maxWorker; i++ ))
    do
        name="exorde"$i
        echo "Create container $name"
        docker run -d --cpus="2" --memory="8g" --restart unless-stopped --pull always --name $name exordelabs/exorde-client --main_address $mainAddress
        sleep 1
    done
fi

