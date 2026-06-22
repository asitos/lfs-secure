# Package: Util-linux

**Version:** 2.41.3
**Chapter:** 8.82 (System Software)
**SBU Estimate:** 0.5 SBU

## Overview
The Util-linux package is one of the largest and most critical suites of utilities in the Linux ecosystem. It provides the fundamental commands required to interact with block devices, manipulate partition tables, format filesystems, mount drives, and manage low-level kernel namespaces. Without these utilities, a Linux system essentially cannot interact with physical storage.

Key utilities included:
* **Storage & Partitions:** `fdisk`, `cfdisk`, `lsblk`, `blkid`, `partx`
* **Filesystem Operations:** `mount`, `umount`, `mkfs.*`, `fsck.*`, `findmnt`
* **Hardware & Terminals:** `hwclock`, `agetty`, `rfkill`, `dmesg`, `lscpu`
* **Process & Namespaces:** `kill`, `unshare`, `nsenter`, `taskset`
* **Libraries:** `libblkid.so`, `libmount.so`, `libuuid.so`

## Security / Custom Modifications
- **Strict Configuration Stripping:** The configuration step is heavily modified with multiple `--disable` and `--without` flags. 
  - Several utilities (like `su`, `chfn`, `chsh`, `login`, and `nologin`) are explicitly disabled because they are either handled better by the previously installed Shadow package or require external PAM libraries not present in base LFS.
  - Python bindings (`--without-python`, `--disable-pylibmount`) are disabled to prevent complex dependency loops.
  - Experimental features like `setpriv` and `runuser` are disabled to maintain strict isolation within the base build.
- **Hardware Clock Pathing:** Set `ADJTIME_PATH=/var/lib/hwclock/adjtime`. This strictly enforces the FHS-compliant location for the hardware clock adjustment file, ensuring time-drift tracking operates correctly across reboots.

## Build Notes
- **Required Disk Space:** 346 MB
- **Process:** Configured with extensive stripping flags and compiled cleanly using standard `make`.
- **Test Suite:** The test suite required execution as the unprivileged `tester` user.
  - *Mock `fstab`:* A dummy `/etc/fstab` file was explicitly created (`touch /etc/fstab`) prior to testing to satisfy specific mounting validation routines.
  - *Kernel Dependencies:* The suite relies heavily on specific host kernel configurations. Tests related to hardlinks require cryptographic hash support (`CONFIG_CRYPTO_SHA256`), and `lsfd` testing requires `CONFIG_NETLINK_DIAG`. Running these tests as `root` is highly dangerous (it can interfere with loopback devices or cause deadlocks if `CONFIG_SCSI_DEBUG` is built-in rather than loaded as a module). Testing as `tester` mitigates these host-system risks.
- **Installation:** Standard `make install` execution.
