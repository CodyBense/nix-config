{ config, lib, pkgs, ... }:

{
  # Tailscale
  config.services.tailscale.enable = true;

  config.services.postgress = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      # type database DBuser auth-method
        local all all trust
    '';
  };
}
