{pkgs, ...}: let
  keyboardProfile = pkgs.writeText "kbd_led_profile" ''
    # Green Profile
    a 00ff00 # Set all keys green
    k escape ff0000
    c # Commit changes
  '';
  keyboardProfileSleep = pkgs.writeText "kbd_led_sleep_profile" ''
    fx breathing all ff0000 30 # Set breathing effect with red color and speed 30
  '';
  ledManager =
    pkgs.writeShellScriptBin "led_manager"
    ''
      G810="${pkgs.g810-led}/bin/g810-led"
      PROFILE="${keyboardProfile}"
      PROFILE_SLEEP="${keyboardProfileSleep}"

      IDLE_LIMIT=300 # seconds (5 minutes)
      CHECK_INTERVAL=1

      $G810 -p $PROFILE
      led_state=on

      while :; do
          idle_ms=$(${pkgs.xprintidle}/bin/xprintidle)
          idle_sec=$(( idle_ms / 1000 ))

          if (( idle_sec >= IDLE_LIMIT )) && [[ $led_state == "on" ]]; then
              $G810 -p $PROFILE_SLEEP
              led_state=off
          fi

          if (( idle_sec < IDLE_LIMIT )) && [[ $led_state == "off" ]]; then
              $G810 -p $PROFILE
              led_state=on
          fi

          ${pkgs.coreutils}/bin/sleep "$CHECK_INTERVAL"
      done
    '';
in {
  systemd.user.services = {
    keyboard-led = {
      Unit = {
        Description = "Set keyboard led";
      };

      Service = {
        Type = "simple";
        ExecStart = "${ledManager}/bin/led_manager";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
