#!/bin/bash
. `dirname $0`/set_var.sh

#install as OACIS Simulator
db_name=oacis_development
host_object_id=`mongo $db_name --eval "db.hosts.find({\"name\":\"localhost\"}).forEach(function(obj){ print(obj[\"_id\"]); })" | tail -1`
host_id=${host_object_id%\")}
host_id=${host_id#ObjectId(\"}
echo "[{\"id\": \"$host_id\"}]" > host.json

echo "{
  \"name\": \"Plham_CI2002\",
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
echo "{
  \"name\" : \"Timeseries_Plot\",
  \"type\" : \"on_run\",
  \"auto_run\" : \"no\",
  \"files_to_copy\" : \"_stdout.txt\",
  \"description\":\"### CI2002Main\\r\\n\\r\\n- [Visit developer site](https://github.com/plham/plham)\",
  \"command\" : \"$analyzer_path\",
  \"support_input_json\" : true,
  \"support_mpi\" : false,
  \"support_omp\" : false,
  \"print_version_command\" : \"cd ~/plham; git describe --always\",
  \"pre_process_script\" : null,
  \"executable_on_ids\": [],
  \"parameter_definitions\": [
    {\"key\": \"FileName\",\"type\": \"String\",\"default\": \"output.png\",\"description\": \"\"}
  ]
}
" > analyzer.json
~/oacis/bin/oacis_cli create_analyzer -h host.json -s simulator_id.json -i analyzer.json -o analyzer_id.json

#clean up
rm host.json simulator.json simulator_id.json analyzer_id.json
