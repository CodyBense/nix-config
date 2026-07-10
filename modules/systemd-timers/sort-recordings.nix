{ pkgs, config, ... }:
{
  systemd.timers."sort-recordings" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Presistent = true;
      Unit = "sort-recordings.service";
    };
  };

  systemd.services."sort-recordings" = {
    script = ''
      ${pkgs.python315}/bin/python ~/nix-config/scripts/sort-recordings.py
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "cody";
    };
  };
}
