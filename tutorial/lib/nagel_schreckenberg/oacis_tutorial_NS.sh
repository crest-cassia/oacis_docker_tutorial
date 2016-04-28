#!/bin/bash

tutorial_name=nagel_schreckenberg

if [ ! -f /home/oacis/oacis/public/Result_development/work/${tutorial_name} ]
then
  #install to OACIS
  su - oacis -c "~/tutorial/lib/nagel_schreckenberg/setup/install_to_OACIS.sh"
  #touch
  su - oacis -c "if [ ! -d ~/oacis/public/Result_development/work ]; then mkdir ~/oacis/public/Result_development/work; fi; cd ~/nagel_schreckenberg_model;git describe --always >> ~/oacis/public/Result_development/work/${tutorial_name}"
else
  echo "tutorial(${tutorial_name}) has been restored."
fi

