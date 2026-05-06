# Phase 1: Host Preparation

**Date:** 06/05/26
**Host System:** Arch Linux
**Target Build Partition:** `/dev/nvme0n1p4`
**Mount Point:** `/mnt/lfs`

## Partition Setup
The target partition was formatted with `ext4` and mounted to `$LFS`. To ensure the host (Arch Linux) remains secure and isolated from the build process, all initial compilation is done via a dedicated, unprivileged `lfs` user.

## Initial Environment Variables
- `LFS=/mnt/lfs`
- `umask 022` : file mode creation mask (umask) to 022, which ensures that newly created files and directories are only writeable by their owner, but are readable and searchable by anyone
