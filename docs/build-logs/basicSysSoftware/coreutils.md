# Package: Coreutils

**Version:** 9.10
**Chapter:** 8.61 (System Software)
**SBU Estimate:** 1.2 SBU

## Overview
The Coreutils package provides the fundamental suite of standard command-line utilities expected on every POSIX-compliant operating system. These are the core tools utilized for basic file, shell, and text manipulation, serving as the foundation upon which almost all shell scripts and system administration tasks rely.

Key binaries included:
* **File & Directory Management:** `cp`, `mv`, `rm`, `mkdir`, `ls`, `ln`, `touch`
* **Permissions & Ownership:** `chmod`, `chown`, `chgrp`, `chroot`
* **Text & Data Processing:** `cat`, `cut`, `head`, `tail`, `sort`, `wc`, cryptographic hashers (`md5sum`, `sha256sum`, etc.)
* **System & Environment:** `date`, `df`, `du`, `echo`, `env`, `pwd`, `whoami`, `stty`

## Security / Custom Modifications
- **POSIX i18n Patching:** Applied a critical internationalization patch (`coreutils-9.10-i18n-1.patch`) to enforce correct character boundary recognition in multibyte locales. Because this patch alters the fundamental build system, `autoreconf -fv` and `automake -af` were manually invoked to regenerate the configuration files and bypass outdated `gettext` requirements.
- **Root Build Override:** Injected the `FORCE_UNSAFE_CONFIGURE=1` environment variable during the configuration phase. This explicitly overrides Coreutils' built-in safeguard that normally prevents the package from being compiled by the `root` user.
- **Strict FHS Compliance:** Manually relocated the `chroot` binary from `/usr/bin/` to `/usr/sbin/` post-installation. This rigidly enforces the Filesystem Hierarchy Standard, ensuring that environment-altering administrative commands are strictly isolated in the system binary path. Its corresponding manual page was also patched via `sed` to reflect section 8 (System Administration).

## Build Notes
- **Required Disk Space:** 188 MB
- **Process:** Patch application, autotools regeneration, and standard compilation.
- **Test Suite:** Required a highly complex, multi-stage testing procedure to ensure absolute integrity. This involved running root-specific tests (`make check-root`), creating a temporary `dummy` group, recursively modifying source tree permissions, and running the bulk of the test suite as a non-root `tester` user. Standard input was intentionally redirected (`< /dev/null`) to prevent test breakage caused by pseudo-terminal (PTY) inheritance issues from the host machine into the chroot.
- **Installation:** Standard `make install` execution, followed immediately by the manual relocation of `chroot` and its documentation.
