#!/bin/bash

function stack_remove {
  docker stack rm cmb
  sleep 10
}

function stack_delete_volumes {
  for h in node1 node2 node3; do
    ssh $h docker volume prune --force
  done
}

function stack_start {
  docker stack deploy -c docker-compose.yml cmb
}

if [ "$1" == "stop" ]; then
  stack_remove
  stack_delete_volumes
else
  stack_remove
  stack_delete_volumes
  stack_start
fi
