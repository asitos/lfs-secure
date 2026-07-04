# Package: make-ca (Public Key Infrastructure)

**Version:** 1.16.1
**Chapter:** BLFS Security / Certificate Management
**SBU Estimate:** < 0.1 SBU (with all runtime deps)

## Overview
The `make-ca` utility is a shell script designed to download, process, and adapt Mozilla's `certdata.txt` file for use as the local system trust store. It establishes the baseline Public Key Infrastructure (PKI) required to validate the authenticity of remote entities over untrusted networks. This is an absolute prerequisite for secure web browsing, package downloads, and SSL/TLS communications.

## Security / Custom Modifications
- **mktemp Sanitization:** Applied an inline `sed` patch (`sed '/mktemp/s/-t //' -i make-ca`) prior to installation to strip the deprecated `-t` flag. This hardens the script against unpredictable behavior if the `TMPDIR` environment variable is manipulated or set non-standardly.
- **Python Vendored-Cert Override:** Configured a system-wide profile hook (`_PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt` via `/etc/profile.d/pythoncerts.sh`) to force Python's `pip3` to use this centrally managed PKI store. This prevents Python from silently relying on potentially outdated, static, or compromised certificates shipped with modules like `Certifi`.
- **Automated Trust Revocation/Updates:** Activated the systemd timer (`systemctl enable update-pki.timer`) to ensure the certificate revocation lists and trust anchors are automatically synchronized with upstream changes on a weekly basis.

## Build Notes
- Deployed the script to `/usr/sbin` via `make install` and manually initialized the local override directory (`install -vdm755 /etc/ssl/local`) for future custom CA certificates.
- Successfully generated initial certificate stores and trust anchors by executing `/usr/sbin/make-ca -g` as root.
- Source tree successfully destroyed post-installation to maintain cleanroom integrity.
