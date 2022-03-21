#!/bin/bash

HERE=$(dirname $0)
PATH=$PATH:$HERE

BASEDN=$1
shift
BROKERS=$@

echo $BASEDN
echo $BROKERS

function make-directory {
  mkdir -p "$1"
  cd "$1"
  rm -f *.key *.crt *.pass *.jks
}

make-directory "/opt/kafka/ca"

cert-make-ca.sh "CN=CA,$BASEDN"

make-directory "/tmp/security"

cert-make-host.sh "$BASEDN" kafka $BROKERS
cert-make-user.sh "$BASEDN" admin 2e260eac98c4
