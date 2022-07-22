#!/usr/bin/sh

# . cluster
# cd secrets
# ../bin/cert-make-user.sh u10083b58 1907f8ffe9bd
# cd ..
# docker run -it -v $PWD:/ci -w /ci --env BASE_DN --env BROKER=$BROKER1 $KAFKA_IMAGE /ci/tests/harness.sh

tests/broker-auth-configure.sh u10083b58
tests/broker-auth.sh
