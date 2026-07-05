# Package: liboauth (OAuth Core Library)

**Version:** 1.0.3
**Chapter:** BLFS Security / Authentication
**SBU Estimate:** < 0.1 SBU

## Overview
The `liboauth` package provides a collection of POSIX-C functions implementing the OAuth Core RFC 5849 standard. It offers high-level functionality to escape and encode strings according to OAuth specifications, sign network requests, verify OAuth signatures, and perform HTTP requests securely.

## Security / Custom Modifications
- **OpenSSL Compatibility Patch:** Applied the mandatory `liboauth-1.0.3-openssl-1.1.0-3.patch` prior to configuration. This is critical to ensure the legacy library compiles and links correctly against modern OpenSSL API structures and security standards.
- **Shared Libraries Only:** Passed `--disable-static` during configuration to strictly prevent the installation of static objects. This enforces dynamic linking for all dependent applications, ensuring centralized security updates.
- **Crypto Backend:** The package relies on OpenSSL by default for calculating hashes and signatures. (Note: Mozilla NSS can be used as an alternative backend via the `--enable-nss` flag if preferred).

## Build Notes
- Pre-patched the source tree using `patch -Np1` to apply the required OpenSSL fixes.
- Configured via standard `./configure` targeting the `/usr` prefix.
- Compiled the main binary via `make`.
- Test suite successfully validated via `make check`.
- Installed the shared library (`liboauth.so`) via `make install` as root.
- *(Optional)* If Doxygen is installed, documentation can be generated using `make dox` and manually deployed to `/usr/share/doc/liboauth-1.0.3` as root.
