{config, ...}: {
  systemd.user.services.autowallpaper = {
    Unit = {
      Description = "Auto Wallpaper";
    };

    Service = {
      Type = "oneshot";
      Environment = "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/nix/bin"; # Systemd runs with a minimal environment.
      ExecStart = "${config.home.homeDirectory}/.local/bin/auto-wallpaper.sh";
    };
  };

  systemd.user.timers.autowallpaper = {
    Unit = {
      Description = "Auto Wallpaper Timer";
    };

    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
      Unit = "autowallpaper.service";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
