#!/usr/bin/bash

HERE=$(dirname $0)

BROKER=kafka:29093
TOPIC="events"

# export KAFKA_OPTS="-Dlog4j.configuration=file:${HERE}/log4j.properties"

echo
echo '#publish'
echo "//// SSL message $(date) //" | kafka-console-producer.sh \
  --producer.config "${HERE}/ssl.properties" \
  --bootstrap-server ${BROKER} \
  --topic ${TOPIC} 
echo '#publish complete'

echo
echo '#subscribe'
kafka-console-consumer.sh \
  --consumer.config "${HERE}/ssl.properties" \
  --bootstrap-server ${BROKER} \
  --topic ${TOPIC} \
  --from-beginning \
  --timeout-ms 5000
echo '#subscribe complete'
