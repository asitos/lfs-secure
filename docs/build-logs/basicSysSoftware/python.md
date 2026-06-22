# Package: Python 3

**Version:** 3.14.3
**Chapter:** 8.53 (System Software)
**SBU Estimate:** 2.6 SBU

## Overview
The Python 3 package provides a widely-used, interpreted, object-oriented programming language and its associated development environment. It serves as a foundational dependency for building applications, system administration scripts, and is heavily utilized by modern Linux systems (including the upcoming Meson build system used by many BLFS packages).

Key components included:
* `python3` (The core Python interpreter)
* `pip3` (The Python package installer)
* `pydoc3` (Documentation generator and viewer)
* `libpython3.14.so` (The shared library used to embed Python into other C/C++ applications)

## Security / Custom Modifications
- **Profile-Guided Optimization (PGO):** Configured with `--enable-optimizations`. This forces a two-stage build where the interpreter is compiled, tested to generate execution profiles, and then recompiled using that data to heavily optimize the final machine code for peak runtime performance.
- **Dynamic Dependency Linking:** Passed `--with-system-expat`. This explicitly overrides Python's default behavior of building an internal, static copy of Expat, forcing it to dynamically link against the system's `libexpat.so` built in Chapter 8.41. This ensures central security patches to the XML parser automatically protect the Python environment.
- **Static Library Eradication:** Configured with `--enable-shared` and `--without-static-libpython` to ensure only the dynamic `libpython3.14.so` is built, strictly enforcing dynamic linking across the system.
- **Package Manager Adaptation (`pip.conf`):** By default, `pip3` aggressively warns against running as `root` to prevent conflicts with host package managers (like `dpkg` or `rpm`). Since LFS *has* no system-wide package manager and relies entirely on source-built architectures, a custom `/etc/pip.conf` is injected to permanently suppress these warnings and disable internet-based version checks within the isolated chroot.

## Build Notes
- **Required Disk Space:** 494 MB
- **Process:** Compiled cleanly in-tree, though significantly extended in duration due to the double-build PGO step.
- **Test Suite:** Executed with `make test TESTOPTS="--timeout 120"` to enforce a strict 2-minute timeout per test. This prevents known, occasional deadlocks within the massive Python test suite from infinitely hanging the overall LFS build process.
- **Installation:** Standard `make install`, followed by the manual creation of `/etc/pip.conf` and the careful extraction of the HTML documentation tarball (using `--no-same-owner` and `--no-same-permissions` to forcefully align file ownership with the current root environment).
