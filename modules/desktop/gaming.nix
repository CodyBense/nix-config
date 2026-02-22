{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
  };
}
