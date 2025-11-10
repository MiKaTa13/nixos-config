{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # Lock screen
      ly
      cmatrix

      pinentry-tty
    ])
    ++ (with pkgs-unstable; [
      tmux
      qemu_full
    ]);
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    # Normal user
    users.nix = {
      isNormalUser = true;
      shell = pkgs.bashInteractive;
      useDefaultShell = true;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "input"
        "tty"
      ];
    };
    # Create user for ollama.
    users.svc-ollama = {
      isSystemUser = true;
      group = "svc-ollama";
      description = "Ollama AI Service";
    };
  };
  # Create group for ollama.
  users.groups.svc-ollama = {};
}
