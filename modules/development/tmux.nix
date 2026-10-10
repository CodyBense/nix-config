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
  ];

  environment.pathsToLink = [ "/share/tmux-plugins" ];
}
