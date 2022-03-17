#!/usr/bin/env python3
# producer.py
# This script connects to Kafka and send a few messages

from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers="node1.mac.wales:9093",
    security_protocol="SSL",
    ssl_cafile="security/ca.crt",
    ssl_certfile="security/u10083b58.crt",
    ssl_keyfile="security/u10083b58.key"
)

for i in range(1, 4):
    message = "message number {}".format(i)
    print("Sending: {}".format(message))
    producer.send("events", message.encode("utf-8"))

# Force sending of all messages

producer.flush()
