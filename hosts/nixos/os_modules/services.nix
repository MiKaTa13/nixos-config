{...}: {
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
    udev = {
      extraRules = ''
        # Needed for logitech led keyboard.
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c33c", MODE="0660", GROUP="input", TAG+="uaccess"
      '';
    };
  };
}
