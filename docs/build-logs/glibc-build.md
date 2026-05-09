# Package: Glibc (Build & Installation)

**Version:** 2.43
**Chapter:** 8.5.1 (System Software)
**SBU Estimate:** 12 SBU

## Overview
This phase handles the compilation and installation of the GNU C Library (Glibc), the fundamental interface between the Linux kernel and user-space applications. It provides essential APIs for memory allocation, file operations, string manipulation, and system calls.

## Security / Custom Modifications
- **FHS Compliance Patch:** Applied `glibc-fhs-1.patch` to force Glibc programs to use FHS-compliant locations for runtime data instead of the deprecated `/var/db`.
- **Compiler Protections:** Enforced `--enable-stack-protector=strong` explicitly during configuration to inject buffer overflow checks (stack smashing protection), overriding GCC defaults.
- **Path Hardening:** Set `libc_cv_slibdir=/usr/lib` to strictly prevent the creation or usage of a `lib64` directory, and mapped utilities like `ldconfig` to `/usr/sbin` via `configparms`.
- **Daemon Disablement:** Passed `--disable-nscd` to prevent compiling the deprecated name service cache daemon.
- **Script Scrubbing:** Used `sed` to remove a broken legacy sanity check from the Makefile and to fix a hardcoded path to the executable loader inside the `/usr/bin/ldd` script.

## Build Notes
- **Required Disk Space:** 3.5 GB
- **Process:** Compiled entirely out-of-tree in a dedicated `build` directory.
- **Test Suite:** Executed the critical `make check` suite. Encountered and safely ignored expected host-dependent failures inherent to the LFS chroot environment (e.g., `io/tst-lchmod` and timeout-sensitive `nss` multi-thread tests).
- **Locales:** Installed a comprehensive set of locales using `localedef` (including `C.UTF-8`, `en_US.UTF-8`, etc.) to ensure optimal test suite coverage for future packages.
