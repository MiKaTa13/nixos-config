{pkgs, ...}: {
  systemd.user.services.offlineimap-sync = {
    Unit = {
      Description = "Sync mailbox with offlineimap";
    };

    Service = {
      Type = "oneshot";
      Environment = [
        "PATH=/etc/profiles/per-user/nix/bin"
        "HOME=%h"
      ]; # Systemd runs with a minimal environment.
      ExecStart = "${pkgs.offlineimap}/bin/offlineimap -o -u quiet";
    };
  };

  systemd.user.timers.offlineimap-sync = {
    Unit = {
      Description = "Offlineimap Timer";
    };

    Timer = {
      # OnCalendar = "hourly";
      OnCalendar = "*:0/5"; # every 5 min
      Persistent = true;
      Unit = "offlineimap-sync.service";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
