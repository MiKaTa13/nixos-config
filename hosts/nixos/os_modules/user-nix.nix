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
        "wireshark"
        "video"
        "audio"
        "input"
        "tty"
      ];
    };
  };
}
