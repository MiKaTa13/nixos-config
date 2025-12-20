{pkgs,...}: {
  systemd.user.services.system-keyboard-led = {
    enable = true;
    after = ["network.target"];
    wantedBy = ["default.target"];
    description = "Set keyboard leds on system startup";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''"${pkgs.g810-led}/bin/g810-led" -a "00ff00" -c'';
    };
  };
}
