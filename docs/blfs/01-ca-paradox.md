### Bootstrap Architecture: The CA Paradox
**Status:** Temporary Accepted Risk

**The Problem:** A bare-metal OS build lacks a Root Certificate Authority (CA) store. It has no cryptographic concept of trust, causing `wget` to fail HTTPS verification. You essentially need certificates to securely download certificates.

**The Bypass:** I temporarily bypassed local TLS validation (`--no-check-certificate`) strictly to bootstrap our core privilege separation utilities (like `sudo`).

**The Mitigation:** This is a Phase 1 exception. With user boundaries established, the immediate next step is compiling `make-ca` to establish a trusted Public Key Infrastructure (PKI) within the OS. Once built, strict TLS enforcement will be globally restored for all future network requests.
