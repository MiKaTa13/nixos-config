{pkgs, ...}: {
  services = {
    displayManager = {
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
          animation_timeout_sec = 900;
          auth_fails = 5;
          box_title = "null";

          # Erase password input on failure
          clear_password = true; 

          # Brightness decrease command
          brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%-";

          # Brightness decrease key, or null to disable
          brightness_down_key = "F5";

          # Brightness increase command
          brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%+";

          # Brightness increase key, or null to disable
          brightness_up_key = "F6";
        };
      };
    };
  };
}
