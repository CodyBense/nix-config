{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    gcc
    glibc
    clang
    clang-tools
    cmake
    libtool
    gnumake
    sdbus-cpp
    sqlite
    pciutils
    nixd
    nixfmt
  ];
}
