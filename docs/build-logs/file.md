# Package: File (Temporary Native Tool)

**Version:** 5.45 
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
The File utility determines file types by analyzing binary "magic numbers" rather than relying on file extensions. This package provides both the `file` command and the underlying `libmagic` library.

## Security / Custom Modifications
- **Host Tool Bootstrapping:** Constructed a temporary, isolated host-native version of the `file` binary with host-library dependencies explicitly disabled (`--disable-bzlib`, `--disable-zlib`, etc.). This host binary was explicitly passed to the cross-compiler (`FILE_COMPILE`) to safely generate the target's magic signature database without host contamination.
- **Target Sysroot Mapping:** Configured with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install`.
- **Libtool Scrubbing:** Manually deleted the generated `libmagic.la` (libtool archive) file from `$LFS/usr/lib`. This is a critical security step to prevent `libtool` from misdirecting future linker calls back to the host distribution.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
