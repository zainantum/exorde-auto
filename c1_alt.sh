source $HOME/.bash_profile
for (( i=1; i<=$maxWorker; i++ ))
do
   name="exorde"$i
   pid=$(ps aux | grep -w $name | grep -v grep | awk {'print $2'})
   if pstree $pid | grep python
    then
        echo "Worker $name is working";
    else
        echo "Worker $name is not working";
        #/usr/bin/screen -SX $pid quit;
	      echo $name;
	      screen -r $name -X stuff 'python Launcher.py -m '${mainAddress}' -l 3'`echo -ne '\015'`
    fi
done
