{
  pkgs,
  username,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./dotfiles.nix
    ./emacs.nix
    ./git.nix
  ];

  # home-manager settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  # Place files in home dir
  # home.file."</desired/path>" = { source = </path/>; recursive; };

  # Scripts
  home.packages = [
    # (import <path> {inheirt pkgs;})
  ];

  # uwsm

  # Let home-manager install and manage itself
  programs.home-manager.enable = true;
}
