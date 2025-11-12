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
}
