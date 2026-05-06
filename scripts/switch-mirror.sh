#!/bin/bash
# Converts standard LFS wget-list to target a high-speed Singapore mirror for systemd packages
# Run this inside the $LFS/sources directory

if [ ! -f "wget-list-systemd" ]; then
    echo "Error: wget-list not found in current directory."
    exit 1
fi

# Extract filenames and prepend the Singapore mirror URL
sed -e 's|^.*/||' wget-list-systemd | awk '{print "https://mirror.freedif.org/pub/lfs/lfs-packages/13.0/"$1}' > wget-list-fast

echo "Success: Created wget-list-fast."
