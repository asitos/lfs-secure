# Package: Linux API Headers

**Version:** 6.18.10
**Chapter:** 5 (Cross-Compiler Stage 1)
**SBU Estimate:** < 0.1 SBU

## Overview
This package extracts the sanitized Application Programming Interface (API) headers directly from the Linux kernel source tree. 

## Build Notes
- Built strictly according to LFS guidelines. 
- Utilized `make mrproper` to guarantee a completely sterile kernel source tree before extracting the headers.
- Headers were copied directly to `$LFS/usr/include` to ensure the upcoming `glibc` build has the correct definitions to interface with the host kernel architecture.
