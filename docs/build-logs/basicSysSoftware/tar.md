# Package: Tar

**Version:** 1.35
**Chapter:** 8.73 (System Software)
**SBU Estimate:** 0.6 SBU

## Overview
The Tar (Tape ARchiver) package provides the core archiving utility for the Linux environment. It is used to create, extract, update, and list files within `.tar` archives. This tool is absolutely fundamental to the Linux ecosystem, seamlessly operating alongside compression utilities (such as `gzip` and `xz`) to manage source code distribution, package creation, and system backups.

Key binaries included:
* `tar` (The primary archiving executable)

## Security / Custom Modifications
- **Root Build Override (`FORCE_UNSAFE_CONFIGURE`):** Injected the `FORCE_UNSAFE_CONFIGURE=1` environment variable during the configuration phase. This explicitly forces the build system to execute the `mknod` (make node) capability test as the `root` user. While upstream considers running this test as root dangerous on a live production system, it is perfectly safe and necessary to bypass the warning within the isolated, partially-built LFS chroot environment.
- **System-Wide FHS Compliance:** Configured directly with `--prefix=/usr` to ensure the binary is installed securely into the standard system execution path.

## Build Notes
- **Required Disk Space:** 43 MB
- **Process:** Compiled cleanly in-tree utilizing standard GNU Autotools configurations alongside the root-override variable.
- **Test Suite:** Executed `make check`. *Note:* One specific test (`capabilities: binary store/restore`) is a known expected failure because the base LFS environment lacks SELinux. Depending on whether your Arch Linux host kernel supports extended attributes (xattr) or security labels on your build partition, this test may simply be skipped entirely.
- **Installation:** Executed a standard `make install`, followed immediately by a dedicated command (`make -C doc install-html`) to compile and map the HTML documentation into the standard `/usr/share/doc/tar-1.35` directory.
