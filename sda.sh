#!/bin/bash
pidList=$(docker ps --filter "name=exor" --format "{{.Names}}")
for pid in ${pidList[@]};
do
  if docker logs $pid -t --tail=5 | grep "local variable 'kx' referenced before assignment"
  then 
      echo "Worker $pid stuck. Restarting worker";
      docker stop $pid && docker rm $pid
      if [[ "$pid" == *"exordenl"* ]]
      then
        docker run -d --restart unless-stopped --pull always --name $pid --network=container:vpnnl --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 0
      elif [[ "$pid" == *"exordejp"* ]]
      then
        docker run -d --restart unless-stopped --pull always --name $pid --network=container:vpnjp --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 0
      elif [[ "$pid" == *"exordeus"* ]]
      then
        docker run -d --restart unless-stopped --pull always --name $pid --network=container:vpnus --log-opt max-size=5m --log-opt max-file=5 exordelabs/exorde-cli -m 0x80bE97A5580061a647bb04ADaeb8d18fe963ae55 -l 0
      fi
  fi
done
