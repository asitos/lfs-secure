# Package: GnuTLS (Secure Transport Layer Library)

**Version:** 3.8.12
**Chapter:** BLFS Security / Network Security
**SBU Estimate:** 0.6 SBU (2.0 SBU with tests, using parallelism=8)

## Overview
The `GnuTLS` package contains libraries and userspace tools that provide a secure layer over a reliable transport layer. It implements the IETF's TLS standards (up to TLS 1.3) to prevent eavesdropping, tampering, and message forgery during client/server communication over the Internet. It includes comprehensive support for X.509 certificates, OpenPGP keys, SRP authentication, and the TLS Pre-Shared-Keys (PSK) extension.

## Security / Custom Modifications
- **PKCS #11 Trust Integration:** Configured using `--with-default-trust-store-pkcs11="pkcs11:"` to strictly enforce the use of the PKCS #11 trust store (via `p11-kit-0.26.2`) as the system's centralized trust anchor for all certificate validations. 
- **Documentation Pathing:** Explicitly mapped the documentation directory (`--docdir=/usr/share/doc/gnutls-3.8.12`) to maintain a clean filesystem hierarchy and ensure ease of access for future security auditing.

## Build Notes
- Configured via standard `./configure` with specific trust store and documentation flags.
- Compiled the main binaries via `make`.
- Test suite successfully validated via `make check` to ensure cryptographic integrity.
- Installed binaries and libraries with `make install` as root.
