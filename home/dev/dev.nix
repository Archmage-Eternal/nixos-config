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
    nixfmt
    python3
    python312Packages.ipython
    valgrind
  ];
}

