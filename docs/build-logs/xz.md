# Package: Xz (Temporary Native Tool)

**Version:** 5.8.2
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
Xz provides the modern compression and decompression utilities required for `.xz` and `.lzma` formats. This cross-compiled package is strictly required in the target sysroot, as the vast majority of upstream LFS source tarballs utilize Xz compression for maximum efficiency.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` to utilize the cross-toolchain.
- **Library Configuration:** Built with `--disable-static` to conserve space, focusing purely on dynamic shared libraries for the temporary environment.
- **Libtool Scrubbing:** Manually deleted the generated `liblzma.la` (libtool archive) file from `$LFS/usr/lib`. This is a mandatory security step to prevent `libtool` from misdirecting future linker calls back to the host distribution.
- **Cleanroom Installation:** Installed via `make DESTDIR=$LFS install` to isolate the binaries within the target's `/usr/bin` directory.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
