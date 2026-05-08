#!/bin/bash
# Description: Safely unmounts LFS virtual kernel file systems.
# Run as: root

export LFS=/mnt/lfs

# Ensure we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo ./lfs-unmount.sh)"
  exit 1
fi

echo "[*] Unmounting LFS virtual file systems..."

mountpoint -q $LFS/dev/shm && umount -v $LFS/dev/shm
mountpoint -q $LFS/dev/pts && umount -v $LFS/dev/pts
mountpoint -q $LFS/sys     && umount -v $LFS/sys
mountpoint -q $LFS/proc    && umount -v $LFS/proc
mountpoint -q $LFS/run     && umount -v $LFS/run
mountpoint -q $LFS/dev     && umount -v $LFS/dev

echo "[+] Unmount complete. It is now safe to backup, reboot, or power off."
