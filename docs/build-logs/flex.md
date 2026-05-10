# Package: Flex

**Version:** 2.6.4
**Chapter:** 8.16 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Flex package contains a utility for generating programs that recognize lexical patterns in text. It is a fundamental tool for building compilers and parsers, frequently paired with tools like Bison to process and translate source code.

## Security / Custom Modifications
- **Static Linking Prevention:** Passed `--disable-static` to the configure script to prevent the compilation of static archives, enforcing the use of dynamic shared objects (`.so`) across the system.
- **Path & Documentation Enforcement:** Configured with `--prefix=/usr` and `--docdir=/usr/share/doc/flex-2.6.4` to ensure the binary and versioned documentation cleanly land in FHS-compliant directories.
- **Legacy Compatibility (Lex emulation):** Flex is the modern successor to the older UNIX `lex` tool. Because many legacy build scripts and makefiles still explicitly call `lex`, manual symbolic links were created for both the binary (`/usr/bin/lex` -> `flex`) and the man page (`lex.1` -> `flex.1`). This forces older programs to transparently use `flex` in emulation mode.

## Build Notes
- **Required Disk Space:** 33 MB
- **Process:** Built using the standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation to ensure the lexical analyzer generator correctly interpreted pattern logic on the host system.
