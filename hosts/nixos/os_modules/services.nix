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
    btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/"];
      interval = "monthly";
    };

    # UDEV
    udev = {
      extraRules = ''
        # Needed for logitech led keyboard.
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c33c", MODE="0660", GROUP="input", TAG+="uaccess"
      '';
    };

    # syslog-ng
    syslog-ng = {
      enable = true;
      extraConfig = ''
        options {
          flush_lines(0);
          perm(0640);
          create_dirs(yes);
        };

        source s_src {
          system();
          internal();
        };

        destination d_messages {
          file(" /var/log/messages ");
        };

        log {
          source(s_src);
          destination(d_messages);
        };
      '';
    };

    # Disabled services
    acpid.enable = lib.mkForce false;
  };
}
