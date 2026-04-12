# Epsilon Compiler

Epsilon is a custom, statically typed programming language and compiler written in C# (.NET 8.0). It compiles Epsilon source code (`.e` files) directly into 64-bit RISC-V assembly. 

Designed with a focus on systems programming and hardware-software co-design, the compiler provides a complete pipeline: tokenization, AST generation (parsing), optimization, and assembly generation. It also seamlessly hooks into the RISC-V GNU compiler toolchain for linking, and supports executing the compiled binaries via QEMU or a custom Cycle-Accurate Simulator (CAS).

## Features

### Language Features
* **Data Types:** Supports `auto` (64-bit machine word) and `char` (8-bit byte) data types.
* **Memory & Pointers:** Supports local and global variable declarations, multidimensional arrays, and pointer manipulation (address-of `&` and dereference `*`).
* **Control Flow:** Comprehensive branching and looping constructs, including `if / elif / else`, `while`, standard `for` loops, and range-based `for` loops (`in ..`). Supports early exit via `break`, `continue`, `return`, and `exit`.
* **Functions:** First-class support for user-defined functions, including robust support for variadic arguments using `...`, `__VARIADIC_COUNT__`, and `__VARIADIC_ARGS__`.
* **Operators:** A complete suite of arithmetic (`+`, `-`, `*`, `/`, `%`), bitwise (`&`, `|`, `^`, `<<`, `>>`), and relational/logical operators. Fully supports compound assignments (`+=`, `<<=`, etc.).
* **Low-Level Integration:** Supports embedding inline RISC-V assembly directly into the code using the `asm()` block.
* **Preprocessor Directives:** Built-in support for file inclusion (`#include "file.e"`) and macro definitions (`#define`).
* **Standard Library Functions:** Ships with basic essential built-ins linked at compile-time (e.g., `print`, `write`, `strlen`, `stoa`, `unstoa`, `atouns`).

### Compiler Features
* **Optimization Passes:** Includes an `-O` flag that triggers an AST-level optimization step, performing Dead Code Elimination (DCE) and Constant Folding before code generation.
* **Flexible Output:** Can compile directly to an executable binary, or stop at the assembly stage (`.S` file) for manual inspection.
* **Hardware Simulator Integration:** Built-in capability to generate memory initialization files (e.g., Instruction Memory and Data Memory `.mif` and `.txt` files) sized specifically for custom Cycle-Accurate Simulators.
* **AST Inspection:** Internal `Arborist` tool that can reconstruct the code from the Abstract Syntax Tree for debugging the parsing pipeline.

## Pipeline Architecture

1.  **Tokenizer:** Scans the source code, handles preprocessor directives (`#include`, `#define`), and converts the raw text into a stream of semantic tokens.
2.  **Parser:** Consumes tokens to build an Abstract Syntax Tree (AST), checking for syntax rules, type correctness, and arity mismatches in function calls.
3.  **Optimizer (Optional):** Traverses the AST to fold static math operations and eliminate unused code paths/variables.
4.  **Generator:** Traverses the final AST and translates it into standard 64-bit RISC-V assembly instructions, managing stack frames, register allocation (`t0`, `t1`, `t6`, etc.), and scope limits.
5.  **Assembler/Linker Wrapper:** Invokes `riscv64-linux-gnu-gcc` to assemble and link with the written standard libraries, producing the final executable.

## Prerequisites

To build the compiler and compile Epsilon programs, you will need:
* **.NET 8.0 SDK** (To build and run the C# compiler)
* **RISC-V GNU Compiler Toolchain** (`riscv64-linux-gnu-gcc` for linking standard libraries)
* **QEMU** (`qemu-riscv64` for executing the compiled binaries locally)
* **Make** (If utilizing the project's Makefile for testing/batch runs)

## Command-Line Usage

The compiler is invoked via the command line. By default, running it without specific target flags will compile, assemble, link, and generate the executable alongside files needed by the custom simulator.

**Syntax:**
```bash
dotnet run [options] <input_file>
```

**Options:**
* `-o <file>` : Specify the output file path (default: `./a` or `./a.S` if `-S` is used).
* `-S` : Compile only; generate the RISC-V assembly file (`.S`) and exit.
* `-run` : Compile, assemble, link, and immediately run the program using QEMU. Arguments following the input file will be passed to the Epsilon program.
* `-sim` : Compile, assemble, and simulate the program using the custom Cycle-Accurate Simulator (CAS).
* `-O` : Enable compiler optimizations (Constant folding and Dead Code Elimination).
* `-dump` : Retain all generated intermediate files (like the temporary `.S` files) during compilation.
* `-imsize <size>` : Specify the Instruction Memory size for the hardware simulator (Default: 16384).
* `-dmsize <size>` : Specify the Data Memory size for the hardware simulator (Default: 16384).
* `-v` : Enable verbose logging during the compilation and execution steps.
* `-h` / `--help` : Display the help menu.