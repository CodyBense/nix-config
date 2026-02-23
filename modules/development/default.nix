{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./doom.nix
    ./game.nix
    ./go.nix
    ./python.nix
    ./rust.nix
    ./web.nix
    ./zig.nix
  ];
}
