#!/bin/bash

tutorial_name=plham

if [ ! -d /home/oacis/oacis/public/Result_development/work/${tutorial_name} ]
then
  #copy files
  su - oacis -c "rsync -a ~/tutorial/lib/plham/Result_development/work/${tutorial_name} ~/oacis/public/Result_development/work/"
  #install to OACIS
  su - oacis -c "~/tutorial/lib/plham/setup/01_CI2002/install_to_OACIS.sh"
else
  echo "tutorial(${tutorial_name}) has been restored."
fi

