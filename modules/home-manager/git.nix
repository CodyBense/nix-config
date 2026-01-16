{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "CodyBense";
      user.email = "codybense@gmail.com";
    };
    extraConfig.init.defaultBranch = "master";
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
