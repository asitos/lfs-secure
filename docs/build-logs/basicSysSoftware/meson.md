# Package: Meson

**Version:** 1.10.1
**Chapter:** 8.59 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Meson package provides a next-generation, high-productivity open-source build system. Designed to be extremely fast and user-friendly, Meson acts as a frontend that reads configuration files (`meson.build`) and generates optimized backend build files, predominantly utilizing the Ninja build system (installed in the previous step) to execute the actual parallel compilation.

Key binaries included:
* `meson` (The core build system executable)

## Security / Custom Modifications
- **Strict Offline Enforcement:** Built and installed utilizing localized, offline Python packaging flags (`--no-build-isolation`, `--no-deps`, and `--no-index`). This enforces a strict, zero-trust build environment by preventing the package manager from implicitly phoning home to the public Python Package Index (PyPI) to fetch unverified or unexpected dependencies.
- **Cache Pollution Prevention:** Configured to compile the package directly into a local `.whl` archive (`-w dist`) while explicitly bypassing the root user's global package cache (`--no-cache-dir`). This guarantees a clean, auditable installation strictly sourced from the provided tarball.
- **Administrative Ergonomics:** Manually mapped and installed the provided shell completion scripts into the standard system hierarchies for both `bash` and `zsh`.

## Build Notes
- **Required Disk Space:** 48 MB
- **Process:** Compiled utilizing the recently bootstrapped Python `pip3` and `wheel` utilities to generate a standard Python wheel archive.
- **Test Suite:** Explicitly skipped. The Meson test suite requires several external packages and software frameworks that fall completely outside the minimal scope of the base Linux From Scratch system.
- **Installation:** Deployed via `pip3 install`, pulling directly from the locally generated `.whl` file in the `dist` directory, followed immediately by the manual deployment of the shell completion scripts.
