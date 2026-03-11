{lib, ...}: {
  services.libinput.enable = true;

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
