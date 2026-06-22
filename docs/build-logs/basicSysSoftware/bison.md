# Package: Bison

**Version:** 3.8.2
**Chapter:** 8.35 (System Software)
**SBU Estimate:** 2.1 SBU

## Overview
The Bison package contains a sophisticated parser generator that replaces the classic Unix `yacc` (Yet Another Compiler Compiler). It is a foundational build tool that reads grammar specifications and generates C/C++ programs designed to analyze the structure of text files and language syntaxes. 

Key components included:
* `bison` (The core parser generator)
* `yacc` (A backwards-compatible wrapper that calls `bison -y` for legacy build scripts)
* `liby.a` (The POSIX-required Yacc library containing standard `main` and `yyerror` implementations)

## Security / Custom Modifications
- **FHS Documentation Isolation:** Explicitly configured with `--docdir=/usr/share/doc/bison-3.8.2` to ensure the extensive documentation is cleanly sandboxed by version, preventing namespace collisions and adhering strictly to the Filesystem Hierarchy Standard.
- **Legacy Wrapper Deployment:** By deploying the `yacc` wrapper script alongside the primary binary, the system maintains strict compatibility with older POSIX-compliant source code without requiring the actual installation of the outdated, less secure original `yacc` software.

## Build Notes
- **Required Disk Space:** 63 MB
- **Process:** Compiled cleanly in-tree using the standard configuration.
- **Test Suite:** Executed `make check`. For a parser generator, validating the test suite is highly recommended to ensure the AST (Abstract Syntax Tree) generation logic was not subtly corrupted by the compiler during the build phase.
- **Installation:** Standard `make install` execution.
