#!/bin/bash

#waiting for mongod boot
until [ "$(mongo --eval 'printjson(db.serverStatus().ok)' | tail -1 | tr -d '\r')" == "1" ]
do
  sleep 1
done

/home/oacis/tutorial/lib/nagel_schreckenberg/oacis_tutorial_NS.sh
/home/oacis/tutorial/lib/plham/oacis_tutorial_Plham.sh

