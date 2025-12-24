{...}: {
  services.redshift = {
    enable = true;
    settings = {
      # Example of a [redshift] section with keys/values
      redshift = {
        adjustment-method = "randr";
        gamma-day = 0.8;
        gamma-night = 0.6;
        fade = 1;
      };
    };
    temperature = {
      day = 5500;
      night = 3600;
    };
    latitude = 48.80;
    longitude = 2.33;
  };
}
