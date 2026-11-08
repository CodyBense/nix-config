{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    tmux
    tmuxPlugins.tmux-sessionx
    tmuxPlugins.tmux-fzf
    tmuxPlugins.resurrect
  ];

  environment.pathsToLink = [ "/share/tmux-plugins" ];
}
