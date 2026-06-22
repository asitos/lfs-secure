# Package: Findutils

**Version:** 4.10.0
**Chapter:** 8.64 (System Software)
**SBU Estimate:** 0.7 SBU

## Overview
The Findutils package provides essential utilities for searching the file system. It includes tools for recursively scanning directory trees in real-time, querying pre-built file databases for rapid lookups, and passing found file paths as arguments to other commands.

Key binaries included:
* `find` (Recursively searches directory trees based on specific criteria like name, size, or modification time)
* `locate` (Rapidly searches a pre-built database of file names)
* `updatedb` (Scans the file system to build or update the database used by `locate`)
* `xargs` (Reads streams of data from standard input and builds/executes command lines)

## Security / Custom Modifications
- **Strict FHS Compliance:** Configured explicitly with `--localstatedir=/var/lib/locate`. This is a critical adjustment that overrides the default configuration, ensuring that the global `locate` database is written to the `/var` directory hierarchy (specifically intended for variable, system-generated data) rather than cluttering binary or static data paths, strictly adhering to the Filesystem Hierarchy Standard.

## Build Notes
- **Required Disk Space:** 62 MB
- **Process:** Compiled cleanly in-tree using standard GNU Autotools configurations.
- **Test Suite:** The test suite required execution as a non-root user to ensure strict validation of file permission handling. The source tree ownership was recursively shifted (`chown -R tester .`), and the tests were executed within the unprivileged `tester` user context (`su tester -c "PATH=$PATH make check"`).
- **Installation:** Standard `make install` execution.
