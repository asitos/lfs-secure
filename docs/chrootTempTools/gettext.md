# Package: Gettext (Temporary Tools)

**Version:** 0.23 
**Chapter:** 7.7
**SBU Estimate:** 1.5 SBU

## Overview
Gettext provides internationalization and localization (NLS) support. In this temporary phase, we install a minimal subset of tools required to process translation data for subsequent packages.

## Security & Implementation Details
- **Static Build:** Configured with `--disable-shared` to produce standalone binaries that do not depend on external Gettext libraries, which are not yet established in the target sysroot.
- **Selective Installation:** Manually copied `msgfmt`, `msgmerge`, and `xgettext` to `/usr/bin` instead of performing a full `make install`. This prevents the pollution of `/usr/lib` and `/usr/include` with temporary Gettext files that will be properly installed in Chapter 8.

## Build Notes
- Extracted, configured, and compiled natively inside the chroot.
- Verified binaries are present in `/usr/bin`.
