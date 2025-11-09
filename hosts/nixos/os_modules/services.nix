{pkgs, ...}: {
  services = {
    # X server
    libinput.enable = true;
    xserver = {
      enable = true;
      autorun = true;
      xkb.layout = "fr";
    };
    # BTRFS
    btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/"];
      interval = "monthly";
    };
  };
}
