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
  systemd.user.startServices = "sd-switch";
  imports = [
    ./modules/msmtp.nix
    ./modules/msmtp.nix
    ./modules/notmuch.nix
    ./modules/offlineimap.nix
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
    ./modules/ollama.nix
    ./modules/zathura.nix
    ./modules/nnn.nix
    ./modules/neovim.nix
    ./modules/mpv.nix
    # ./modules/qutebrowser.nix
    ./modules/xsession.nix
    # ./modules/ghostty.nix
    ./modules/service_picom.nix
    ./modules/service_gpg.nix
    ./modules/service_redshift.nix
    agenix.homeManagerModules.default
  ];

  # Packages instaled by home-manager.
  home.packages =
    (with pkgs; [
      btop
      direnv
      fira-code
      feh
      gnumake
      gcc
      git
      htop
      openblas
      pass
      ripgrep
      w3m
      python3
      fd
      nsxiv
      imagemagick
      ffmpeg
      xclip
      offlineimap
      yubikey-manager
      nixd
      trufflehog # scan for GIT secrets
      agenix.packages.x86_64-linux.default
    ])
    ++ (with pkgs-unstable; [
      # list of unstable packages go here
      qutebrowser
      fzf
      gimp3
      ghostty
      age
    ]);
}
