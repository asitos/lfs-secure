# Package: Grep

**Version:** 3.12
**Chapter:** 8.36 (System Software)
**SBU Estimate:** 0.5 SBU

## Overview
The Grep package provides essential text-filtering utilities used to search files for specific patterns or regular expressions. It is a critical dependency for both daily administrative tasks and the build scripts of nearly every other package in the Linux ecosystem. 

Key binaries included:
* `grep` (The core text-searching utility using basic regular expressions)
* `egrep` (Legacy wrapper for `grep -E`, processing extended regular expressions)
* `fgrep` (Legacy wrapper for `grep -F`, processing strictly fixed string searches)

## Security / Custom Modifications
- **Stderr Pollution Prevention (The `egrep` Patch):** Applied a pre-compilation `sed` modification (`sed -i "s/echo/#echo/" src/egrep.sh`) to permanently silence the obsolescence warnings hardcoded into the `egrep` and `fgrep` wrappers. If left unpatched, these warnings bleed into the standard error (`stderr`) streams of other packages later in the LFS build process, artificially failing their test suites by creating unexpected output during script execution.
- **Standard FHS Compliance:** Configured explicitly with `--prefix=/usr` to ensure binaries are installed into the correct system-wide hierarchy rather than falling back to host-like defaults.

## Build Notes
- **Required Disk Space:** 48 MB
- **Process:** Compiled cleanly in-tree immediately following the warning suppression patch.
- **Test Suite:** Executed `make check` to mathematically verify that the regular expression matching engines (Basic, Extended, and PCRE if linked) operate flawlessly within the isolated chroot.
- **Installation:** Standard `make install` execution.
