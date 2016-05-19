#!/bin/bash

. ./test/base.sh

function setup_tutorial_Plham() {
  docker run --name ${OACIS_CONTAINER_NAME} -p ${PORT}:3000 -dt ${OACIS_IMAGE}
  sleep 180
  test `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "test -f /home/oacis/tutorial/lib/plham/oacis_tutorial_Plham.sh"; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "test -d /home/oacis/plham"; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "test -f /home/oacis/oacis/public/Result_development/work/plham"; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "/home/oacis/plham/samples/CI2002/oacis/run.sh ~/bin/plham/bin/CI2002.out 1.0 0.0 1.0 12345" > /dev/null 2>&1; echo $?` -eq 0 -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "mongo --eval \"db = db.getSiblingDB('oacis_development'); db.simulators.find({\\\\\"name\\\\\":\\\\\"Plham_CI2002\\\\\"}).map (function(u) {return u.name;})[0]\"" | tail -1 | tr -d '\r'` == 'Plham_CI2002' -a \
    `docker exec -it ${OACIS_CONTAINER_NAME} bash -c "mongo --eval \"db = db.getSiblingDB('oacis_development'); db.analyzers.find({\\\\\"name\\\\\":\\\\\"Timeseries_Plot\\\\\", \\\\\"simulator_id\\\\\": db.simulators.findOne({\\\\\"name\\\\\":\\\\\"Plham_CI2002\\\\\"})._id}).map (function(u) {return u.name;})[0]\"" | tail -1 | tr -d '\r'` == 'Timeseries_Plot'
}

setup_tutorial_Plham
rc=$?

exit $rc

