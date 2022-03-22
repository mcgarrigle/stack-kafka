#!/bin/bash

HERE=$(dirname $0)
PATH=$PATH:$HERE

BASEDN=$1
shift
BROKERS=$@

PASS="2e260eac98c4"

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

# make admin user cert
cert-make-user.sh "$BASEDN" admin $PASS

cat << EOF > "/tmp/security/admin.properties"
security.protocol = SSL
ssl.truststore.location = /opt/kafka/security/admin.jks
ssl.truststore.password = $PASS
ssl.keystore.location = /opt/kafka/security/admin.jks
ssl.keystore.password = $PASS
EOF
