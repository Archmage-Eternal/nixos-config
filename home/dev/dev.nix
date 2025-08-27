{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cmake
    gcc
    gdb
    gef
    gnumake
    llvmPackages_20.clang-tools
    nixd
    nixfmt-rfc-style
    python3
    python312Packages.ipython
    quickshell
    valgrind
  ];
}

