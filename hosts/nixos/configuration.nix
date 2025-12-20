# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./os_modules/display-manager.nix
    ./os_modules/network.nix
    ./os_modules/ssh-config.nix
    ./os_modules/printing.nix
    ./os_modules/user-nix.nix
    ./os_modules/nvidia-gpu.nix
    ./os_modules/services.nix
    ./os_modules/firejail.nix
    ./os_modules/keyboard-led.nix
  ];

  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # NixOS specific setup.
  ${username} = {
    settings = {
      experimental-features = ["nix-command" "flakes"]; # Enable flake.
      download-buffer-size = 524288000; # 500 MB
    };
    # garbage collect.
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Load temperature module.
  boot.kernelModules = ["k10temp"];

  # clean /tmp at boot
  boot.tmp.cleanOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Sudo
  security.sudo = {
    enable = true;
    extraRules = [
      # Allow execution of any command by all users in group sudo,
      # requiring a password.
      {
        groups = ["sudo"];
        commands = ["ALL"];
      }
      {
        users = ["nix"];
        commands = [
          {
            command = "/run/current-system/sw/bin/systemctl poweroff";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };

  # LIST PACKAGES INSTALLED IN SYSTEM PROFILE.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    lm_sensors
    xterm
    ly
    cmatrix
    pinentry-tty
    g810-led # Linux LED controller for some Logitech G Keyboards
  ];

  # Config path
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # Mount HDD at boot.
  fileSystems = {
    "/mnt/data0" = {
      device = "/dev/disk/by-uuid/6645a581-3fc5-491f-84a1-9a408927f168";
      fsType = "ext4";
      options = ["defaults" "nofail" "noexec" "rw"];
    };
    "/mnt/data1" = {
      device = "/dev/disk/by-uuid/9fc9e40a-a0c7-4873-9a1a-d8356e48c273";
      fsType = "ext4";
      options = ["defaults" "nofail" "noexec" "rw"];
    };
    "/mnt/data2" = {
      device = "/dev/disk/by-uuid/fb6b8cf9-bdef-4ef6-8ad7-ce01dbdf4bc2";
      fsType = "ext4";
      options = ["defaults" "nofail" "noexec" "rw"];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # ZRAM
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 25;
  };

  # virtual console.
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    useXkbConfig = true; # configure the virtual console keymap from the xserver keyboard settings.
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
