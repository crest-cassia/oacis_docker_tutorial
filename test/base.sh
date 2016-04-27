#!/bin/bash

set -eux

OACIS_IMAGE=${OACIS_IMAGE-"oacis/oacis_tutorial"}
PORT=3210
OACIS_CONTAINER_NAME="oacis_docker_tutorial_test"

function cleanup() {
  # grep returns non zero code when the pattern is missing.
  set +e

  dockerps=`docker ps | grep "${OACIS_CONTAINER_NAME}[\ ]*$"`
  if [ -n "$dockerps" ]
  then
    docker stop ${OACIS_CONTAINER_NAME}
  fi
  dockerps=`docker ps -a | grep "${OACIS_CONTAINER_NAME}[\ ]*$"`
  if [ -n "$dockerps" ]
  then
    docker rm -v ${OACIS_CONTAINER_NAME}
  fi
}
trap cleanup EXIT ERR

