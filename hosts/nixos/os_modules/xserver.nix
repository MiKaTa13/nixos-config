{...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    xkb.layout = "fr";
    xrandrHeads = [
      {
        # left
        output = "DP-1";
        primary = true;
        monitorConfig = ''Option "Position" "0 0"'';
      }
      {
        # right
        output = "HDMI-0";
        monitorConfig = ''Option "Position" "1920 0" '';
      }
    ];
  };
}
