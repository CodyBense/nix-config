{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nodejs
    typescript-language-server
    vscode-langservers-extracted
  ];
}
