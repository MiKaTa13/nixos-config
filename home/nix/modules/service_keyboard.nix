{pkgs, ...}: let
  keyboardProfile =
    pkgs.writeText "kbd_led_profile"
    ''
      # Green Profile
      a 00ff00 # Set all keys green
      k escape ff0000
      c # Commit changes
    '';
  keyboardProfileSleep =
    pkgs.writeText "kbd_led_sleep_profile"
    ''
      fx breathing all ff0000 25 # Set breathing effect with red color and speed 30
      c # Commit changes
    '';
  ledManager =
    pkgs.writeShellScriptBin "led_manager"
    ''
      G810="${pkgs.g810-led}/bin/g810-led"
      SED="${pkgs.gnused}/bin/sed"
      XSET="${pkgs.xorg.xset}/bin/xset"
      SLEEP="${pkgs.coreutils}/bin/sleep"

      PROFILE="${keyboardProfile}"
      PROFILE_SLEEP="${keyboardProfileSleep}"

      IDLE_LIMIT=300 # seconds (5 minutes)
      CHECK_INTERVAL=1

      $G810 -p $PROFILE
      led_state=on
      
      $G810 -k numlock 00ff00 -c
      numlock_led_state=off
 
      while :
        do
          idle_ms=$(${pkgs.xprintidle}/bin/xprintidle)
          idle_sec=$(( idle_ms / 1000 ))

          numlock_state=$($XSET q | $SED -n 's/^.*Num Lock:\s*\(\S*\).*$/\1/p')
 
          if (( idle_sec >= IDLE_LIMIT )) && [[ $led_state == "on" ]]; then
              $G810 -p $PROFILE_SLEEP
              led_state=off
          elif (( idle_sec < IDLE_LIMIT )) && [[ $led_state == "off" ]]; then
              $G810 -p $PROFILE
              led_state=on
              numlock_state=$numlock_state
          fi

          if [[ $numlock_state == "on" ]] && [[ $numlock_led_state == "off" ]]; then
              $G810 -k numlock ff0000 -c
              numlock_led_state=on
          elif [[ $numlock_state == "off" ]] && [[ $numlock_led_state == "on" ]]; then
              $G810 -k numlock 00ff00 -c
              numlock_led_state=off
          fi

          $SLEEP "$CHECK_INTERVAL"
        done
    '';
in {
  systemd.user.services = {
    keyboard-led = {
      serviceConfig = {
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
      };
      Unit = {
        Description = "Set keyboard led";
      };

      Service = {
        Type = "simple";
        ExecStart = "${ledManager}/bin/led_manager";
        UMask = "0022";
        User = "nix";
        Group = "users";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
