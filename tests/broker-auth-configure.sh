#!/bin/sh

TOPIC=events

PATH=$PATH:/opt/kafka/bin

CONFIG="--bootstrap-server "${BROKER}:9093" --command-config tests/admin.properties"

kafka-topics.sh ${CONFIG} --create --topic ${TOPIC}
kafka-topics.sh ${CONFIG} --list

kafka-acls.sh $CONFIG  \
  --add \
  --topic events \
  --producer \
  --consumer \
  --group ${TOPIC}-group \
  --allow-principal "User:$1"

