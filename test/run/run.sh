#!/bin/bash

. ./test/base.sh

function run_oacis() {
  docker run --name ${OACIS_CONTAINER_NAME} -p ${PORT}:3000 -dt ${OACIS_IMAGE}
  sleep 180
  docker logs ${OACIS_CONTAINER_NAME}
  curl localhost:${PORT}
}

run_oacis
rc=$?

exit $rc

