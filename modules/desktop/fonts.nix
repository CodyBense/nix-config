{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    terminus_font
    terminus_font_ttf
    # nerdfonts
  ];
}
