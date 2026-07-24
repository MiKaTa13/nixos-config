{pkgs, ...}: {
  programs = {
    neovim = {
      withRuby = false;
      withPython3 = true;
      defaultEditor = true;
      enable = true;
      package = pkgs.neovim-unwrapped;
    };
  };
}
