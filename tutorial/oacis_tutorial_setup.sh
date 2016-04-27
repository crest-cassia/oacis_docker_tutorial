#!/bin/bash

#pre-processes
chown -R 999:999 /data/db
chown -R oacis:oacis /home/oacis/oacis/public/Result_development

#start mongod and sshd
supervisorctl start all

#waiting for mongod boot
until [ "$(mongo --eval 'printjson(db.serverStatus().ok)' | tail -1 | tr -d '\r')" == "1" ]
do
  sleep 1
  echo "waiting for mongod boot..."
done

db_name=oacis_development
if [ "$(mongo ${db_name} --eval 'printjson(db.hosts.count({"name": "localhost"}));' | tail -1 | tr -d '\r')" == "0" ]
then
  mongo ${db_name} --eval 'db.hosts.insert({"status" : "enabled", "port" : 22, "ssh_key" : "~/.ssh/id_rsa", "work_base_dir" : "~/oacis/public/Result_development/work/__work__", "mounted_work_base_dir" : "~/oacis/public/Result_development/work/__work__", "max_num_jobs" : 1, "polling_interval" : 5, "min_mpi_procs" : 1, "max_mpi_procs" : 1, "min_omp_threads" : 1, "max_omp_threads" : 1, "name" : "localhost", "hostname" : "localhost", "user" : "oacis"})'
fi

/home/oacis/tutorial/lib/nagel_schreckenberg/oacis_tutorial_NS.sh
/home/oacis/tutorial/lib/plham/oacis_tutorial_Plham.sh

