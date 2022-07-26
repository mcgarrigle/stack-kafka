#!/usr/bin/sh

THIS=$(realpath $0)
HERE=$(dirname $THIS)
ROOT=$(realpath "$HERE/..")

source "$HERE/cluster.env"
export BROKER="${BROKER1}:9093"

echo "// $1"
echo "// environment --------------------------------------------"
echo "   THIS      = '${THIS}'"
echo "   HERE      = '${HERE}'"
echo "   ROOT      = '${ROOT}'"
echo "   BASE_DN   = '${BASE_DN}'"
echo "   BROKER    = '${BROKER}'"
echo "   ZOOKEEPER = '${ZOOKEEPER_IMAGE}'"
echo "   KAFKA     = '${KAFKA_IMAGE}'"
echo "// --------------------------------------------------------"
echo

PATH=$PATH:"$ROOT/bin"

cd "$ROOT"

container() {
  docker run -v "${ROOT}:/ci" -v "${ROOT}/secrets:/opt/kafka/secrets" -w "/ci" --env "BASE_DN" --env BROKER="${BROKER1}:9093" "$KAFKA_IMAGE" $@
}

# ---------------------------

clean() {
  echo "// clean"
  docker stack rm "${CLUSTER}"
  rm -vf "${ROOT}/secrets/"*

  for h in $BROKERS; do
    ssh "${h}" docker volume prune --force
  done
}

# ---------------------------

configure() {
  cert-make-all.sh "$BASE_DN" $BROKERS
}

# ---------------------------

deploy() {
  $ROOT/bin/deploy.sh
}

# ---------------------------

prepare_tests() {
  cd "${ROOT}/secrets"
  cert-make-user.sh "$BASE_DN" "u10083b58" "1907f8ffe9bd"
  container /ci/tests/broker-auth-configure.sh "u10083b58"
}

# ---------------------------

run_tests() {
  container "/ci/tests/broker-auth.sh"
}

$@
