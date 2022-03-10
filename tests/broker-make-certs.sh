#!/bin/bash

BASEDN=${1:-'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB'}
BROKERS="kafka1 kafka2 kafka3 node1.mac.wales node2.mac.wales node3.mac.wales"
NODES="node1 node2 node3"

echo $BASEDN

cd security
rm -f rm -f *.key *.crt *.pass *.jks

cert-make-ca.sh "CN=CA,$BASEDN"
cert-make-host.sh "$BASEDN" kafka $BROKERS
cert-make-user.sh "$BASEDN" admin 2e260eac98c4
cert-make-user.sh "$BASEDN" u10083b58 1907f8ffe9bd

for NODE in $NODES; do
  ssh $NODE mkdir -p /opt/kafka-security
  scp * $NODE:/opt/kafka-security
done
