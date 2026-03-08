{lib, ...}: {
  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    autorun = true;
    xkb.layout = "fr";
    xrandrHeads = [
      {
        # left
        output = "DP-1";
        primary = true;
        monitorConfig = ''Option "Position" "0 0"'';
      }
      {
        # right
        output = "HDMI-0";
        monitorConfig = ''Option "Position" "1920 0" '';
      }
    ];
  };
  # BTRFS
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = ["/"];
    interval = "monthly";
  };

  # UDEV
  services.udev = {
    extraRules = ''
      # Needed for logitech led keyboard.
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c33c", MODE="0660", GROUP="input", TAG+="uaccess"
    '';
  };

  # Disabled services
  services.acpid.enable = lib.mkForce false;
}
