# Package: MarkupSafe

**Version:** 3.0.3
**Chapter:** 8.76 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
MarkupSafe is a fundamental Python module that implements a custom string type that escapes characters so they are safe to use in HTML and XML contexts. It is a critical dependency used to prevent Cross-Site Scripting (XSS) attacks in Python-based templating engines, most notably Jinja2 (which is installed in the subsequent chapter and utilized heavily by modern build systems like Meson and documentation generators like Sphinx).

## Security / Custom Modifications
- **Strict Offline Enforcement:** Built and installed utilizing localized, offline Python packaging flags (`--no-build-isolation`, `--no-deps`, and `--no-index`). Within the strictly controlled LFS chroot, these flags securely prevent `pip3` from attempting to resolve or fetch unverified dependencies from the public Python Package Index (PyPI).
- **Cache Pollution Prevention:** Configured to compile the package directly into a local `.whl` archive (`-w dist`) while explicitly bypassing the root user's global cache (`--no-cache-dir`). This guarantees a clean, auditable installation strictly sourced from the provided tarball without leaving residual artifacts in the host's root directories.

## Build Notes
- **Required Disk Space:** 692 KB
- **Process:** Compiled utilizing the recently bootstrapped Python `pip3` and `wheel` utilities to generate a standard Python wheel archive.
- **Test Suite:** No test suite is provided with the source distribution.
- **Installation:** Deployed via `pip3 install`, pulling directly from the locally generated `.whl` file in the `dist` directory.
