#!/usr/bin/bash
source $HOME/.bash_profile
size=$(df -H | grep -vE '^Filesystem|tmpfs|cdrom|loop|overlay|sda' | awk '{ print $5*1}')
echo "disk space "$size
if (( "${size%.*}" > 90 )); then
    echo "disk space more then 98%. reinstall all docker container"
    docker stop $(docker ps -qf "name=^exorde")
    sleep 5
    docker rm -f $(docker ps -a -qf "name=^exorde")
    sleep 5
    echo "installing new worker by bash profile variable"
    for (( i=1; i<=2; i++ ))
    do
        name="exorde"$i
        echo "Create container $name"
        docker run -d --restart unless-stopped --pull always --name $name --network=container:vpn --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 0
        sleep 1
    done
fi
