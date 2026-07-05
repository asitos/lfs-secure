# Package: NSS (Network Security Services)

**Version:** 3.120.1
**Chapter:** BLFS Security / Cryptography
**SBU Estimate:** 0.8 SBU (with parallelism=4; add 27-42+ SBU for tests)

## Overview
The Network Security Services (NSS) package provides a comprehensive set of libraries for developing cross-platform, security-enabled client and server applications. It implements core Internet security standards including TLS, SSL, PKCS #5/7/11/12, S/MIME, and X.509 v3 certificate handling. 

## Security / Custom Modifications
- **Standalone Build Environment:** Applied the mandatory `nss-standalone-1.patch` to allow the package to build cleanly outside of the Mozilla source tree.
- **System Library Enforcement:** Passed `USE_SYSTEM_ZLIB=1` and `NSS_USE_SYSTEM_SQLITE=1` during the `make` process to force linkage against the system's `zlib` and `sqlite` installations. This prevents the inclusion of potentially vulnerable, bundled in-tree library versions.
- **System CA Trust Integration:** Post-installation, the static internal trust module (`/usr/lib/libnssckbi.so`) is overwritten by a symlink to the `p11-kit` trust module (`ln -sfv ./pkcs11/p11-kit-trust.so /usr/lib/libnssckbi.so`). This critical step ensures NSS-aware applications dynamically inherit the centralized system Certificate Authorities managed by `make-ca`, rather than relying on a hardcoded Mozilla list.

## Build Notes
- **Make-Driven Build:** This package lacks a traditional `./configure` script. Compilation is driven entirely by `make` in the `nss` directory with specific environment variables (e.g., `BUILD_OPT=1` for compiler optimizations without debug symbols, and `USE_64=1` for x86_64 architecture).
- **Test Suite Quirks:** The test suite (`cd tests && HOST=localhost DOMSUF=localdomain ./all.sh`) is exceptionally long (27-42 SBU) and requires an active internet connection. It is known to occasionally fail to kill test servers upon interruption, leading to orphaned processes.
- **Manual Installation:** Binaries, shared objects (`.so`), checksums (`.chk`), archives (`.a`), and headers must be manually installed using `install` and `cp` commands from the `dist` directory to their respective `/usr` hierarchies.
