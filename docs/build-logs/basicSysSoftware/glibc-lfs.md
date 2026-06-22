# Package: Glibc

**Version:** 2.43
**Chapter:** 8.5 (System Software)
**SBU Estimate:** 12 SBU

## Overview
The Glibc package contains the main C library. It acts as the fundamental interface between the system's application software and the Linux kernel, providing essential routines for memory allocation, file I/O, string manipulation, directory searching, and arithmetic.

## Security / Custom Modifications
- **FHS Compliance Patch:** Applied a patch (`glibc-fhs-1.patch`) to redirect Glibc programs that default to the non-compliant `/var/db` directory, ensuring runtime data is stored in FHS-compliant locations.
- **Stack Smashing Protection:** Explicitly configured with `--enable-stack-protector=strong` to inject additional code checking for buffer overflows, overriding GCC's default settings for maximum security.
- **Library & Binary Path Enforcement:** Forced `libc_cv_slibdir=/usr/lib` to strictly prevent `lib64` usage. Additionally, passed `rootsbindir=/usr/sbin` via `configparms` to ensure utilities like `ldconfig` map correctly.
- **Service & Legacy Trimming:** Configured with `--disable-nscd` to prevent building the deprecated name service cache daemon.
- **Hardcoded Path Scrubbing:** Used `sed` to skip a broken legacy sanity check in the Makefile and patched the `ldd` script to fix a hardcoded path to the executable loader.
- **System Configuration Provisioning:** Manually established crucial system files including the network service switch (`/etc/nsswitch.conf`) and dynamic loader config (`/etc/ld.so.conf`), ensuring the loader resolves `/usr/local/lib` and `/opt/lib`.

## Build Notes
- **Required Disk Space:** 3.5 GB
- **Process:** Compiled completely out-of-tree in a dedicated `build` directory as required by Glibc documentation.
- **Test Suite:** The Glibc test suite was executed and is considered critical. Handled expected, harmless failures natively associated with the LFS chroot environment (such as `io/tst-lchmod` and timeout-sensitive tests like `tst-nss-files-hosts-multi`).
- **Locales & Time:** Installed the core character sets and locale definitions (`localedef`) required for optimal test coverage across the system, alongside configuring the POSIX timezone data (`tzdata2025c`).
