# Package: Coreutils (Temporary Native Tool)

**Version:** 9.6 
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.3 SBU

## Overview
Coreutils provides the fundamental CLI utilities required by every Linux operating system (e.g., `ls`, `cp`, `rm`, `cat`). This cross-compiled version populates the target sysroot with native tools required for the upcoming `chroot` transition.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install` to prevent overriding the Arch host's core utilities.
- **Binary Selection Tuning:**
  - Explicitly enabled the compilation of `hostname` (`--enable-install-program=hostname`), which is disabled by default but strictly required by the upcoming Perl test suite.
  - Explicitly disabled `kill` and `uptime` (`--enable-no-install-program=kill,uptime`) to prevent collisions with upcoming specialized packages (like `procps-ng` or `util-linux`) that provide superior, system-specific implementations of these commands.
- **FHS Hardcoding Fix:** Manually relocated the `chroot` binary and its man page from `/usr/bin` to `/usr/sbin`. While arbitrary in a temporary environment, this guarantees compatibility with external build scripts that strictly expect `chroot` to reside in the system administration directory (`sbin`).

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
