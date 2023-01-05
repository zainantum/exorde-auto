source $HOME/.bash_profile
for (( i=1; i<=10; i++ ))
do
   name="exorde"$i
   truncate -s 0 log.txt
sleep 1
echo "Log worker $name";
screen -X -S $name hardcopy log.txt
sleep 2
tail -n20 log.txt
sleep 2
done
