{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./3d-print.nix
    ./electronics.nix
  ];
}
