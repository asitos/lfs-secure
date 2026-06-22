# Package: Groff

**Version:** 1.23.0
**Chapter:** 8.65 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The Groff (GNU troff) package provides a comprehensive suite of programs for processing and formatting text and images. It is the modern GNU implementation of the classic Unix text formatters (`troff` and `nroff`). Within a Linux system, Groff's most critical role is formatting and rendering system manual pages (`man` pages) for terminal display, though it is also highly capable of compiling documents into PDF, PostScript, HTML, and DVI formats.

Key binaries included:
* `groff` (The primary front-end command for the document formatting system)
* `troff` & `nroff` (The core formatting engine and its terminal-emulation counterpart)
* Preprocessors: `eqn` (equations), `tbl` (tables), `pic` (diagrams), and `chem` (chemical structures)
* Output Translators: `gropdf`, `grops`, `grotty`, and `post-grohtml`

## Security / Custom Modifications
- **Locale-Specific Hardcoding:** The build configuration utilizes the `PAGE` environment variable (`PAGE=<paper_size>`) to statically compile the region's default paper size (such as `A4` or `letter`) directly into the formatter's defaults. While hardcoded during this compilation phase, it respects dynamic overrides via the `/etc/papersize` file.
- **System-Wide FHS Compliance:** Configured explicitly with `--prefix=/usr` to ensure all formatters, macro packages, and font metric data are installed strictly within the standard system execution and shared data paths.

## Build Notes
- **Required Disk Space:** 108 MB
- **Process:** Compiled cleanly in-tree using the paper size environmental override and standard GNU Autotools configurations.
- **Test Suite:** Executed `make check` to verify the syntactic parsing, macro expansion, and rendering logic of the core formatting engines. 
- **Installation:** Standard `make install` execution.
