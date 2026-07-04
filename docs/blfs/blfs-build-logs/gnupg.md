# Package: GnuPG (GNU Privacy Guard)

**Version:** 2.5.17
**Chapter:** BLFS Security / Cryptography
**SBU Estimate:** 0.7 SBU (with tests, using parallelism=4)

## Overview
GnuPG (GNU Privacy Guard) is the core GNU toolset for secure communication and data storage. It provides robust capabilities for encrypting data and creating digital signatures. As the stable version, GnuPG 2 features an advanced key management facility and integrates full support for both the OpenPGP Internet standard (RFC2440) and the S/MIME standard. 

## Security / Custom Modifications
- **Out-of-Source Build:** Enforced an out-of-tree build process (`mkdir build && cd build`) as explicitly recommended by upstream developers to maintain source tree integrity and prevent contamination.
- **FHS Compliance:** Explicitly mapped the configuration and state directories (`--sysconfdir=/etc` and `--localstatedir=/var`) to ensure adherence to the Filesystem Hierarchy Standard, keeping system state separate from the `/usr` binaries.
- **Strict Documentation Pathing:** Bound the documentation directory to a version-specific path (`--docdir=/usr/share/doc/gnupg-2.5.17`) to keep the system organized for future security auditing and reference.

## Build Notes
- Configured from the dedicated `build` directory (`../configure`).
- Compiled the main binaries via `make`.
- Manually generated plaintext and non-chunked HTML documentation from the Texinfo sources using `makeinfo` and `make -C doc html`.
- Test suite successfully validated via `make check`.
- Installed binaries with `make install` as root, followed by the manual creation of doc directories and deployment of the generated `.html`, `.txt`, and `.texi` files into `/usr/share/doc/gnupg-2.5.17`.
