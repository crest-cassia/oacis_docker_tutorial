#!/bin/bash +eux
die() { echo "$@"; exit 1; }

tutorial_name=`basename ${0%.sh}`
config_file=~/oacis/public/Result_development/work/plham/config/${tutorial_name}.json
binary=~/bin/plham/bin/${tutorial_name}.out
plham_home=~/plham

[ $# -eq 4 ] || die "$0: Need 4 arguments but [$@]
Usage: $ bash $0 fundamentalWeight chartWeight noiseWeight [SEED]"

P1=$1
P2=$2
P3=$3
SEED=$4
JSON='config.json'
sed "s/%P1%/$P1/g; s/%P2%/$P2/g; s/%P3%/$P3/g" ${config_file} >$JSON

$binary $JSON $SEED > output.dat
Rscript $plham_home/samples/CI2002/plot.R output.dat output.png

