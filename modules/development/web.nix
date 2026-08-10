{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    typescript-language-server
    vscode-langservers-extracted
  ];
}
