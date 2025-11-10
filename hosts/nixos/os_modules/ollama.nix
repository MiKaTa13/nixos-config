{
  config,
  pkgs,
  ...
}: {
  services = {
    ollama = {
      enable = true;
      acceleration = "cuda"; # null - for disable.
      user = "svc-ollama";
      group = "svc-ollama";
    };
  };
}
