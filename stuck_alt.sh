source $HOME/.bash_profile
for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   pid=$(ps aux | grep -w $name | grep -v grep | awk {'print $2'})
   truncate -s 0 log.txt
    sleep 5
    screen -X -S $name hardcopy log.txt
    if tail -n5 log.txt | grep 'Safety Sleep' || tail -n8 log.txt | grep '[Init] Current Config' || tail -n5 log.txt | grep 'Init Worker Master' || tail -n5 log.txt | grep 'Init Version Check' || tail -n5 log.txt | grep 'Claiming Master' || tail -n5 log.txt | grep 'stakeChecking' || tail -n5 log.txt | grep 'Could not read ConfigRegistry' || tail -n3 log.txt | grep 'sub routine initialized' || tail -n5 log.txt | grep 'Network seems to have stopped block production'   
    then
        echo "Restart worker $name. Worker Stuck";
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        screen -r $name -X stuff $'\003'
        sleep 15
        screen -r $name -X stuff 'python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
    else
        echo "Worker $name running perfectly";
    fi
done
