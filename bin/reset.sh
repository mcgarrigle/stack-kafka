#!/bin/bash

function stack_remove {
  docker stack rm cmb
  sleep 10
}

function stack_delete_volumes {
  for h in node1 node2 node3; do
    ssh "${h}.mac.wales" docker volume prune --force
  done
}

function stack_start {
  # docker stack deploy --compose-file "docker-compose.yml" --compose-file "docker-compose-$1.yml" cmb
  docker stack deploy --compose-file "docker-compose.yml" cmb
}

. cluster.env

if [ "$1" == "stop" ]; then
  stack_remove
  stack_delete_volumes
elif [ "$1" == "hard" ]; then
  stack_remove
  stack_delete_volumes
  stack_start "${2:-prod}"
fi
