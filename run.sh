ci/harness.sh clean
sellop 60
ci/harness.sh configure
ci/harness.sh deploy
sleep 120
ci/harness.sh prepare_tests
ci/harness.sh run_tests
