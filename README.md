# Kafka

This project maintains a development docker stack for Kafka

## Build PKI
```
$ cd security

# setup CA and generate truststore

$ cert-make-ca.sh 'CN=CA,OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB'
  # generates:
  # ca.key
  # ca.crt
  # trust.jks
  # trust.pass

# make host cert

$ cert-make-host.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB' kafka kafka1 kafka2 kafka3 kafka.example.com
  # generates:
  # kafka.key
  # kafka.crt
  # kafka.jks
  # kafka.pass

# make user certifcate for admin user

$ cert-make-user.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB' admin
  # generates:
  # admin.key
  # admin.crt
  # admin.jks
  # admin.pass

$ cert-make-user.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB'
  # generates:
  # u10083b58.key
  # u10083b58.crt
  # u10083b58.jks
  # u10083b58.pass
```

## Run Docker Compose
```
$ bin/reset.sh
```

## Test
```
$ tests/broker-make-certs.sh
$ bin/reset.sh
$ tests/broker-auth-configure.sh u10083b58
$ tests/broker-auth.sh
```

## Deploy
```
$ bin/cert-make-all.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB' kafka1 kafka2 kafka3 node1.mac.wales node2.mac.wales node3.mac.wales
$ ansible-playbook playbooks/deploy-certificates.yaml
$ docker stack deploy --compose-file "docker-compose.yml" --compose-file "docker-compose-prod.yml" cmb

$ cert-make-user.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB' u10083b58 1907f8ffe9bd
$ tests/broker-auth-configure.sh u10083b58
$ tests/broker-auth.sh

```

Hint:  If kafka fails on restart then wait until ephemeral znodes have timed out before restarting kafka.
Hint2: Wait, just wait - it can take a couple of minutes to start.
