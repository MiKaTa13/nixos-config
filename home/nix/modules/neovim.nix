{pkgs, ...}: {
  programs = {
    neovim = {
      defaultEditor = true;
      enable = true;
      extraPackages = with pkgs; [
        shfmt
        pyright
        alejandra
        deadnix
        nil # language server for Nix
        libclang
        bash-language-server
      ];
      extraPython3Packages = ps: [
        ps.python-lsp-server
      ];
      extraLuaPackages = ps: [
        ps.luasnip
        ps.luautf8
      ];
    };
  };
}
