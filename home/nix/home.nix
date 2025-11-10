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
    ./modules/lf.nix
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
    ./modules/zathura.nix
    ./modules/nnn.nix
    ./modules/neovim.nix
    ./modules/mpv.nix
    ./modules/xsession.nix
    ./modules/service_picom.nix
    ./modules/service_gpg.nix
    ./modules/service_redshift.nix
    agenix.homeManagerModules.default

    # I use unstable versions which not managed with home-manager.
    # ./modules/ghostty.nix
    # ./modules/qutebrowser.nix
  ];

  # Packages instaled by home-manager.
  home.packages =
    (with pkgs; [
      bc
      btop
      direnv
      fira-code
      feh
      gnumake
      gcc
      htop
      openblas
      pass
      ripgrep
      tree
      w3m
      fd
      nsxiv
      xclip
      offlineimap
      yubikey-manager
      trufflehog # scan for GIT secrets
      xorg.libxcb # qutebrowser
      agenix.packages.x86_64-linux.default

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
      nixd # neovim
      ghostty
      imagemagick
      qutebrowser
      fzf
      gimp3
      age
      nvitop
      python3
      ffmpeg
    ]);
}
