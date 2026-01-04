{pkgs, ...}: {
  programs = {
    neovim = {
      defaultEditor = true;
      enable = true;
      extraPackages = with pkgs; [
               alejandra
               shfmt
               stylua
               black
               nodePackages.prettier
               sqlite
               ripgrep
               fd
               nodePackages.prettier
               libclang
        bash-language-server
        lua-language-server
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
