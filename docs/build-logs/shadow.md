# Package: Shadow

**Version:** 4.19.3
**Chapter:** 8.29 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Shadow package contains the core utilities required to handle passwords and user/group administration securely (e.g., `useradd`, `passwd`, `su`, `login`). By implementing "shadowed" passwords, it separates the system's encrypted passwords from the publicly readable `/etc/passwd` file, moving them into the strictly protected `/etc/shadow` file.

## Security / Custom Modifications
- **Redundancy Scrubbing (Coreutils & Man-pages):** Used `sed` and `find` to explicitly prevent the compilation and installation of the `groups` program and several manual pages (`getspnam.3`, `passwd.5`), as vastly superior versions were already installed by `Coreutils` and the `Man-pages` package earlier in the build.
- **Cryptographic Hardening:** Manipulated `/etc/login.defs` via `sed` to discard the insecure, default `DES` encryption method. Instead, it was hardcoded to use `YESCRYPT`, a highly secure algorithm resistant to GPU-based attacks.
- **Path Hardening:** Removed the redundant `/bin` and `/sbin` directories from the default user `PATH` inside `/etc/login.defs`. Since these directories are simply symlinks to their `/usr` counterparts in our clean LFS system, including them can break subsequent BLFS builds.
- **Algorithm Support:** Configured the build with `--with-bcrypt` and `--with-yescrypt` to ensure the binaries natively interface with the hardened `libxcrypt` backend we just installed.
- **2038-Aware Configuration:** Configured with `--disable-logind`, forcing the `login` utility to fall back to using `/run/utmp` for session tracking (as `logind` is not yet present). 
- **Namespace Hardening:** Restricted the maximum group name length to 32 characters (`--with-group-name-max-length=32`) to safely align with the system's maximum user name length.
- **Shadow Activation & Default Groups:** Post-installation, the `pwconv` and `grpconv` utilities were manually executed to actively generate the secure `/etc/shadow` and `/etc/gshadow` files. Finally, the default system `useradd` configuration was initialized to assign a default GID of 999.

## Build Notes
- **Required Disk Space:** 115 MB
- **Process:** Heavy pre-configuration patching via `sed` was required before running a standard build pipeline. *Note:* A dummy file (`touch /usr/bin/passwd`) was required before configuration to prevent path hardcoding errors.
- **Test Suite:** This package does not include an upstream test suite.
- **Post-Install Action (CRITICAL):** Immediately after configuring the shadow files, the system `root` password was successfully established.
