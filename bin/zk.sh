#!/bin/sh

CONTAINER=$(docker ps --filter 'name=zookeeper1' --format '{{.Names}}')
docker exec -it $CONTAINER zkCli.sh

