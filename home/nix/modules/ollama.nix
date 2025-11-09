{
  config,
  pkgs,
  ...
}: {
  services = {
    ollama = {
      enable = false;
      acceleration = null;
    };
  };
}
