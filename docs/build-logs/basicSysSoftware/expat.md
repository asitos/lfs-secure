# Package: Expat

**Version:** 2.7.4
**Chapter:** 8.41 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Expat package contains a highly efficient, stream-oriented C library specifically designed for parsing XML. It is a critical backend dependency for many system utilities and programming languages (like Python) that need to read or construct XML data structures.

Key components included:
* `xmlwf` (A non-validating utility used to check whether XML documents are well-formed)
* `libexpat.so` (The core API shared library for XML parsing)

## Security / Custom Modifications
- **Dynamic Linking Enforcement:** Configured with `--disable-static` to strictly prevent the creation of static archive libraries. Because Expat is a widely utilized parsing library, forcing dependent packages to link to it dynamically ensures that any future XML-related CVEs or security patches only require updating `libexpat.so`, instantly securing the entire system without recompiling dependents.
- **FHS Documentation Isolation:** Explicitly passed `--docdir=/usr/share/doc/expat-2.7.4` during configuration and manually installed the auxiliary HTML/CSS documentation post-build. This guarantees that documentation is neatly sandboxed by version, preventing namespace collisions and maintaining strict Filesystem Hierarchy Standard compliance.

## Build Notes
- **Required Disk Space:** 14 MB
- **Process:** Compiled cleanly in-tree using standard configurations.
- **Test Suite:** Executed `make check` to verify the mathematical integrity of the XML parsing engine and stream handlers prior to system integration.
- **Installation:** Standard `make install` execution, followed by the explicit manual installation of the provided HTML and CSS documentation files.
