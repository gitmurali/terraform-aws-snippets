#!/bin/bash

# Enable debugging and exit on error
set -ex 

# Activate volume groups
vgchange -ay

# Check the file system type of the specified device
DEVICE_FS=`blkid -o value -s TYPE ${DEVICE} || echo ""`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  # Wait for the device to be attached and format it if not formatted
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''

  # Loop to verify device attachment
  while [[ -z $DEVICEEXISTS ]]; do
    echo "verify $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done

  # Ensure the device file in /dev/ exists within a time limit
  count=0
  until [[ -e ${DEVICE} || "$count" == "60" ]]; do
    sleep 5
    count=$(expr $count + 1)
  done

  # Initialize physical volume, create volume group, and logical volume
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data

  # Create a file system on the volume
  mkfs.ext4 /dev/data/volume1
fi

# Create directory /data if it doesn't exist
mkdir -p /data

# Add entry to /etc/fstab for mounting at boot
echo '/dev/data/volume1 /data ext4 defaults 0 0' >> /etc/fstab

# Mount /data
mount /data

# Install Docker
curl https://get.docker.com | bash

# End of script
