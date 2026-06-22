# Package: Wheel

**Version:** 0.46.3
**Chapter:** 8.56 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Wheel package provides the reference implementation of the standard Python wheel packaging format. It includes the `wheel` command-line utility, which is used to unpack, pack, or convert `.whl` archives. Along with Flit-Core and Packaging, it serves as the final core bootstrapping component required to install modern Python modules in the system.

## Security / Custom Modifications
- **Strict Offline Enforcement:** Built and installed using localized, offline flags (`--no-build-isolation`, `--no-deps`, and `--no-index`). Because the chroot environment is isolated, these flags securely prevent `pip3` from attempting to resolve or fetch unverified dependencies from the public Python Package Index (PyPI), forcing it to use only the provided source code.
- **Cache Pollution Prevention:** Configured to compile directly into a local `.whl` archive (`-w dist`) while explicitly bypassing the root user's global cache (`--no-cache-dir`). This guarantees a clean, auditable installation that does not leave residual build artifacts in the system root directories.

## Build Notes
- **Required Disk Space:** 708 KB
- **Process:** Compiled utilizing the `pip3` package manager to generate a standard Python wheel archive.
- **Test Suite:** No test suite is provided or executed during this bootstrap phase.
- **Installation:** Deployed via `pip3 install`, pulling directly from the locally generated `.whl` file in the `dist` directory.
