# Package: gpgmepp (GPGME C++ Wrapper)

**Version:** 2.0.0
**Chapter:** BLFS Security / Cryptography
**SBU Estimate:** 0.1 SBU

## Overview
The `gpgmepp` package provides a native C++ wrapper for the `gpgme` (GnuPG Made Easy) library. It allows C++ applications to seamlessly integrate cryptographic capabilities—such as encryption, decryption, signing, and key management—using idiomatic C++ interfaces and objects rather than interacting directly with the underlying C API.

## Security / Custom Modifications
- **Out-of-Source Build:** Enforced a dedicated `build` directory (`mkdir build && cd build`) to maintain source tree hygiene, which is highly recommended for CMake-driven build systems.
- **System FHS Prefix:** Explicitly set the installation prefix to `/usr` (`-D CMAKE_INSTALL_PREFIX=/usr`) to ensure the compiled shared object (`libgpgmepp.so`), headers (`/usr/include/gpgme++`), and CMake configuration files (`/usr/lib/cmake/Gpgmepp`) are correctly registered in standard system paths for downstream linking.

## Build Notes
- Configured from the dedicated `build` directory using `cmake`.
- Compiled the wrapper library via standard `make`.
- **Note:** Upstream does not provide a test suite for this specific package.
- Deployed the binaries and header files using `make install` as root.
