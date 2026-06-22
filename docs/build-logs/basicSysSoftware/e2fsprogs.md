# Package: E2fsprogs

**Version:** 1.47.3
**Chapter:** 8.83 (System Software)
**SBU Estimate:** 2.4 SBU (HDD) / 0.4 SBU (SSD)

## Overview
The E2fsprogs package provides the essential user-space utilities for creating, checking, and maintaining the `ext2`, `ext3`, and `ext4` filesystem families. Since `ext4` remains the default and most widely used filesystem in the Linux ecosystem, these tools (`mke2fs`, `e2fsck`, `resize2fs`, `tune2fs`) are absolutely critical for formatting storage partitions and recovering from filesystem corruption.

Key binaries included:
* **Filesystem Creation:** `mke2fs`, `mkfs.ext2`, `mkfs.ext3`, `mkfs.ext4`
* **Filesystem Checking/Repair:** `e2fsck`, `fsck.ext2`, `fsck.ext3`, `fsck.ext4`
* **Filesystem Modification:** `tune2fs` (adjust parameters), `resize2fs` (grow/shrink)
* **File Attributes:** `chattr` (change attributes like immutability), `lsattr`
* **Debugging/Diagnostics:** `dumpe2fs`, `debugfs`, `badblocks`

## Security / Custom Modifications
- **Out-of-Tree Build:** Following upstream recommendations, E2fsprogs is explicitly built in a separate `build` subdirectory rather than directly within the source tree to prevent build artifact contamination.
- **Dependency Delegation (`--disable-*`):** The configuration explicitly disables the compilation of the `libblkid` and `libuuid` libraries, the `uuidd` daemon, and the generic `fsck` wrapper. These components are stripped because the Util-linux package (installed in the previous step) provides the modern, definitive, system-wide implementations of these exact tools. 
- **Static Library Purge:** After installation, a manual `rm -fv` command is issued to delete useless static libraries (`libcom_err.a`, `libext2fs.a`, etc.), saving space and enforcing dynamic linking against the shared `.so` equivalents.
- **System Documentation Fix:** The package installs a gzipped `libext2fs.info.gz` file but fails to automatically update the system-wide info index. Manual commands are provided to decompress the file and explicitly register it with `install-info`.

## Build Notes
- **Required Disk Space:** 100 MB
- **Process:** Out-of-tree build configured with dependency stripping, compiled natively.
- **Test Suite:** Executed `make check`. 
  - *Known Failure 1:* `m_assume_storage_prezeroed` will predictably fail.
  - *Known Failure 2:* `m_rootdir_acl` will fail if the underlying partition hosting the LFS build is *not* formatted as `ext4` (e.g., if you built LFS on a `btrfs` or `xfs` partition).
- **Installation:** Standard `make install`, static library removal, and manual info-page registration.
- **Configuration Note:** The default behavior of `mke2fs` can be customized via `/etc/mke2fs.conf`. The LFS instructions provide an optional `sed` command to strip the `metadata_csum_seed` feature if you intend to use older, incompatible third-party disk utilities outside of the LFS scope.
