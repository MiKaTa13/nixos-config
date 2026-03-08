{
  pkgs,
  pkgs-unstable,
  agenix,
  ...
}: {
  # home setup
  home = {
    username = "nix"; # Linux username
    homeDirectory = "/home/nix"; # Home directory path
    stateVersion = "25.05";
  };

  # The "sd-switch" option is a tool that automatically starts,
  # stops, and reloads systemd services
  # when activating a home-manager generation. Without it,
  # services might not start until after activation completes,
  # creating a chicken-and-egg problem with secrets
  systemd.user.startServices = "sd-switch";

  imports = [
    agenix.homeManagerModules.default
    ./modules/agenix.nix
    ./modules/alacritty.nix
    ./modules/dmenu.nix
    ./modules/dwmblocks.nix
    ./modules/dwm.nix
    ./modules/git_config.nix
    ./modules/mpv.nix
    ./modules/msmtp.nix
    ./modules/neomutt.nix
    ./modules/neovim.nix
    ./modules/nnn.nix
    ./modules/notmuch.nix
    ./modules/offlineimap.nix
    ./modules/ollama.nix
    ./modules/python313-libs.nix
    ./modules/qutebrowser.nix
    ./modules/ranger.nix
    ./modules/rclone.nix
    ./modules/bash_shell.nix
    ./modules/slop.nix
    ./modules/st.nix
    ./modules/tmux.nix
    ./modules/vim.nix
    ./modules/xsession.nix
    ./modules/zathura.nix

    # sersices, timers
    ./modules/service_gpg.nix
    ./modules/service_keyboard.nix
    ./modules/service_offlineimap.nix
    ./modules/service_picom.nix
    ./modules/service_redshift.nix
    ./modules/service_wallpaper.nix
  ];

  # Packages instaled by home-manager.
  home.packages =
    (with pkgs; [
      age
      agenix.packages.x86_64-linux.default
      alejandra
      alejandra
      aria2
      bash-language-server
      bat
      bc
      black
      black
      btop
      clang-tools
      direnv
      exiftool
      fd
      feh
      ffmpeg-full
      file
      fira-code
      fzf
      g810-led # Linux LED controller for some Logitech G Keyboards
      gcc
      ghostty
      gimp3
      gitleaks
      gnumake
      htop
      imagemagick
      iotop
      isort
      libjpeg
      lua-language-server
      lua-language-server
      nerd-fonts.fira-code
      newsboat
      nil
      nix-tree
      nsxiv
      nvitop
      offlineimap
      openblas
      pass
      prettier
      pyright
      qemu_full
      remind
      ripgrep
      ruff
      shfmt
      stylua
      stylua
      tmux
      tree
      trufflehog # scan for GIT secrets
      unzip
      urlscan # neomutt
      w3m
      wireshark
      wyrd # Text-based front-end to Remind
      xclip
      xorg.libxcb # qutebrowser
      xprintidle
      yubikey-manager
      zip

      ## Note About Using home-manager Command ##
      # Even with home-manager in your PATH,
      # when using the NixOS module integration:
      # Don't use home-manager switch - it will conflict
      # Do use sudo nixos-rebuild switch for applying changes
      # The home-manager command is mainly useful for:
      # home-manager generations - viewing past generations
      # home-manager packages - listing packages
      # home-manager news - viewing news
      home-manager
    ])
    ++ (with pkgs-unstable; [
      # list of unstable packages go here
    ]);
}
