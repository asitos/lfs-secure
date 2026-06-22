# Package: Gzip

**Version:** 1.14
**Chapter:** 8.67 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Gzip package provides the classic, ubiquitous GNU compression utilities based on the Lempel-Ziv (LZ77) algorithm. Beyond just compressing (`gzip`) and decompressing (`gunzip`) files, this suite provides incredibly useful wrapper scripts that allow standard POSIX text manipulation tools to operate directly on compressed archives without needing to manually extract them first.

Key binaries included:
* `gzip` & `gunzip` (The core compression and decompression engines)
* `zcat` (Decompresses directly to standard output, functionally equivalent to `gunzip -c`)
* **Transparent Wrappers:** `zgrep`, `zdiff`, `zcmp`, `zless`, and `zmore` (Allows you to grep, diff, or read compressed files directly on the fly)

## Security / Custom Modifications
- **System-Wide FHS Compliance:** Configured explicitly with `--prefix=/usr` to ensure all compression binaries and their associated transparent wrappers are installed strictly within the standard system execution path. This ensures that downstream build scripts that rely on hardcoded paths to `gzip` will function without failure.

## Build Notes
- **Required Disk Space:** 21 MB
- **Process:** Compiled cleanly in-tree using standard GNU Autotools configurations.
- **Test Suite:** Executed `make check` to strictly verify the mathematical integrity of the LZ77 compression and decompression algorithms, ensuring no data corruption occurs during the archival process.
- **Installation:** Standard `make install` execution.
