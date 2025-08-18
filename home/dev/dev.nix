{ pkgs, ... }:
{
  home.packages = with pkgs; [

    # ──────────────── NIX ────────────────

    # Language Server Protocol support for Nix files
    nixd

    # Automatic formatting of Nix code using RFC style rules
    nixfmt-rfc-style

    # ──────────────── C / C++ ────────────────

    # GNU Compiler Collection: compiles C/C++ (and other) sources into executables
    gcc

    # GNU Debugger: inspect runtime behavior, step through code, examine variables
    gdb

    # GEF (GDB Enhanced Features): adds convenient commands and better UI to GDB
    gef

    # CMake: cross-platform build configuration system generator
    cmake

    # GNU Make: traditional build automation using Makefiles
    gnumake

    # Valgrind: dynamic analysis tool for memory leaks, profiling, and debugging
    valgrind

    # Clang tools: static analysis, linting, and formatting tools from LLVM
    llvmPackages_20.clang-tools

    # ──────────────── PYTHON ────────────────

    # Python 3 interpreter: executes Python scripts and applications
    python3

    # Interactive IPython shell: enhanced REPL with autocomplete and rich display
    python312Packages.ipython

  ];
}

