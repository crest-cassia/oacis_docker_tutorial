#!/bin/bash
. `dirname $0`/set_var.sh

#build
mkdir -p `dirname $binary_path`
x10c++ -sourcepath $plham_home $source_path -d build -o $binary_path
rm -rf build

