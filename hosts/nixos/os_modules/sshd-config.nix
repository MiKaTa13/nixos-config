# sshd options.
{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.openssh
  ];

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = false;
      # require public key authentication for better security
      settings = {
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
        PermitEmptyPasswords = false;
        ChallengeResponseAuthentication = false;
        MaxAuthTries = 3;
        LoginGraceTime = 30;
        ClientAliveInterval = 300;
        ClientAliveCountMax = 2;
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        X11Forwarding = false;
      };
    };
  };
}
