# Package: Psmisc

**Version:** 23.7
**Chapter:** 8.33 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Psmisc package contains essential administrative utilities for displaying information about running processes and managing them. It provides tools that directly interface with the kernel's virtual `/proc` filesystem to track file descriptor usage, process trees, and signal handling. 

Key binaries included: 
* `fuser` (reports PIDs using specific files/filesystems)
* `killall` (terminates processes by name)
* `peekfd` (inspects file descriptors of running processes)
* `prtstat`, `pslog`, and `pstree`.

## Security / Custom Modifications
- **Standard FHS Compliance:** Configured explicitly with `--prefix=/usr` to ensure binaries land strictly within the correct system-wide directory, preserving the clean structure of the root filesystem.
- **Virtual Filesystem Integrity:** Because these tools parse live system data, their successful compilation and execution natively validate the integrity of the `/proc` filesystem mount established earlier during the chroot initialization.

## Build Notes
- **Required Disk Space:** 6.7 MB
- **Process:** Compiled cleanly in-tree using standard configuration.
- **Test Suite:** Executed `make check` to mathematically verify the process parsing logic within the isolated LFS chroot before installation.
- **Installation:** Standard `make install` execution.
