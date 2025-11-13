{
  pkgs,
  username,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
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
