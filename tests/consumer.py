#!/usr/bin/env python3
#
# consumer.py
# This script receives messages from a Kafka topic

from kafka import KafkaConsumer

consumer = KafkaConsumer(
    "events",
    auto_offset_reset="earliest",
    bootstrap_servers="node1.mac.wales:9093",
    client_id="test",
    group_id="events-group",
    security_protocol="SSL",
    ssl_cafile="/opt/kafka/security/ca.crt",
    ssl_certfile="/opt/kafka/security/u10083b58.crt",
    ssl_keyfile="/opt/kafka/security/u10083b58.key"
)

# Call poll twice. First call will just assign partitions for our
# consumer without actually returning anything

for _ in range(2):
    raw_msgs = consumer.poll(timeout_ms=1000)
    for tp, msgs in raw_msgs.items():
        for msg in msgs:
            print("Received: {}".format(msg.value))

# Commit offsets so we won't get the same messages again

consumer.commit()
