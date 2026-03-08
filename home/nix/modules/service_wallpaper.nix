{pkgs, ...}: let
  autoWallpaper = pkgs.writeShellScriptBin "auto-wallpaper" ''
    # Get the current hour in 24-hour format hour ( 0..23).
    HOUR=$(${pkgs.coreutils}/bin/date '+%H')

    # Directories for different times of the day
    WALLPAPERS_DESKTOP_DIR="$HOME/.wallpapers/desktop"
    NIGHT_DIR="$WALLPAPERS_DESKTOP_DIR/night"
    MORNING_DIR="$WALLPAPERS_DESKTOP_DIR/morning"
    DAY_DIR="$WALLPAPERS_DESKTOP_DIR/day"
    EVENING_DIR="$WALLPAPERS_DESKTOP_DIR/evening"

    # feh options
    FEH_OPTS="--no-menus --no-fehbg --bg-fill --recursive --randomize"

    # Check if X server run.
    if ! ${pkgs.xorg.xset}/bin/xset q &>/dev/null; then
        exit 1
    fi

    # Choose wallpaper based on the hour
    case $HOUR in
    0[0-5])
        # Night 00-05
        ${pkgs.feh}/bin/feh $FEH_OPTS "$NIGHT_DIR"
        ;;
    0[6-9])
        # Morning 06-10
        ${pkgs.feh}/bin/feh $FEH_OPTS "$MORNING_DIR"
        ;;
    1[0-6])
        # Day 11-16
        ${pkgs.feh}/bin/feh $FEH_OPTS "$DAY_DIR"
        ;;
    1[7-9] | 2[0-1])
        # Evening 17-21
        ${pkgs.feh}/bin/feh $FEH_OPTS "$EVENING_DIR"
        ;;
    2[2-3])
        # Night 22-23
        ${pkgs.feh}/bin/feh $FEH_OPTS "$NIGHT_DIR"
        ;;
    esac
  '';
in {
  systemd.user.services.autowallpaper = {
    Unit = {
      Description = "Auto Wallpaper";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "oneshot";
      Environment = [
        "HOME=%h"
        "DISPLAY=:0"
        "XAUTHORITY=%h/.Xauthority"
      ];
      ExecStart = "${autoWallpaper}/bin/auto-wallpaper";
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
