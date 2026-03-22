{
  config,
  lib,
  pkgs,
  ...
}:

{
  config.services.postgres = {
    enable = true;
    ensureDatabases = [ "test" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method
      local all      all    trust
    '';
  };
}
