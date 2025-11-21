{...}: {
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda"; # null - for disable.
    };
  };
}
