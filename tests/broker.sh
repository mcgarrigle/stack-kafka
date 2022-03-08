#!/usr/bin/bash

HERE=$(dirname $0)

BROKER=kafka:29092
TOPIC="events"

# export KAFKA_OPTS="-Dlog4j.configuration=file:${HERE}/log4j.properties"

kafka-topics.sh --bootstrap-server ${BROKER} --topic ${TOPIC} --describe

echo
echo '#publish'
echo "//// message $(date) //" |kafka-console-producer.sh --bootstrap-server kafka:29092 --topic ${TOPIC} 
echo '#publish complete'

# export KAFKA_OPTS="-Dlog4j.configuration=file:${HERE}/log4j.properties"
echo
echo '#subscribe'
kafka-console-consumer.sh --bootstrap-server ${BROKER} --topic ${TOPIC} --from-beginning --timeout-ms 5000
echo '#subscribe complete'
