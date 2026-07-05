# Package: gpgme (Cryptography API Library)

**Version:** 2.0.1
**Chapter:** BLFS Security / Cryptography
**SBU Estimate:** 0.2 SBU (with tests and parallelism=4)

## Overview
The `gpgme` (GnuPG Made Easy) package is a C library designed to integrate cryptography support into applications seamlessly. It acts as a high-level wrapper, making it significantly easier for software to access underlying public key cryptographic engines like GnuPG and GpgSM. It exposes a clean, robust API for core operations including encryption, decryption, signing, signature verification, and key management.

## Security / Custom Modifications
- **Out-of-Source Build:** Enforced an out-of-tree build process (`mkdir build && cd build`) to maintain source tree hygiene and prevent contamination during the build phase.
- **Shared Libraries Only:** Passed `--disable-static` during configuration to strictly prevent the installation of static objects. This ensures that any dependent application must dynamically link to the shared library, allowing for centralized security updates if the library is patched later.

## Build Notes
- Configured from the dedicated `build` directory using `../configure` to target the `/usr` prefix.
- Compiled the binaries via standard `make`.
- Test suite executed using `make -k check` to gracefully handle non-fatal test errors (note: this step requires the previously built `GnuPG-2.5.17` to function properly).
- Installed the resulting binaries and shared object (`libgpgme.so`) via `make install` as root.
