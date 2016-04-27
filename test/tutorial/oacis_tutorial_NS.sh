#!/bin/bash

. ./test/base.sh

function setup_tutorial_NS() {
  docker run --name ${OACIS_CONTAINER_NAME} -p ${PORT}:3000 -dt ${OACIS_IMAGE}
  sleep 180
  test `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "test -f /home/oacis/tutorial/lib/nagel_schreckenberg/oacis_tutorial_NS.sh"; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "test -d /home/oacis/nagel_schreckenberg_model"; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "test -f /home/oacis/oacis/public/Result_development/work/nagel_schreckenberg"; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "mongo --eval \"db = db.getSiblingDB('oacis_development'); db.simulators.find({\\\\\"name\\\\\":\\\\\"Nagel_Schreckenberg\\\\\"}).map (function(u) {return u.name;})[0]\"" | tail -1 | tr -d '\r'` == 'Nagel_Schreckenberg'
}

setup_tutorial_NS
rc=$?

exit $rc

