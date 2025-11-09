{pkgs, ...}: {
  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-curses; # pinentry agent
      # pinentry.package = pkgs.pinentry-tty; # pinentry agent
    };
  };
}
