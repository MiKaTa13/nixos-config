{config, ...}: {
  age.secrets.rclone-password = {
    file = ../secrets/gdrive-token.age;
  };

  programs.rclone = {
    enable = true;
    remotes = {
      g-drive = {
        mounts.g-drive = {
          enable = true;
          mountPoint = "/home/nix/Gdrive";
        };
        config = {
          type = "drive";
          hard_delete = true;
        };
        secrets = {
          # Home-manager will inject this at runtime
          token = config.age.secrets.gdrive-token.path;
        };
      };
    };
  };
  # The "sd-switch" option is a tool that automatically starts,
  # stops, and reloads systemd services
  # when activating a home-manager generation. Without it,
  # services might not start until after activation completes,
  # creating a chicken-and-egg problem with secrets.
  systemd.user.startServices = "sd-switch";
}
