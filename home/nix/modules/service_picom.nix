{pkgs, ...}: {
  services = {
    # Compositor settings.
    picom = {
      enable = true;
      settings = {
        corner-radius = 0;
        blur = {
          method = "gaussian";
          size = 10;
          deviation = 5.0;
        };
        blur-background-exclude = [
          "class_g = 'slop'"
        ];
        unredir-if-possible = false;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        use-ewmh-active-win = true;
        detect-transient = true;
        detect-client-leader = true;
        use-damage = true;
        xrender-sync-fence = true;
        log-level = "warn";
      };
      backend = "glx";
      vSync = true;
      shadow = true;
      shadowOpacity = 0.96;
      opacityRules = [
        "100:name *= 'qutebrowser'"
        "100:name *= 'mpv'"
      ];
      menuOpacity = 1.0;
      shadowExclude = [
        "! name~=''"
        "name = 'xclock'"
        "class_g = 'slop'"
        "class_g = 'dwm'"
        "focused = 1"
        "window_type *= 'menu'"
      ];
      activeOpacity = 1;
      inactiveOpacity = 0.7;
      wintypes = {
        tooltip = {
          fade = true;
          shadow = false;
          opacity = 0.85;
          focus = true;
        };
        dropdown_menu = {shadow = false;};
        popup_menu = {shadow = false;};
        utility = {shadow = false;};
      };
    };
  };
}
