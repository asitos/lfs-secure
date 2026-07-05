# Package: Tripwire (File Integrity Checker)

**Version:** 2.4.3.7
**Chapter:** BLFS Security / System Integrity
**SBU Estimate:** 1.6 SBU (interactive/scripted install)

## Overview
The `Tripwire` package provides a robust host-based intrusion detection system (HIDS) used to verify the integrity of files on the system. It establishes a cryptographic baseline of critical system files and directories and later compares them against this database to detect unauthorized modifications, deletions, or additions.

## Security / Custom Modifications
- **FHS Path Compliance:** Heavily patched the `install.cfg` configuration file via `sed` prior to building to redirect the program database and reports to `/var/lib/tripwire`, and standard documentation/man pages to `/usr/share`, aligning with the Filesystem Hierarchy Standard.
- **Cryptographic Key Pairs:** The installation generates a `site key` (securing the policy and configuration files) and a `local key` (securing the database and reports), which are securely stored in `/etc/tripwire/`.
- **Strict C++ Standards:** Explicitly passed `CPPFLAGS=-std=c++11` during the `make` phase to prevent compilation failures caused by modern GCC defaults (C++17) rejecting legacy codebase conventions.
- **Policy Enforcement:** Post-installation requires compiling a custom plain-text policy file (`twpol.txt`) into a cryptographically signed binary policy via `twadmin --create-polfile`, followed immediately by a baseline database initialization (`tripwire --init`).

## Build Notes
- **Build System Overhaul:** The upstream build system is broken out-of-the-box. Applied `find` and `sed` commands across `Makefile.am` files to fix headers and man pages, followed by `autoreconf -fi` to regenerate the build scripts.
- Configured via standard `./configure` targeting `/usr` and `/etc/tripwire`.
- **No Test Suite:** Upstream does not provide a test suite.
- **Interactive Installation:** The `make install` step is highly interactive, prompting for site/local passwords and MTA configurations. If automating this build, specific `sed` patches against `installer/install.sh` and the `Makefile` are required to inject passwords and bypass terminal input checks.
- Deployed binaries and generated keys via `make install` as root, followed by manually copying the sample policy text files to `/usr/share/doc/tripwire-2.4.3.7`.
