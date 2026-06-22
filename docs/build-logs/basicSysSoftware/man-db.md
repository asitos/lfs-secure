# Package: Man-DB

**Version:** 2.13.1
**Chapter:** 8.80 (System Software)
**SBU Estimate:** 0.3 SBU

## Overview
The Man-DB package provides the standard suite of tools for reading, searching, and managing system manual pages. It relies heavily on the formatting engines provided by Groff and the pipeline management of Libpipeline, which were installed in previous chapters. 

Key binaries included:
* `man` (The primary manual page viewer)
* `mandb` (Creates and updates the searchable manual page database)
* `whatis` & `apropos` (Tools used to search the database for short descriptions or keywords)
* `manpath` (Determines the system search path for manual pages)

## Security / Custom Modifications
- **Privilege Dropping (`--disable-setuid`):** By default, Man-DB attempts to install the `man` binary as a `setuid` program owned by a dedicated `man` user to manage cache files. This configuration overrides that behavior, preventing the binary from gaining elevated privileges, which simplifies the security footprint of the base LFS build.
- **Cache Ownership:** Configured with `--enable-cache-owner=bin` to assign ownership of system-wide manual cache files to the standard `bin` user rather than a dedicated `man` user.
- **Pre-configured Helpers:** Compiled with explicit paths for optional external tools (`--with-browser=/usr/bin/lynx`, `--with-vgrind`, `--with-grap`). While these programs (like the `lynx` text browser) are not installed in base LFS, configuring their paths now ensures Man-DB knows exactly where to find them if you choose to install them later in BLFS.

## Build Notes
- **Required Disk Space:** 44 MB
- **Process:** Configured and compiled cleanly in-tree using standard GNU Autotools configurations.
- **Test Suite:** Executed `make check` to verify the internal text-parsing logic and database management routines.
- **Installation:** Standard `make install` execution.
- **Internationalization:** Man-DB is highly capable of handling non-English manual pages. It automatically detects if manuals located in `/usr/share/man/<ll>` (where `<ll>` is the language code) are UTF-8 encoded. If they are not, it falls back to a hardcoded list of legacy 8-bit character sets (e.g., ISO-8859-1 for Spanish/French, CP1251 for Belarusian/Bulgarian).
