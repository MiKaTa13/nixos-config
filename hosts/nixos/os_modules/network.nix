# Network setup.
{...}: {
  networking = {
    hostName = "nixos"; # Define your hostname.
    # Wake-on-lan.
    # interfaces = {
    #   "enp3s0".wakeOnLan = {
    #     enable = true;
    #     policy = ["magic"];
    #   };
    # };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 8080]; # Open ports in the firewall.
      #allowedUDPPorts = [ ... ];
      extraCommands = "iptables -A INPUT -p icmp -j ACCEPT";
    };
  };
}
