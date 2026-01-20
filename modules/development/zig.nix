{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zig
    zig-zlint
    zigimports
  ];
}
