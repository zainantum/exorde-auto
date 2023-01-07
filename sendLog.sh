source $HOME/.bash_profile
pidList=$(screen -ls | awk '/[0-9]{3,}\./ {print strtonum($1)}')
for pid in ${pidList[@]};
do
    name=$(screen -ls | grep $pid | awk '{print $1}' | cut -d. -f 2)
    truncate -s 0 log.txt
    sleep 1
    echo "Log worker $name";
    screen -X -S $name hardcopy log.txt
    sleep 2
    tail -n7 log.txt > log1.txt
    python3 sendReport.py $name `hostname -s`
    sleep 2
done

