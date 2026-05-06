#!/bin/bash
# Mounts the LFS partition securely after a system reboot
LFS_PARTITION="/dev/nvme0n1p4" 
MOUNT_POINT="/mnt/lfs"

echo "Mounting LFS environment..."
if ! mountpoint -q $MOUNT_POINT; then
    sudo mount $LFS_PARTITION $MOUNT_POINT
    echo "Success: $LFS_PARTITION mounted to $MOUNT_POINT."
else
    echo "Notice: LFS partition is already mounted."
fi

echo "Remember to run 'su - lfs' to enter the cleanroom."
