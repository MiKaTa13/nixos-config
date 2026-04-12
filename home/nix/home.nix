{
  pkgs,
  pkgs-unstable,
  agenix,
  username,
  ...
}: {
  # home setup
  home = {
    inherit username;
    homeDirectory = "/home/${username}"; # Home directory path
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  # The "sd-switch" option is a tool that automatically starts,
  # stops, and reloads systemd services
  # when activating a home-manager generation. Without it,
  # services might not start until after activation completes,
  # creating a chicken-and-egg problem with secrets
  systemd.user.startServices = "sd-switch";

  imports = [
    agenix.homeManagerModules.default
    ./modules/agenix.nix
    ./modules/bash_shell.nix
    ./modules/delta_diff.nix
    ./modules/dmenu.nix
    ./modules/dwmblocks.nix
    ./modules/fzf.nix
    ./modules/dwm.nix
    ./modules/git_config.nix
    ./modules/mpv.nix
    ./modules/msmtp.nix
    ./modules/neomutt.nix
    ./modules/neovim.nix
    ./modules/notmuch.nix
    ./modules/nnn.nix
    ./modules/offlineimap.nix
    ./modules/ollama.nix
    ./modules/python313-libs.nix
    ./modules/qutebrowser.nix
    ./modules/rclone.nix
    ./modules/slop.nix
    ./modules/st.nix
    ./modules/tmux.nix
    ./modules/vim.nix
    ./modules/xsession.nix
    ./modules/zathura.nix
    # services, timers
    ./modules/service_gpg.nix
    ./modules/service_keyboard.nix
    ./modules/service_offlineimap.nix
    ./modules/service_picom.nix
    ./modules/service_redshift.nix
    ./modules/service_wallpaper.nix
  ];

  # Packages installed by home-manager.
  home.packages =
    (with pkgs; [
      age
      agenix.packages.${pkgs.system}.default
      alejandra
      aria2
      bash-language-server
      bat
      bc
      black
      btop
      clang-tools
      direnv
      exiftool
      fd
      feh
      ffmpeg-full
      file
      g810-led # Linux LED controller for some Logitech G Keyboards
      gimp3
      gitleaks
      htop
      imagemagick
      iotop
      irssi
      isort
      libjpeg
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
      remind
      ripgrep
      ruff
      shfmt
      stylua
      tmux
      tree
      unzip
      urlscan # neomutt
      w3m
      wyrd # Text-based front-end to Remind
      xclip
      xorg.libxcb # qutebrowser
      xprintidle
      yubikey-manager
      zip

      # Don't use home-manager switch - it will conflict
      # home-manager
    ])
    ++ (with pkgs-unstable; [
      # list of unstable packages go here
    ]);
}
