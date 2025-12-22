{lib, ...}: {
  services = {
    # X server
    libinput = {
      enable = true;
    };
    xserver = {
      enable = true;
      autorun = true;
      xkb.layout = "fr";
      xrandrHeads = [
        { # left
          output = "DP-1";
          primary = true;
          monitorConfig = ''Option "Position" "0 0"'';
        }
        { # right
          output = "HDMI-0";
          monitorConfig = ''Option "Position" "1920 0" '';
        }
      ];
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
    # Disabled services
    acpid.enable = lib.mkForce false;
  };
}
