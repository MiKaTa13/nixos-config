{...}: {
  # List services that you want to enable:
  services = {
    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_HL-L2375DW";
        location = "Home";
        deviceUri = "http://localhost:631/printers/Brother_HL-L2375DW_series";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Brother_HL-L2375DW_series";
  };
}
