#!/bin/bash
# Description: Safely compresses the LFS sysroot into an archive.
# Run as: root

export LFS=/mnt/lfs
BACKUP_DIR="/root/lfs-backup" # Storing in host's root folder
DATE=$(date +%F)
BACKUP_NAME="lfs-temp-tools-13.0-systemd-${DATE}.tar.xz"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo ./lfs-backup.sh)"
  exit 1
fi

# CRITICAL SAFETY CHECK: Ensure virtual file systems are unmounted!
if mountpoint -q $LFS/dev; then
  echo "[!] ERROR: Virtual file systems are still mounted."
  echo "[!] Please run ./lfs-unmount.sh before backing up to prevent host contamination."
  exit 1
fi

mkdir -p $BACKUP_DIR
echo "[*] Starting compression. This will take several minutes..."

cd $LFS
tar -cJpf $BACKUP_DIR/$BACKUP_NAME .

echo "[+] Backup complete: $BACKUP_DIR/$BACKUP_NAME"
