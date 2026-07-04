# Package: Cyrus SASL (Authentication Library)

**Version:** 2.1.28
**Chapter:** BLFS Security / Authentication
**SBU Estimate:** 0.2 SBU

## Overview
The `Cyrus SASL` package provides a Simple Authentication and Security Layer implementation. It is a critical framework used by connection-based protocols (like SMTP, IMAP, or LDAP) to identify and authenticate users, and optionally negotiate an encrypted security layer between the protocol and the network connection.

## Security / Custom Modifications
- **Secure State Storage:** Forced the `sasldb2` database out of the global `/etc` configuration directory and into `/var/lib/sasl` via `--with-dbpath`, paired with strict `700` permissions on the directory to prevent unauthorized credential access.
- **FHS Compliance:** Set the runtime daemon data path to `/var/run/saslauthd` (`--with-saslauthd`) to adhere to standard Filesystem Hierarchy Standard security practices.
- **Legacy Protocol Omission:** Purposely omitted the insecure `--enable-login` and `--enable-ntlm` configuration flags to prevent the system from falling back to deprecated, plain-text, or easily compromised authentication schemes.
- **Modern Database Backend:** Bound the package to the highly efficient and reliable LMDB backend (`--with-dblib=lmdb`).

## Build Notes
- **Strict Single-Threaded Build:** Forced a single-threaded compilation (`make -j1`) as the upstream build system is known to fail with parallel execution race conditions.
- **Modern Toolchain Patches:** Pre-patched the source to ensure compatibility with modern compilers. Applied the `gcc15_fixes-1` patch followed by `autoreconf -fiv`, and used `sed` to inject missing `#include <time.h>` headers into `lib/saslutil.c` and `plugins/cram.c` for `gcc-14` compatibility.
- **Manual Post-Install:** Executed `make install`, manually created the restricted `/var/lib/sasl` state directory, and copied over legacy HTML documentation.
