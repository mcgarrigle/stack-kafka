#!/usr/bin/bash

docker stack deploy --compose-file "docker-compose.yml" --compose-file "docker-compose-prod.yml" cmb
