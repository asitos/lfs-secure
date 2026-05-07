# Package: Bash (Temporary Native Tool)

**Version:** 5.3
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.2 SBU

## Overview
Bash (Bourne-Again SHell) is the core command-line interpreter for the LFS system. This cross-compiled version will serve as the primary shell when we `chroot` into the isolated environment in Chapter 7.

## Security / Custom Modifications
- **Memory Allocation Override:** Configured strictly with `--without-bash-malloc`. Bash's internal memory allocator is historically known to cause segmentation faults in heavily customized or isolated environments. This flag forces Bash to utilize the rock-solid `malloc` functions from the `glibc` library we compiled in Chapter 5.
- **POSIX Shell Compliance:** Created a hard symlink from `bash` to `$LFS/bin/sh`. Many legacy configure scripts and Makefiles hardcode `#!/bin/sh` as their interpreter; this symlink guarantees that Bash seamlessly catches and executes those POSIX scripts inside the target environment.
- **Target Sysroot Mapping:** Configured with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install` to prevent host contamination.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
