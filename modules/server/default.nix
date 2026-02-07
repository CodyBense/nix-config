{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./services.nix
    ./minecraft.nix
    ./nixarr.nix
    ./immich.nix
  ];
}
