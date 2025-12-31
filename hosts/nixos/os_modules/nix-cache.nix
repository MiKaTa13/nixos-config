{...}: {
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org-1:mB9rLzDhxTpGmX2u4MSs7sKMHM9dV8b+I0bW255V2Zo="
    ];
  };
}
