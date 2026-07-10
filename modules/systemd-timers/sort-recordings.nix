{ pkgs, config, ... }:
{
  systemd.timers."sort-recordings" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Mon *-*-* 08:00:00";
      Unit = "sort-recordings.service";
    };
  };

  systemd.services."sort-recordings" = {
    script = ''
      ${pkgs.python315} ~/nix-config/scripts/sort-recordings.py
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "cody";
    };
  };
}
