# Package: Gettext

**Version:** 1.0
**Chapter:** 8.34 (System Software)
**SBU Estimate:** 2.1 SBU

## Overview
The Gettext package provides the core infrastructure for system internationalization (i18n) and localization (l10n). It allows programs to be compiled with Native Language Support (NLS), enabling system utilities and shell scripts to output messages in the user's native language via translation message catalogs. Key utilities include message extractors (`xgettext`), catalog compilers (`msgfmt`), and environment manipulators (`envsubst`).

## Security / Custom Modifications
- **Dynamic Linking Enforcement:** Configured with `--disable-static` to prevent the generation of static libraries. This ensures that binaries strictly link dynamically, which reduces system bloat and guarantees that future security patches to Gettext libraries apply system-wide without requiring recompilation of dependent applications.
- **FHS Documentation Compliance:** Explicitly set `--docdir=/usr/share/doc/gettext-1.0` to ensure documentation is correctly isolated and adheres to the Filesystem Hierarchy Standard.
- **Library Permission Hardening:** Manually adjusted the execution permissions on the preloadable intent library (`chmod -v 0755 /usr/lib/preloadable_libintl.so`). This ensures the dynamic linker (`ld.so`) can safely and securely map it into memory via `LD_PRELOAD` without encountering access violations or triggering security warnings.

## Build Notes
- **Required Disk Space:** 447 MB
- **Process:** Compiled cleanly in-tree using the standard configuration.
- **Test Suite:** Executed `make check` to verify the integrity of the message catalog processors and translation extractors prior to installation.
- **Installation:** Standard `make install` execution, followed by the manual `chmod` intervention for library permissions.
