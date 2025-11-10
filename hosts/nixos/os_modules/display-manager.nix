{
  config,
  pkgs,
  ...
}: {
  services = {
    displayManager = {
      ly = {
        enable = true;
        settings = {
          animation = "matrix";
          animation_timeout_sec = 0;
          auth_fails = 5;
          box_title = "null";
          clear_password = false; # Erase password input on failure
        };
      };
    };
  };
}
