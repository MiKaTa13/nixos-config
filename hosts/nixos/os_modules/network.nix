# Network setup.
{...}: {
  networking = {
    enableIPv6 = true; # disable IPv6
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
      allowedTCPPorts = [22 80 443];
      #allowedTCPPorts = [ ]; # Open ports in the firewall.
      #allowedUDPPorts = [ ];
      extraCommands = ''
        # Set default policies to DROP
        iptables -P INPUT DROP
        iptables -P FORWARD DROP
        iptables -P OUTPUT DROP

        # Allow loopback interface
        iptables -I INPUT -i lo -j ACCEPT
        iptables -I OUTPUT -o lo -j ACCEPT

        # Allow established and related connections
        iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
        iptables -I OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

        # Allow ICMP (ping)
        iptables -I INPUT -p icmp -j ACCEPT
        iptables -I OUTPUT -p icmp -j ACCEPT

        # Allow traffic on port 631 for CUPS
        iptables -A OUTPUT -p tcp --dport 631 -j ACCEPT

        # Allow outbound DNS
        iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

        # Allow outbound HTTP/HTTPS
        iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT

        # Allow outbound SMTP (if needed)
        iptables -A OUTPUT -p tcp --dport 25 -m state --state NEW -j ACCEPT

        # Allow outbound IMAP/IMAPS (if needed)
        iptables -A OUTPUT -p tcp --dport 143 -m state --state NEW -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 993 -m state --state NEW -j ACCEPT

        # Allow outbound SSH (if you connect to remote servers)
        iptables -A OUTPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT

        # Drops any incoming packet that does not match a valid connection state
        iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

        # SYN flood protection and rate limiting
        iptables -A INPUT -p tcp --syn -m limit --limit 1/s -j ACCEPT
        iptables -A INPUT -p tcp --syn -j DROP

        # Log dropped packets
        # iptables -A INPUT -j LOG --log-prefix "iptables-dropped: " --log-level 4
        # iptables -A OUTPUT -j LOG --log-prefix "iptables-dropped: " --log-level 4
      '';
    };
  };
}
