# Package: Flit-Core

**Version:** 3.12.0
**Chapter:** 8.54 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Flit-Core package contains the distribution-building engine of Flit, a streamlined packaging tool for Python modules. It serves as a critical bootstrapping dependency required to build and install modern Python packages (via the `wheel` format) throughout the remainder of the system construction process.

## Security / Custom Modifications
- **Strict Offline Enforcement:** The build and installation processes explicitly utilize localized, offline flags (`--no-build-isolation`, `--no-deps`, and `--no-index`). Because the isolated LFS chroot currently lacks DNS resolution and network access, these flags securely prevent `pip3` from attempting to resolve or fetch unverified dependencies from the public Python Package Index (PyPI).
- **Cache Pollution Prevention:** Configured to compile the package into a localized wheel archive directly within the source tree (`-w dist`) while bypassing the root user's global cache (`--no-cache-dir`). This guarantees a clean, auditable installation strictly from the provided source tarball using `--find-links dist`.

## Build Notes
- **Required Disk Space:** 1.3 MB
- **Process:** Built and installed utilizing Python's `pip3` package manager rather than standard GNU `make` workflows, reflecting the modern Python bootstrapping sequence.
- **Test Suite:** No test suite is provided or executed for this specific component.
- **Installation:** Deployed via `pip3 install` pulling directly from the locally compiled `.whl` file in the `dist` directory.
