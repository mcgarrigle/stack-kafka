#!/bin/bash

docker stack rm cmb
sleep 10

for h in node1 node2 node3; do
  ssh $h docker volume prune --force
done

docker stack deploy -c docker-compose.yml cmb

