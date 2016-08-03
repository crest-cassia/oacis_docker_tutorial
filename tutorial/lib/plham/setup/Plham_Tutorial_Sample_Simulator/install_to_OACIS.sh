#!/bin/bash

#install Plham_Seminar02 as OACIS Simulator
db_name=oacis_development
host_object_id=`mongo $db_name --eval "db.hosts.find({\"name\":\"localhost\"}).forEach(function(obj){ print(obj[\"_id\"]); })" | tail -1`
host_id=${host_object_id%\")}
host_id=${host_id#ObjectId(\"}
echo "[{\"id\": \"$host_id\"}]" > host.json

echo "{
  \"name\": \"Plham_Seminar02\",
  \"command\": \"bash ~/oacis/public/Result_development/plham/seminar/oacis/run.sh ~/CI2002.exe\",
  \"support_input_json\": false,
  \"support_mpi\": false,
  \"support_omp\": false,
  \"print_version_command\": \"\",
  \"pre_process_script\": null,
  \"executable_on_ids\": [],
  \"description\":\"\",
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
  \"auto_run\" : \"yes\",
  \"files_to_copy\" : \"*\",
  \"description\":\"\",
  \"command\" : \"Rscript ~/oacis/public/Result_development/plham/seminar/plot.R _input/_stdout.txt plot.png\",
  \"support_input_json\" : false,
  \"support_mpi\" : false,
  \"support_omp\" : false,
  \"print_version_command\" : \"\",
  \"pre_process_script\" : null,
  \"executable_on_ids\": [],
  \"parameter_definitions\": [
  ]
}
" > analyzer1.json
~/oacis/bin/oacis_cli create_analyzer -h host.json -s simulator_id.json -i analyzer1.json -o analyzer_id1.json

echo "{
  \"name\" : \"Fattail_Plot\",
  \"type\" : \"on_run\",
  \"auto_run\" : \"yes\",
  \"files_to_copy\" : \"*\",
  \"description\":\"\",
  \"command\" : \"Rscript ~/oacis/public/Result_development/plham/seminar/fattail.R _input/_stdout.txt fattail.png\",
  \"support_input_json\" : false,
  \"support_mpi\" : false,
  \"support_omp\" : false,
  \"print_version_command\" : \"\",
  \"pre_process_script\" : null,
  \"executable_on_ids\": [],
  \"parameter_definitions\": [
  ]
}
" > analyzer2.json
~/oacis/bin/oacis_cli create_analyzer -h host.json -s simulator_id.json -i analyzer2.json -o analyzer_id2.json

echo "{
  \"name\" : \"Volcluster_Plot\",
  \"type\" : \"on_run\",
  \"auto_run\" : \"yes\",
  \"files_to_copy\" : \"*\",
  \"description\":\"\",
  \"command\" : \"Rscript ~/oacis/public/Result_development/plham/seminar/volcluster.R _input/_stdout.txt volcluster.png\",
  \"support_input_json\" : false,
  \"support_mpi\" : false,
  \"support_omp\" : false,
  \"print_version_command\" : \"\",
  \"pre_process_script\" : null,
  \"executable_on_ids\": [],
  \"parameter_definitions\": [
  ]
}
" > analyzer3.json
~/oacis/bin/oacis_cli create_analyzer -h host.json -s simulator_id.json -i analyzer3.json -o analyzer_id3.json

echo "{
  \"name\" : \"Statistics\",
  \"type\" : \"on_run\",
  \"auto_run\" : \"yes\",
  \"files_to_copy\" : \"*\",
  \"description\":\"\",
  \"command\" : \"Rscript ~/oacis/public/Result_development/plham/seminar/statistics.R _input/_stdout.txt >_output.json\",
  \"support_input_json\" : false,
  \"support_mpi\" : false,
  \"support_omp\" : false,
  \"print_version_command\" : \"\",
  \"pre_process_script\" : null,
  \"executable_on_ids\": [],
  \"parameter_definitions\": [
  ]
}
" > analyzer4.json
~/oacis/bin/oacis_cli create_analyzer -h host.json -s simulator_id.json -i analyzer4.json -o analyzer_id4.json

#clean up
rm host.json simulator.json simulator_id.json analyzer_id1.json analyzer_id2.json analyzer_id3.json analyzer_id4.json
