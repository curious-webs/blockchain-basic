echo "Docker Remove all the process"
#docker-compose -f docker/docker-compose-twg-net.yaml down --volumes --remove-orphans
yes | docker rm -f $(docker ps -aq)                     

                       

echo "Pruning Volume"
yes | docker volume  prune  

echo "Pruning Network"
yes | docker network prune   

echo "Deleting TWG Directory"
#  rm -r TWG
echo "Deleting Block"
rm genesis_block.block
  