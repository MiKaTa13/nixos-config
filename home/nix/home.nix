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
    ./modules/ranger.nix
    ./modules/python313-libs.nix
    ./modules/ollama.nix
    ./modules/alacritty.nix
    ./modules/msmtp.nix
    ./modules/notmuch.nix
    ./modules/offlineimap.nix
    ./modules/yt-dlp.nix
    ./modules/neomutt.nix
    ./modules/rclone.nix
    ./modules/agenix.nix
    ./modules/dwm.nix
    ./modules/dmenu.nix
    ./modules/dwmblocks.nix
    ./modules/git-config.nix
    ./modules/vim.nix
    ./modules/shell.nix
    ./modules/tmux.nix
    ./modules/zathura.nix
    ./modules/nnn.nix
    ./modules/neovim.nix
    ./modules/mpv.nix
    ./modules/xsession.nix
    ./modules/qutebrowser.nix
    agenix.homeManagerModules.default

    # services
    ./modules/service_keyboard.nix
    ./modules/service_picom.nix
    ./modules/service_gpg.nix
    ./modules/service_redshift.nix
  ];

  # Packages instaled by home-manager.
  home.packages =
    (with pkgs; [
      # neovim
      # neovim
      clang-tools
      bash-language-server
      lua-language-server
      nil
      prettier
      nerd-fonts.fira-code

      shfmt
      stylua
      lua-language-server
      pyright
      black
      alejandra
      bc
      bat
      btop
      direnv
      fira-code
      feh
      gnumake
      gcc
      htop
      wireshark
      openblas
      remind
      wyrd # Text-based front-end to Remind
      nix-tree
      isort
      isort
      black
      pass
      ripgrep
      tree
      exiftool
      alejandra
      w3m
      file
      fd
      nsxiv
      xclip
      tmux
      urlscan # neomutt
      xprintidle
      libjpeg
      qemu_full
      offlineimap
      yubikey-manager
      unzip
      stylua
      ruff
      trufflehog # scan for GIT secrets
      xorg.libxcb # qutebrowser
      agenix.packages.x86_64-linux.default
      ghostty
      imagemagick
      fzf
      gimp3
      age
      nvitop
      ffmpeg-full
      newsboat
      g810-led # Linux LED controller for some Logitech G Keyboards

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
