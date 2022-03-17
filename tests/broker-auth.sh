#!/usr/bin/bash

HERE=$(dirname $0)

BROKER=node1.mac.wales:9093
TOPIC="events"
GROUP="${TOPIC}-group"

# export KAFKA_OPTS="-Dlog4j.configuration=file:${HERE}/log4j.properties"

# export KAFKA_OPTS="-Djavax.net.debug=all"

echo
echo '#publish'
echo "//// AUTH message $(date) //" | kafka-console-producer.sh \
  --producer.config "${HERE}/producer.properties" \
  --bootstrap-server ${BROKER} \
  --topic ${TOPIC} 
echo '#publish complete'

echo
echo '#subscribe'
kafka-console-consumer.sh \
  --consumer.config "${HERE}/consumer.properties" \
  --bootstrap-server ${BROKER} \
  --topic ${TOPIC} \
  --group "${GROUP}" \
  --from-beginning \
  --timeout-ms 5000
echo '#subscribe complete'
