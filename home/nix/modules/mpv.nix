{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    bindings = {
      WHEEL_UP = "seek 10";
      WHEEL_DOWN = "seek -10";
      "Alt+0" = "set window-scale 0.5";
    };
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };
    defaultProfiles = [
      "gpu-hq"
    ];
    scripts = [
      # List of scripts to use with mpv.
      pkgs.mpvScripts.mpris
    ];
  };
}
