{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./immich.nix
    ./minecraft.nix
    ./nixarr.nix
    ./pihole.nix
    ./tailscale.nix
  ];
}
