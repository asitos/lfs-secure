# Package: Nettle (Low-Level Cryptographic Library)

**Version:** 3.10.2
**Chapter:** BLFS Security / Cryptography
**SBU Estimate:** 0.2 SBU (with tests, using parallelism=4)

## Overview
The `Nettle` package contains a comprehensive, low-level cryptographic library. It is designed to be highly portable and fit easily into various contexts, providing fundamental cryptographic primitives (hashes, ciphers, public-key algorithms) for higher-level security applications like GnuTLS.

## Security / Custom Modifications
- **Shared Libraries Only:** Passed `--disable-static` during configuration to strictly prevent the installation of static archives. This ensures that any dependent application must dynamically link to the shared library, facilitating centralized security patches.
- **Shared Object Permissions:** Executed a manual post-install `chmod -v 755` on `/usr/lib/libhogweed.so` and `/usr/lib/libnettle.so`. This is a critical step to ensure the dynamic linker can properly execute and load these libraries into system processes.

## Build Notes
- Configured via standard `./configure` targeting the `/usr` prefix.
- Compiled the main binaries via `make`.
- Test suite successfully validated via `make check`.
- Deployed binaries via `make install` as root.
- Manually corrected library permissions and created the documentation directory (`/usr/share/doc/nettle-3.10.2`) to deploy the included HTML and PDF manuals.
