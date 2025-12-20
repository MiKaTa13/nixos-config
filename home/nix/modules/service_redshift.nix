{...}: {
  services.redshift = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature = {
      day = 5500;
      night = 3700;
    };
  };
}
