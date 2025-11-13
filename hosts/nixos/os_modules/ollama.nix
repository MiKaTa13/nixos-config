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
  # Create user for ollama.
  users.users.svc-ollama = {
    isSystemUser = true;
    group = "svc-ollama";
    description = "Ollama AI Service";
  };
  # Create group for ollama.
  users.groups.svc-ollama = {};
}
