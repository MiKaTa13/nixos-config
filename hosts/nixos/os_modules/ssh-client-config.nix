{...}: {
  programs.ssh = {
    extraConfig = ''
      Host openbsd
          HostName 192.168.1.222
          User misha
          Port 7654
          IdentityFile ~/.ssh/openbsd.key'';
  };
}
