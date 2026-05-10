# Package: File

**Version:** 5.46
**Chapter:** 8.11 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The File package contains a foundational system utility used for determining the type of a given file. Instead of relying on file extensions (which can be easily spoofed or omitted), this utility reads the internal "magic numbers" (signature bytes) of a file to accurately identify its format, architecture, and encoding.

## Security / Custom Modifications
- **Path Enforcement:** Configured with `--prefix=/usr` to ensure the `file` binary, its libraries, and the compiled magic database (`magic.mgc`) are correctly integrated into the FHS-compliant system hierarchy. 
- **Standard Pipeline:** This is a straightforward package requiring no custom patching or manual static-library scrubbing.

## Build Notes
- **Required Disk Space:** 19 MB
- **Process:** Utilized the standard C build sequence (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation to verify that the file identification routines and magic database parsing were functioning correctly under the new system environment.
