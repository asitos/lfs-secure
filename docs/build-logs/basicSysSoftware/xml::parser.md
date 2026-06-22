# Package: XML::Parser

**Version:** 2.47
**Chapter:** 8.45 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The XML::Parser module is a critical Perl extension that acts as a direct interface to the Expat XML parsing C library (which was installed in Chapter 8.41). It provides the essential bindings required by complex Perl scripts—such as `intltool` and various localization utilities—to efficiently read, process, and manipulate XML data streams.

Key components included:
* `Expat.so` (The dynamically loaded Perl-to-C shared object interface)

## Security / Custom Modifications
- **Native Build System Inheritance:** Configured using Perl's native `Makefile.PL` rather than a standard GNU `configure` script. This natively inherits the strict directory paths, compiler flags, and memory configurations (such as `-D useshrplib`) established during the core Perl interpreter installation, maintaining architectural consistency.
- **Dynamic Dependency Linking:** This module bridges into the system's `libexpat.so`. By leveraging the system-wide dynamic library rather than statically compiling its own parser, it inherently benefits from centralized security patches applied to Expat without requiring the Perl module itself to be rebuilt.

## Build Notes
- **Required Disk Space:** 2.3 MB
- **Process:** Compiled cleanly using the Perl MakeMaker system.
- **Test Suite:** Executed `make test` to verify the integrity of the Perl-to-C API bindings and ensure the XML stream handler functions correctly within the isolated chroot environment.
- **Installation:** Standard `make install` execution.
