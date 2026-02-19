{
  config,
  lib,
  pkgs,
  ...
}:

{
  fileSystems."/data/vault" = {
    device = "//vault/data";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=1000" ];
  };
}
