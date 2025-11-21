{
  pkgs,
  username,
  ...
}: {
  users = {
    # Normal user
    users.${username} = {
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
  };
}
