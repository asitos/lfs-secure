# Package: SQLite

**Version:** 3.51.2 (Tarball: 3510200)
**Chapter:** 8.52 (System Software)
**SBU Estimate:** 0.4 SBU

## Overview
The SQLite package provides a highly reliable, self-contained, serverless, and zero-configuration transactional SQL database engine. It is arguably the most widely deployed database engine in the world, utilized by numerous local applications (like web browsers and package managers) for internal data storage.

Key components included:
* `sqlite3` (The terminal-based frontend for interactive database queries)
* `libsqlite3.so` (The core SQLite API shared library)

## Security / Custom Modifications
- **Secure Delete Enforcement:** Passed `-D SQLITE_SECURE_DELETE=1` via `CPPFLAGS`. This is a critical security enhancement that forces the database engine to overwrite deleted content with zeros, preventing data remanence and forensically protecting deleted records from recovery.
- **RPATH Hardcoding Prevention:** Executed the build with `make LDFLAGS.rpath=""`. This strictly prevents the compiler from embedding hardcoded library search paths (`rpath`) into the compiled shared libraries. Preventing `rpath` injection avoids unwanted linking behaviors and eliminates a vector for local privilege escalation or library hijacking.
- **Dynamic Linking Enforcement:** Configured with `--disable-static` to ensure that dependent applications link dynamically. This guarantees that any future database vulnerabilities patched in `libsqlite3.so` instantly protect all applications using it.
- **Advanced Capabilities Activation:** Injected additional `CPPFLAGS` to enable advanced column metadata, unlock notifications, and the DBSTAT virtual table, which are strict prerequisites for several higher-level system packages. Additionally, Full Text Search versions 4 and 5 were explicitly enabled (`--enable-fts{4,5}`).

## Build Notes
- **Required Disk Space:** 124 MB
- **Process:** Required unpacking a separate documentation tarball prior to configuration. The build utilized overridden `CPPFLAGS` to inject specific compilation macros without disrupting the user's default `CFLAGS` environment.
- **Test Suite:** No test suite is provided with this specific package distribution.
- **Installation:** Standard `make install` execution, followed by the manual creation of the version-isolated `/usr/share/doc/sqlite-3.51.2` directory and the subsequent copying of the extracted documentation.
