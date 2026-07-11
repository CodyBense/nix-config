{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./doom.nix
    ./game.nix
    # ./go.nix
    # ./python.nix
    # ./rust.nix
    # ./tmux.nix
    # ./web.nix
    # ./zig.nix
  ];
}
