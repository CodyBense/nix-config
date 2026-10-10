{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    gcc
    glibc
    clang
    clang-tools
    cmake
    devenv
    libtool
    gnumake
    sdbus-cpp
    sqlite
    pciutils
    nixd
    nixfmt
  ];
}
