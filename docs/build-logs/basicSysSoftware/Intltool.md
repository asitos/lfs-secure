# Package: Intltool

**Version:** 0.51.0
**Chapter:** 8.46 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Intltool package provides a critical suite of internationalization (i18n) scripts used to extract translatable strings from various source files (such as XML, `.desktop` files, and Glade UI definitions) and format them into translation templates that the Gettext utility can process. 

Key binaries included:
* `intltoolize` (Prepares a source package to utilize the intltool build infrastructure)
* `intltool-extract` (Generates Gettext-readable C header files from source data)
* `intltool-update` & `intltool-prepare` (Utilities for updating and merging `.po` and `.pot` translation files)
* `intltool-merge` (Injects translated strings back into the final compiled file types)

## Security / Custom Modifications
- **Perl Interpreter Compatibility Patch:** Applied a preemptive `sed` modification (`sed -i 's:\\\${:\\\$\\{:' intltool-update.in`) to escape a right brace character. This specifically neutralizes an unescaped left-brace deprecation warning introduced in Perl 5.22+. Silencing this regex warning prevents dirty `stderr` output from polluting the terminal, which could artificially fail the test suites of dependent packages later in the build.
- **System-Wide FHS Compliance:** Configured explicitly with `--prefix=/usr` to ensure the toolchain aligns with the root filesystem execution path.
- **Documentation Sandboxing:** Manually installed the `I18N-HOWTO` guide into a strictly version-isolated directory (`/usr/share/doc/intltool-0.51.0`) post-build to maintain clean filesystem hierarchy and prevent future namespace collisions.

## Build Notes
- **Required Disk Space:** 1.5 MB
- **Process:** Compiled cleanly in-tree following the manual Perl syntax patch.
- **Test Suite:** Executed `make check` to strictly verify the regex pattern matching and string extraction logic within the isolated chroot environment.
- **Installation:** Standard `make install` execution, followed immediately by the explicit installation of the supplemental documentation.
