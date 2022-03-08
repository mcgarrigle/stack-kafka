#!/bin/bash

BASEDN=${1:-'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB'}
BROKERS="kafka1 kafka2 kafka3 node1.mac.wales node2.mac.wales node3.mac.wales"
NODES="node1 node2 node3"

echo $BASEDN

cd security
#rm -f rm -f *.key *.crt *.pass *.jks

#cert-make-ca.sh "CN=CA,$BASEDN"
#cert-make-host.sh "$BASEDN" kafka $BROKERS
#cert-make-user.sh "$BASEDN" admin
#cert-make-user.sh "$BASEDN" u10083b58

for NODE in $NODES; do
  echo $NODE
  ssh $NODE mkdir -p /opt/kafka-security
  echo $NODE
  scp * $NODE:/opt/kafka-security
done
