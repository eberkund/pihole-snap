#!/bin/bash
# Test script for checking sanity of the pihole snap
# This script expects lxd/lxc to already be configured
# If that's not the case, configure lxd with the following
# Note that 'eth0' in the list of commands is your default network device
#   sudo snap install lxd
#   sudo lxd init --auto --storage-backend dir
#   lxc network create lxdbr0
#   lxc network attach-profile lxdbr0 default eth0
# You may need to add your user to the lxd group too.
# 
# Actual test script

# Variables to create bespoke container
SNAPNAME="pihole"
SNAPFILE="$(ls -1 pihole*.snap)"
TMPDIR=$(mktemp -d)
DATESTAMP="$(date +%Y%m%d)-$(date +%H%M%S)"
CONTAINER=$SNAPNAME-$DATESTAMP
BADHOST="a-ads.com"
GOODHOST="pi-hole.net"

## Launch container
echo "** Launch lxc container"
lxc launch ubuntu:18.04 $CONTAINER
if [ $? -ne 0 ];
then
    echo "Failed to launch container"
    exit 1
fi

# Copy snap into container
lxc file push  $SNAPFILE $CONTAINER/root/
if [ $? -ne 0 ];
then
    echo "Failed to push source tarball to container"
    exit 1
fi

# Install snap in container
echo "** Run prep script in container"
/snap/bin/lxc exec $CONTAINER -- snap install /root/$SNAPFILE
if [ $? -ne 0 ];
then
    echo "Failed to run prep script"
    exit 1
fi

# Test pihole
## Dig 

echo "** Run dig on $BADHOST in container"
/snap/bin/lxc exec $CONTAINER -- dig $BADHOST @localhost
if [ $? -ne 0 ];
then
    echo "Failed to run dig on $BADHOST in container"
    exit 1
fi

echo "** Run dig on $GOODHOST in container"
/snap/bin/lxc exec $CONTAINER -- dig $GOODHOST @localhost
if [ $? -ne 0 ];
then
    echo "Failed to run dig on $GOODHOST in container"
    exit 1
fi

## Show log from container
echo "** Show log"
/snap/bin/lxc exec $CONTAINER -- cat /var/snap/$SNAPNAME/common/var/log/pihole-FTL.log
if [ $? -ne 0 ];
then
    echo "Failed to get log in container"
    exit 1
fi
