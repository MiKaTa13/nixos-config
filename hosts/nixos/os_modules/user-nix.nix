{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      tree
      bc
      # home-manager
      cmatrix
      pinentry-tty
    ])
    ++ (with pkgs-unstable; [
      tmux
      qemu_full
    ]);
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.nix = {
      isNormalUser = true;
      shell = pkgs.bashInteractive;
      useDefaultShell = true;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "input"
        "tty"
      ];
      #openssh.authorizedKeys.keyFiles = ["/home/nix/.ssh/authorized_keys"];
    };
  };
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };
  # Mount HDD at boot.
  fileSystems."/mnt/hdd500" = {
    device = "/dev/disk/by-uuid/6645a581-3fc5-491f-84a1-9a408927f168";
    fsType = "ext4";
    options = ["defaults" "nofail" "noexec" "rw"];
  };
}
