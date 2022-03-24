# Kafka

This project maintains a docker stack for Kafka

## Deploy
```
TEST

$ ansible-playbook -i inventory-test.yaml playbooks/deploy-certificates.yaml
$ docker stack deploy --compose-file "docker-compose.yml" --compose-file "docker-compose-test.yml" cmb

PROD

$ ansible-playbook -i inventory-prod.yaml playbooks/deploy-certificates.yaml
$ docker stack deploy --compose-file "docker-compose.yml" --compose-file "docker-compose-prod.yml" cmb

CHECK

$ cert-make-user.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB' u10083b58 1907f8ffe9bd
$ tests/broker-auth-configure.sh u10083b58
$ tests/broker-auth.sh

```

Hint:  If kafka fails on restart then wait until ephemeral znodes have timed out before restarting kafka.

Hint2: Wait, just wait - it can take a couple of minutes to start.

# Management

## Topics

All of these commands should be run from where you cloned this repo from git (for example /root/stack-kafka).
 
List
```
bin/kafka-topics --list
```

Create
```
bin/kafka-topics --create --topic TOPIC
```

Delete
```
bin/kafka-topics --delete --topic TOPIC
```

## Access Control

List ACL for a TOPIC
```
bin/kafka-acls --list --topic TOPIC
```

List ACL for a CONSUMER-GROUP
```
bin/kafka-acls --list --group CONSUMER-GROUP
```

Create ACL for producer allowing publish to TOPIC
```
bin/kafka-acls.sh --add --topic TOPIC --producer --allow-principal "User:USER"
```

Create ACL for a consumer USER reading TOPIC via CONSUMER-GROUP
```
bin/kafka-acls.sh --add --group CONSUMER-GROUP --consumer --allow-principal "User:USER"
```

Remove ACL for TOPIC/CONSUMER-GROUP for USER
```
bin/kafka-acls --remove --allow-principal 'User:USER' --topic TOPIC --producer --force
bin/kafka-acls --remove --allow-principal 'User:USER' --topic TOPIC --group CONSUMER-GROUP --consumer --force
```

## CMB PKI in detail
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

$ cert-make-user.sh 'OU=KAFKA,O=EXAMPLE,L=CARDIFF,C=GB' admin password
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

With random username "CN=u10083b58" in this case with a random password in the u10083b58.pass file.
```

## In Development Environment Docker Compose
```
$ bin/reset.sh [stop|hard] [environment]
```
Stops all containers deletes all volumes. NEVER run this on production or test environments (unless you really want to).
