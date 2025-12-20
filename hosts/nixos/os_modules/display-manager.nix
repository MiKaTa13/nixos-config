{...}: {
  services = {
    displayManager = {
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
          animation_timeout_sec = 0;
          auth_fails = 5;
          box_title = "null";

          # Erase password input on failure
          clear_password = true;

          # Brightness decrease key, or null to disable
          brightness_down_key = "";

          # Brightness increase key, or null to disable
          brightness_up_key = "";
        };
      };
    };
  };
}
