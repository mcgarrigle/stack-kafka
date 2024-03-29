#!/bin/bash

THIS=$(realpath $0)
HERE=$(dirname $THIS)
PATH=$PATH:$HERE
echo $PATH

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

cd "./secrets"

cert-make-ca.sh "CN=CA,$BASEDN"

cert-make-host.sh "$BASEDN" kafka $BROKERS

# make admin user cert
cert-make-user.sh "$BASEDN" admin $PASS

cat << EOF > "admin.properties"
security.protocol = SSL
ssl.truststore.location = /opt/kafka/secrets/admin.jks
ssl.truststore.password = $PASS
ssl.keystore.location = /opt/kafka/secrets/admin.jks
ssl.keystore.password = $PASS
EOF
