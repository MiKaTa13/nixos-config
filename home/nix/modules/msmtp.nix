{secretPath, ...}: {
  programs.msmtp = {
    enable = true;
    configContent = ''
      defaults
      protocol smtp
      auth on
      tls on
      tls_trust_file  /etc/ssl/certs/ca-bundle.crt
      syslog LOG_USER
      logfile ~/.msmtp.log
      timeout 60
      #### GMAIL ####
      account gmail
      host smtp.gmail.com
      tls_starttls off
      port 465
      from misha13kopta@gmail.com
      user misha13kopta@gmail.com
      passwordeval "age -i ~/.ssh/id_ed25519 -d ${secretPath}/gmail-acces.age"
      account default : gmail
    '';
  };
}
