#!/bin/bash
# Creates the initial limited directory layout for LFS targets
# Note: This script must be run as root.

if [ -z "$LFS" ]; then
    echo "Error: LFS variable is not set! Aborting to protect host system."
    exit 1
fi

echo "Creating base hierarchy in $LFS..."
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

echo "Setting up standard symlinks..."
for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

echo "Handling architecture specific directories..."
case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

echo "Creating isolated cross-compiler tools directory..."
mkdir -pv $LFS/tools

echo "Layout complete."
