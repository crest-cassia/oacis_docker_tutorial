#!/bin/bash

tutorial_name=plham

if [ ! -f /home/oacis/oacis/public/Result_development/work/${tutorial_name} ]
then
  #install to OACIS
  su - oacis -c "~/tutorial/lib/plham/setup/Plham_CI2002/install_to_OACIS.sh"
  #change file permittion
  su - oacis -c "chmod +x ~/plham/samples/CI2002/oacis/*.sh"
  #install Sample to OACIS
  su - oacis -c "~/tutorial/lib/plham/setup/Plham_Tutorial_Sample_Simulator/install_to_OACIS.sh"
  #touch
  su - oacis -c "if [ ! -d ~/oacis/public/Result_development/work ]; then mkdir ~/oacis/public/Result_development/work; fi; cd ~/plham; git describe --always >> ~/oacis/public/Result_development/work/${tutorial_name}"
else
  echo "tutorial(${tutorial_name}) has been restored."
fi

