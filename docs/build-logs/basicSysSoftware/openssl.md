# Package: OpenSSL

**Version:** 3.6.1
**Chapter:** 8.49 (System Software)
**SBU Estimate:** 1.9 SBU

## Overview
The OpenSSL package provides the foundational cryptographic libraries and management tools required by the system. It is heavily relied upon by other packages (such as OpenSSH, web clients, and email applications) for secure communications, encryption, and hashing.

Key components included:
* `openssl` (The primary command-line tool for utilizing the cryptography functions)
* `libcrypto.so` (Implements a vast array of cryptographic algorithms)
* `libssl.so` (Implements the TLS protocol)
* `c_rehash` (Legacy Perl script for hashing directories, retained for compatibility but structurally superseded by the `openssl rehash` command)

## Security / Custom Modifications
- **Static Attack Surface Eradication:** Explicitly intercepted the installation process using `sed` (`sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile`) to completely prevent the installation of static libraries. Combined with the `shared` configure flag, this strictly enforces dynamic linking system-wide. Consequently, future OpenSSL security updates will automatically protect all dependent applications without requiring tedious recompilations of the entire software stack.
- **Dynamic Compression Linking:** Configured with `zlib-dynamic` to ensure OpenSSL natively utilizes the system's shared zlib library rather than compiling and embedding its own static copy.
- **Namespace Protection:** Executed the installation with `MANSUFFIX=ssl`. This appends a specific suffix to OpenSSL's manual pages, cleanly preventing namespace collisions with other similarly named system utilities.
- **Configuration Isolation:** Passed `--openssldir=/etc/ssl` to guarantee that all security certificates, keys, and global configuration files strictly adhere to the standard system configuration hierarchy, isolated from the standard binary execution paths.
- **FHS Documentation Compliance:** Manually renamed the standard documentation directory post-installation to include the version number (`/usr/share/doc/openssl-3.6.1`) to ensure strict version sandboxing and cleanly merged the auxiliary HTML/text documentation into it.

## Build Notes
- **Required Disk Space:** 981 MB
- **Process:** Compiled using its native `./config` script (as opposed to standard GNU `./configure`).
- **Test Suite:** Executed `HARNESS_JOBS=$(nproc) make test` to run the cryptographic test harnesses in parallel. Expected and ignored a known, harmless failure related to `30-test_afalg.t`. This specific test fails if the underlying Arch host kernel lacks specific AES/CBC crypto user API configurations (`CONFIG_CRYPTO_USER_API_SKCIPHER`). This is a host-kernel limitation and does not compromise the mathematical integrity of the compiled OpenSSL binaries inside the chroot.
- **Installation:** Standard `make install` utilizing the `MANSUFFIX` override, followed by manual documentation routing.
