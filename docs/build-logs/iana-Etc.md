# Package: Iana-Etc

**Version:** 20260202
**Chapter:** 8.4 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Iana-Etc package provides essential data files for network services and protocols. It installs `/etc/protocols` (which describes available DARPA Internet protocols from the TCP/IP subsystem) and `/etc/services` (which provides a mapping between human-readable text names for internet services and their underlying port numbers and protocol types).

## Security / Custom Modifications
- **Static Data Deployment:** No custom compiler flags, patching, or security scrubbing were required. The package consists strictly of static network mapping files that are deployed directly into the system's root configuration directory.

## Build Notes
- **Required Disk Space:** 4.8 MB
- **Process:** This package requires no C/C++ compilation. The entire build process consists merely of staging and copying the raw data files into the target `/etc` directory.
