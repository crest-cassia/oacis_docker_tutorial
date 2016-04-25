#!/bin/bash
. `dirname $0`/set_var.sh

#install as OACIS Simulator
host_id=`mongo oacis_development --eval "db.hosts.find({\"name\":\"localhost\"}).forEach(function(obj){ print(obj[\"_id\"]); })" | tail -1`
#host_id=`echo $host_id | sed "s/\"/\\\\\\\\\"/g"`
host_id=${host_id%\")}
host_id=${host_id#ObjectId(\"}
echo "[{\"id\": \"$host_id\"}]" > host.json

echo "{
  \"name\": \"Plham_Tutorial_01_CI2002Main\",
  \"command\": \"$runner_path\",
  \"support_input_json\": false,
  \"support_mpi\": false,
  \"support_omp\": false,
  \"print_version_command\": \"cd ~/plham; git describe --always\",
  \"pre_process_script\": null,
  \"executable_on_ids\": [],
  \"description\":\"### CI2002Main\\r\\n\\r\\n- [Visit developer site](https://github.com/plham/plham)\",
  \"parameter_definitions\": [
    {\"key\": \"fundamentalWeight\",\"type\": \"Float\",\"default\": 1.0,\"description\": \"\"},
    {\"key\": \"chartWeight\",\"type\": \"Float\",\"default\": 0.0,\"description\": \"\"},
    {\"key\": \"noiseWeight\",\"type\": \"Float\",\"default\": 1.0,\"description\": \"\"}
  ]
}
" > simulator.json

~/oacis/bin/oacis_cli create_simulator -h host.json -i simulator.json -o simulator_id.json
rm host.json simulator.json simulator_id.json

