#!/usr/bin/bash

docker stack deploy --compose-file "zookeeper.stack.yml" --compose-file "kafka.stack.yml" "$CLUSTER"
