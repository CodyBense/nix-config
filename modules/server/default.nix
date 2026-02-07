{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./tailscale.nix
    ./minecraft.nix
    ./nixarr.nix
    ./immich.nix
  ];
}
