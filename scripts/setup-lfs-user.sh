#!/bin/bash
# Sets up the unprivileged 'lfs' user and restricts ownership of the target partition
# Note: This script must be run as root.

if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run as root."
  exit 1
fi

if [ -z "$LFS" ]; then
    echo "Error: LFS variable is not set! Aborting."
    exit 1
fi

echo "Creating 'lfs' group..."
groupadd lfs

echo "Creating isolated 'lfs' user..."
# -s: default shell, -g: primary group, -m: create home, -k: ignore /etc/skel skeleton files
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

echo "Assigning strict ownership of build directories to 'lfs'..."
chown -v lfs $LFS/{usr{,/*},var,etc,tools}

case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

echo "Setup complete. Note: Run 'passwd lfs' manually if a password is required."
