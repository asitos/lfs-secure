# Package: Tcl

**Version:** 8.6.17
**Chapter:** 8.17 (System Software)
**SBU Estimate:** 2.9 SBU

## Overview
The Tcl (Tool Command Language) package provides a robust, general-purpose scripting language. In the context of an LFS build, Tcl is the foundational dependency for the `Expect` and `DejaGNU` packages, which are strictly required to execute the critical test suites for core toolchain components like Binutils and GCC.

## Security / Custom Modifications
- **Rpath Hardening:** Passed `--disable-rpath` to the configure script. This explicitly prevents the compiler from hardcoding library search paths (`rpath`) into the compiled binaries and shared libraries, neutralizing potential path-hijacking security vulnerabilities.
- **Build-Path Scrubbing:** Executed an extensive set of `sed` commands immediately after compilation. This scrubbed all hardcoded, temporary source directory paths (`$SRCDIR`) from the generated configuration files (`tclConfig.sh`, `tdbcConfig.sh`, and `itclConfig.sh`) and replaced them with standard FHS install paths (`/usr/lib`, `/usr/include`).
- **Permissions Fixes:** Manually adjusted permissions on the static stub library (`chmod 644`) and made the main shared library writable (`chmod u+w /usr/lib/libtcl8.6.so`). Making the shared library writable is a critical step to ensure that debugging symbols can be successfully stripped from it later in the build.
- **Header Exposure:** Explicitly executed `make install-private-headers`. The upcoming `Expect` package strictly requires access to Tcl's internal headers to compile successfully.
- **Namespace Collision Fix:** Renamed the `Thread.3` manual page to `Tcl_Thread.3` to prevent a direct file conflict with an upcoming Perl man page.
- **Symlinking & Docs:** Established a generic `tclsh` symlink pointing to the versioned `tclsh8.6` binary, and manually unpacked the HTML documentation tarball into the system's `doc` tree.

## Build Notes
- **Required Disk Space:** 91 MB
- **Process:** The configuration and build process must be executed from within the `unix` subdirectory of the source tree, rather than the root directory.
- **Test Suite:** Executed the native test suite passing `LC_ALL=C.UTF-8` to ensure the tests ran in a predictable, standardized locale environment.
