#!/bin/bash
. `dirname $0`/set_var.sh

#install as OACIS Simulator
host_id=`mongo oacis_development --eval "db.hosts.find({\"name\":\"localhost\"}).forEach(function(obj){ print(obj[\"_id\"]); })" | tail -1`
#host_id=`echo $host_id | sed "s/\"/\\\\\\\\\"/g"`
host_id=${host_id%\")}
host_id=${host_id#ObjectId(\"}
echo "[{\"id\": \"$host_id\"}]" > host.json

echo "{
  \"name\": \"Nagel_Schreckenberg\",
  \"command\": \"$runner_path\",
  \"support_input_json\": false,
  \"support_mpi\": false,
  \"support_omp\": false,
  \"print_version_command\": \"cd ~/nagel_schreckenberg_model; git describe --always\",
  \"pre_process_script\": null,
  \"executable_on_ids\": [],
  \"description\":\"### nagel\\_schreckenberg\\_model\\r\\n\\r\\n- Simulation code of Nagel-Schreckenberg model written in Ruby.\\r\\n[https://en.wikipedia.org/wiki/Nagel%E2%80%93Schreckenberg_model](https://en.wikipedia.org/wiki/Nagel%E2%80%93Schreckenberg_model)\\r\\n\\r\\n- [Visit developer site](https://github.com/yohm/nagel_schreckenberg_model)\",
  \"parameter_definitions\": [
    {\"key\": \"l\",\"type\": \"Integer\",\"default\": 200,\"description\": \"road length\"},
    {\"key\": \"v\",\"type\": \"Integer\",\"default\": 5,\"description\": \"max velocity\"},
    {\"key\": \"rho\",\"type\": \"Float\",\"default\": 0.3,\"description\": \"density of cars\"},
    {\"key\": \"p\",\"type\": \"Float\",\"default\": 0.1,\"description\": \"deceleration probability[0.0, 1.0]\"},
    {\"key\": \"t_init\",\"type\": \"Integer\",\"default\": 100,\"description\": \"thermalization steps\"},
    {\"key\": \"t_measure\",\"type\": \"Integer\",\"default\": 300,\"description\": \"measurement steps\"}
  ]
}
" > simulator.json

~/oacis/bin/oacis_cli create_simulator -h host.json -i simulator.json -o simulator_id.json
#~/oacis/bin/oacis_cli create_parameter_sets -s simulator_id.json -i '{"l":200,"v":5,"rho":0.3,"p":0.1,"t_init":100,"t_measure":300}' -o ps_ids.json
#rm host.json simulator.json simulator_id.json ps_ids.json
rm host.json simulator.json simulator_id.json

