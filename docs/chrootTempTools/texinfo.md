# Package: Texinfo (Temporary Tools)

**Version:** 7.2
**Chapter:** 7.11
**SBU Estimate:** 0.2 SBU

## Overview
Texinfo is the GNU documentation system. It is installed natively into the temporary toolchain to provide the `makeinfo` utility. This satisfies a strict dependency for several upcoming GNU packages that require `makeinfo` to successfully compile their bundled documentation during the final build phase.

## Architectural Highlights
- **Standard Prefix:** Configured simply with `--prefix=/usr` to map directly into the standard FHS paths of the chroot.
- **Native Installation:** Executed `make install` to directly populate the live filesystem from within the chroot environment.

## Build Notes
- Extracted, configured, and compiled natively inside the chroot.
- Source tree successfully destroyed post-installation.
