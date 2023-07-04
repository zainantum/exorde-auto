pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
      echo "checking unusual activity mode $pid"
      if [[ "$pid" == *"exordetw1"* ]] && docker logs $pid -t --tail=200 | grep "Unusual Activity Mode" 
      then
        docker stop exordetw1 && docker rm exordetw1
        docker rm exordetw1
        echo "rate exceed for exordetw1. lets try using exordetw2 ()"
        docker run -d --restart unless-stopped --pull always --name exordetw2 exordelabs/exorde-client --main_address $main --twitter_username '' --twitter_password '' --twitter_email ''
      elif [[ "$pid" == *"exordetw2"* ]] && docker logs $pid -t --tail=200 | grep "Unusual Activity Mode"  
      then
        docker stop exordetw2 && docker rm exordetw2
        docker rm exordetw2
        echo "rate exceed for exordetw2. lets try using exordetw1 ()"
        docker run -d --restart unless-stopped --pull always --name exordetw1 exordelabs/exorde-client --main_address $main --twitter_username '' --twitter_password '' --twitter_email ''
      fi
done
