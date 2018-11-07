#!/bin/bash
export snapname=pihole
#export SNAPCRAFT_BUILD_ENVIRONMENT=lxd
#export SNAPCRAFT_BUILD_ENVIRONMENT=multipass
#export SNAPCRAFT_BUILD_ENVIRONMENT_MEMORY=24G
#export SNAPCRAFT_BUILD_ENVIRONMENT_CPU=4
sudo snap remove $snapname
snapcraft clean
sudo rm -rf ./parts
if [ $? -eq 0 ];
then
  snapcraft | tee -a buildlog.txt
  if [ $? -eq 0 ];
  then
    snap install $snapname*.snap --dangerous --devmode
    if [ $? -eq 0 ];
    then
      echo "Built and installed"
    else
      echo "Install failed"
    fi
  else
    echo "Snapcraft failed"
  fi
else
  echo "Clean failed"
fi
