# Package: GDBM

**Version:** 1.26
**Chapter:** 8.39 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The GDBM package provides the GNU Database Manager. It operates as a core library of database functions utilizing extensible hashing, functioning similarly to the standard UNIX `dbm`. It provides the foundational primitives for storing, searching, retrieving, and deleting key/data pairs.

Key utilities and libraries included:
* `gdbmtool` (Utility to test and modify a GDBM database)
* `gdbm_dump` & `gdbm_load` (Tools for backing up and restoring databases)
* `libgdbm.so` (The primary hashed database library)
* `libgdbm_compat.so` (Compatibility library containing older DBM functions)

## Security / Custom Modifications
- **Dynamic Linking Enforcement:** Configured with `--disable-static` to ensure only shared libraries are built. This prevents dependent packages from statically compiling GDBM functions into their binaries, guaranteeing that any future security patches applied to the GDBM library immediately protect the entire system.
- **Legacy Application Support:** Explicitly passed `--enable-libgdbm-compat` to generate the compatibility library. This ensures that third-party or older packages compiled outside the strict LFS ecosystem can still securely interface with the database manager using legacy DBM API routines without needing local workarounds.
- **FHS Compliance:** Standard `--prefix=/usr` applied to ensure the libraries and binaries are installed strictly within the correct system-wide hierarchy.

## Build Notes
- **Required Disk Space:** 13 MB
- **Process:** Compiled cleanly in-tree using standard configurations.
- **Test Suite:** Executed `make check` to verify the integrity of the extensible hashing algorithms and key-value retrieval logic prior to installation.
- **Installation:** Standard `make install` execution.
